From: Hui Peng <benquike@gmail.com>
Subject: Re: [PATCH 1/2] Fix an OOB bug in
	parse_audio_mixer_unit
Date: Fri, 30 Aug 2019 17:49:59 -0400
Message-ID: <CAKpmkkVQ2fbL47JrbVMrfCenPShjjwfkS9MY0Ay5MpyFjftxpg@mail.gmail.com>
References: <20190830214649.27761-1-benquike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com
 [IPv6:2607:f8b0:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8BFFAF800D1
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 23:50:12 +0200 (CEST)
Received: by mail-ot1-x341.google.com with SMTP id 100so8358340otn.2
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 14:50:12 -0700 (PDT)
In-Reply-To: <20190830214649.27761-1-benquike@gmail.com>
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

This is the backported patch of the following bug to v4.4.x and v4.14.x:
daac07156b33 ("ALSA: usb-audio: Fix an OOB bug in parse_audio_mixer_unit")

On Fri, Aug 30, 2019 at 5:47 PM Hui Peng <benquike@gmail.com> wrote:

> The `uac_mixer_unit_descriptor` shown as below is read from the
> device side. In `parse_audio_mixer_unit`, `baSourceID` field is
> accessed from index 0 to `bNrInPins` - 1, the current implementation
> assumes that descriptor is always valid (the length  of descriptor
> is no shorter than 5 + `bNrInPins`). If a descriptor read from
> the device side is invalid, it may trigger out-of-bound memory
> access.
>
> ```
> struct uac_mixer_unit_descriptor {
>         __u8 bLength;
>         __u8 bDescriptorType;
>         __u8 bDescriptorSubtype;
>         __u8 bUnitID;
>         __u8 bNrInPins;
>         __u8 baSourceID[];
> }
> ```
>
> This patch fixes the bug by add a sanity check on the length of
> the descriptor.
>
> CVE: CVE-2018-15117
>
> Reported-by: Hui Peng <benquike@gmail.com>
> Reported-by: Mathias Payer <mathias.payer@nebelwelt.net>
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
>  sound/usb/mixer.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 1f7eb3816cd7..10ddec76f906 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -1628,6 +1628,7 @@ static int parse_audio_mixer_unit(struct mixer_build
> *state, int unitid,
>         int pin, ich, err;
>
>         if (desc->bLength < 11 || !(input_pins = desc->bNrInPins) ||
> +           desc->bLength < sizeof(*desc) + desc->bNrInPins ||
>             !(num_outs = uac_mixer_unit_bNrChannels(desc))) {
>                 usb_audio_err(state->chip,
>                               "invalid MIXER UNIT descriptor %d\n",
> --
> 2.17.1
>
>
