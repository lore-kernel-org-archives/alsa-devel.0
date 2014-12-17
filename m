From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH] usb: add native DSD support for Matrix
	Audio DACs
Date: Thu, 18 Dec 2014 00:52:43 +0800
Message-ID: <CAOf5uwmTGS7SWi1xMCdTMXaZPW+ONMbuxrTcApnP2uvFc0uBsg@mail.gmail.com>
References: <1418834720-4772-1-git-send-email-gtmkramer@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 832A226063D
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 17:52:45 +0100 (CET)
Received: by mail-wg0-f45.google.com with SMTP id b13so21014392wgh.18
 for <alsa-devel@alsa-project.org>; Wed, 17 Dec 2014 08:52:45 -0800 (PST)
In-Reply-To: <1418834720-4772-1-git-send-email-gtmkramer@xs4all.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jurgen Kramer <gtmkramer@xs4all.nl>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

Il 18/dic/2014 00:45 "Jurgen Kramer" <gtmkramer@xs4all.nl> ha scritto:
>
> This patch adds native DSD support for two XMOS based DACs from Matrix
Audio:
> - X-Sabre
> - Mini-i Pro
>
> Signed-off-by: Jurgen Kramer <gtmkramer@xs4all.nl>
> ---
>  sound/usb/quirks.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 4dbfb3d..a739841 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -1245,8 +1245,9 @@ u64 snd_usb_interface_dsd_format_quirks(struct
snd_usb_audio *chip,
>
>         /* XMOS based USB DACs */
>         switch (chip->usb_id) {
> -       /* iFi Audio micro/nano iDSD */
> -       case USB_ID(0x20b1, 0x3008):
> +       case USB_ID(0x20b1, 0x3008): /* iFi Audio micro/nano iDSD */
> +       case USB_ID(0x20b1, 0x2008): /* Matrix Audio X-Sabre */
> +       case USB_ID(0x20b1, 0x300a): /* Matrix Audio Mini-i Pro */

You add and change comment style ;)

Michael

>                 if (fp->altsetting == 2)
>                         return SNDRV_PCM_FMTBIT_DSD_U32_BE;
>                 break;
> --
> 1.9.3
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
