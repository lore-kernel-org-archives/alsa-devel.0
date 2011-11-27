From: John F Leach <jfleach@jfleach.com>
Subject: Re: [PATCH] [ALSA] usb-audio - Support for Roland GAIA
 SH-01 Synthesizer
Date: Sun, 27 Nov 2011 11:10:27 -0500
Message-ID: <1322410227.14597.19.camel@darkside>
References: <1322404484.6913.20.camel@darkside>  <4ED25560.40208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from homiemail-a10.g.dreamhost.com (caiajhbdcbbj.dreamhost.com
	[208.97.132.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 6426524364
	for <alsa-devel@alsa-project.org>; Sun, 27 Nov 2011 17:10:36 +0100 (CET)
In-Reply-To: <4ED25560.40208@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, alsa-devel <alsa-devel@alsa-project.org>, clemens <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

> Entries in this list should be ordered by the USB vendor/product ID,
> which is not the case judging from the next block:
> 
> >  	/* Roland SH-201 */
> >  	USB_DEVICE(0x0582, 0x00ad),
> >  	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> 
> 
> Otherwise looks good.
> 
> Thanks for sending patches!
> 
> 
> Daniel

Thanks for the feedback Daniel; I submitted a revised patch with the
correct list order and fixed the wrapped line for the driver_info.

Regards,

John F Leach   
