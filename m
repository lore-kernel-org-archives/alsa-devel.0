From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] UAC2 clock selector - fixed?
Date: Sun, 03 Feb 2013 16:31:25 +0100
Message-ID: <510E82CD.1010105@gmail.com>
References: <3388A7F4-A801-4013-8A4A-66E52AA70947@museresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id CF8A22615C0
 for <alsa-devel@alsa-project.org>; Sun,  3 Feb 2013 16:32:21 +0100 (CET)
Received: by mail-bk0-f50.google.com with SMTP id jg9so2472818bkc.37
 for <alsa-devel@alsa-project.org>; Sun, 03 Feb 2013 07:32:21 -0800 (PST)
In-Reply-To: <3388A7F4-A801-4013-8A4A-66E52AA70947@museresearch.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Louis Gorenfeld <louis@museresearch.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03.01.2013 02:01, Louis Gorenfeld wrote:
> Hi,
>   I'd been struggling with a UAC2 device that I couldn't set the clock on. I finally got in touch with a driver author who pointed me to some official 	documentation (the USB Device Class Definition for Audio Devices). Where the ALSA code always sends a 16-bit packet to control mixer settings, the docs say that the clock selector control uses layout 1 which is 8-bit. By changing the routine to send an 8-bit packet, that control now works.
> 
> This is the patch that fixes the problem for me (for ALSA 1.0.25). Is this proper?

Sorry for the late reply!

> --- a/linux-3.4/sound/usb/mixer.c	2012-05-20 15:29:13.000000000 -0700
> +++ b/vanilla-3.4/sound/usb/mixer.c	2013-01-02 17:06:11.009660059 -0800
> @@ -422,8 +422,13 @@
>  	if (cval->mixer->protocol == UAC_VERSION_1) {
>  		val_len = cval->val_type >= USB_MIXER_S16 ? 2 : 1;
>  	} else { /* UAC_VERSION_2 */
> -		/* audio class v2 controls are always 2 bytes in size */
> -		val_len = sizeof(__u16);
> +		/* audio class v2 controls are often but not always 2 bytes in size */
> +		/* For example, the clock selector (see 5.2.5.2.1 in the Universal Serial
> +		 * Bus Device Class Definition for Audio Devices document) */
> +		if (cval->control == UAC2_CX_CLOCK_SELECTOR)
> +			val_len = sizeof(__u8);
> +		else
> +			val_len = sizeof(__u16);

This seems about right. Please provide a proper patch with your
Signed-off-by line (see Documentantation/SubmittingPatches for details).

You can add my Acked-by: right away when posting.


Thanks a lot,
Daniel
