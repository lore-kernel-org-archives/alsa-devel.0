From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] 6fire: Convert byte_rev_table uses to bitrev8
Date: Thu, 13 Nov 2014 21:45:34 -0800
Message-ID: <1415943934.5912.6.camel@perches.com>
References: <35FD53F367049845BC99AC72306C23D103E010D1829C@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E010D1829C@CNBJMBX05.corpusers.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: "'perex@perex.cz'" <perex@perex.cz>, "'tiwai@suse.de'" <tiwai@suse.de>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-11-14 at 13:13 +0800, Wang, Yalin wrote:
> Use the inline function instead of directly indexing the array.
> 
> This allows some architectures with hardware instructions for bit
> reversals to eliminate the array.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Yalin Wang <yalin.wang@sonymobile.com>
> ---
[]
> diff --git a/sound/usb/6fire/firmware.c b/sound/usb/6fire/firmware.c
[]
> @@ -316,7 +316,7 @@ static int usb6fire_fw_fpga_upload(
>  
>  	while (c != end) {
>  		for (i = 0; c != end && i < FPGA_BUFSIZE; i++, c++)
> -			buffer[i] = byte_rev_table[(u8) *c];
> +			buffer[i] = bitrev8((u8) *c);

This is not what I submitted.
What I posted did not have a space after (u8)

https://lkml.org/lkml/2014/10/28/1056

If you are going to resubmit or add your own sign-off,
please try to maintain the proper patch that is
submitted and please also use a "From:" line before
the patch itself.

Thanks, Joe
