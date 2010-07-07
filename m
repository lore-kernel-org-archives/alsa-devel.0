From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Wed, 07 Jul 2010 14:44:45 +0200
Message-ID: <4C3476BD.4090702@ladisch.de>
References: <4C32E3B2.5080707@web.de> <4C344340.8060804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 1788124496
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 14:44:46 +0200 (CEST)
In-Reply-To: <4C344340.8060804@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <fexpop@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> This fixes issues with M-Audio's Fast Track Ultra series:
> 
> * devices now work at 44100 and 88200 Hz

The descriptors already list these rates, so in theory, the existing
code that sets UAC_EP_CS_ATTR_SAMPLE_RATE should already have enabled
this.  Didn't it?  In other words, what is the difference in the
explicitly specified audioformat?

(I have the suspicion that we don't actually need a AUDIO_FIXED_ENDPOINT
quirk for these devices.)

> * apparently, fixes some crashes, too

When do these crashes happen?

> This is based on a patch posted by user 'dhubsith' on the M-Audio user 
> forum.

If you don't have the exclusive copyright for the code in this patch,
there needs to be a Signed-off-by line from him, too.  OTOH, a table
like this probably isn't copyrightable at all.

> -	USB_DEVICE(0x0763, 0x2080),
> +		USB_DEVICE(0x0763, 0x2081),
> ...

This replaces the ID of the Ultra 8 ID with that of the Ultra 8R ...

>  	USB_DEVICE(0x0763, 0x2081),
> -	.driver_info = ...
> +		.driver_info = ...

... and this just changes the other 8R entry.  So now the 8 doesn't
have an entry.


Regards,
Clemens
