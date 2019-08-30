From: Hui Peng <benquike@gmail.com>
Subject: Re: [PATCH 2/2] Fix a stack buffer overflow bug in
	check_input_term
Date: Fri, 30 Aug 2019 17:51:17 -0400
Message-ID: <CAKpmkkWv2cjrJCkVhGmEMnLG2_kCNxdbt29dZ8j-UM8Cf3quGQ@mail.gmail.com>
References: <20190830214730.27842-1-benquike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0ECD4F800D1
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 23:51:30 +0200 (CEST)
Received: by mail-oi1-x243.google.com with SMTP id t24so6451882oij.13
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 14:51:30 -0700 (PDT)
In-Reply-To: <20190830214730.27842-1-benquike@gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: stable@vger.kernel.org
Cc: Mathias Payer <mathias.payer@nebelwelt.net>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wenwen Wang <wang6495@umn.edu>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This is the backported patch for the following fix to v4.4.x and v4.14.x:
19bce474c45b ("ALSA: usb-audio: Fix a stack buffer overflow bug in
check_input_term")

On Fri, Aug 30, 2019 at 5:47 PM Hui Peng <benquike@gmail.com> wrote:

> `check_input_term` recursively calls itself with input from
> device side (e.g., uac_input_terminal_descriptor.bCSourceID)
> as argument (id). In `check_input_term`, if `check_input_term`
> is called with the same `id` argument as the caller, it triggers
> endless recursive call, resulting kernel space stack overflow.
>
> This patch fixes the bug by adding a bitmap to `struct mixer_build`
> to keep track of the checked ids and stop the execution if some id
> has been checked (similar to how parse_audio_unit handles unitid
> argument).
>
> CVE: CVE-2018-15118
>
> Reported-by: Hui Peng <benquike@gmail.com>
> Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
>  sound/usb/mixer.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 10ddec76f906..e24572fd6e30 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -81,6 +81,7 @@ struct mixer_build {
>         unsigned char *buffer;
>         unsigned int buflen;
>         DECLARE_BITMAP(unitbitmap, MAX_ID_ELEMS);
> +       DECLARE_BITMAP(termbitmap, MAX_ID_ELEMS);
>         struct usb_audio_term oterm;
>         const struct usbmix_name_map *map;
>         const struct usbmix_selector_map *selector_map;
> @@ -709,15 +710,24 @@ static int get_term_name(struct mixer_build *state,
> struct usb_audio_term *iterm
>   * parse the source unit recursively until it reaches to a terminal
>   * or a branched unit.
>   */
> -static int check_input_term(struct mixer_build *state, int id,
> +static int __check_input_term(struct mixer_build *state, int id,
>                             struct usb_audio_term *term)
>  {
>         int err;
>         void *p1;
> +       unsigned char *hdr;
>
>         memset(term, 0, sizeof(*term));
> -       while ((p1 = find_audio_control_unit(state, id)) != NULL) {
> -               unsigned char *hdr = p1;
> +       for (;;) {
> +               /* a loop in the terminal chain? */
> +               if (test_and_set_bit(id, state->termbitmap))
> +                       return -EINVAL;
> +
> +               p1 = find_audio_control_unit(state, id);
> +               if (!p1)
> +                       break;
> +
> +               hdr = p1;
>                 term->id = id;
>                 switch (hdr[2]) {
>                 case UAC_INPUT_TERMINAL:
> @@ -732,7 +742,7 @@ static int check_input_term(struct mixer_build *state,
> int id,
>
>                                 /* call recursively to verify that the
>                                  * referenced clock entity is valid */
> -                               err = check_input_term(state,
> d->bCSourceID, term);
> +                               err = __check_input_term(state,
> d->bCSourceID, term);
>                                 if (err < 0)
>                                         return err;
>
> @@ -764,7 +774,7 @@ static int check_input_term(struct mixer_build *state,
> int id,
>                 case UAC2_CLOCK_SELECTOR: {
>                         struct uac_selector_unit_descriptor *d = p1;
>                         /* call recursively to retrieve the channel info */
> -                       err = check_input_term(state, d->baSourceID[0],
> term);
> +                       err = __check_input_term(state, d->baSourceID[0],
> term);
>                         if (err < 0)
>                                 return err;
>                         term->type = d->bDescriptorSubtype << 16; /*
> virtual type */
> @@ -811,6 +821,15 @@ static int check_input_term(struct mixer_build
> *state, int id,
>         return -ENODEV;
>  }
>
> +
> +static int check_input_term(struct mixer_build *state, int id,
> +                           struct usb_audio_term *term)
> +{
> +       memset(term, 0, sizeof(*term));
> +       memset(state->termbitmap, 0, sizeof(state->termbitmap));
> +       return __check_input_term(state, id, term);
> +}
> +
>  /*
>   * Feature Unit
>   */
> --
> 2.17.1
>
>
