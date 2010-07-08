From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - Fix Fast Track Ultra series: 44.1/88.1
 kHz 1/Fix playback/capture issues and related chrashes at 44100 Hz and
 88200 Hz for M-Audio Fast Track Ultra series.
Date: Thu, 08 Jul 2010 08:25:26 +0200
Message-ID: <4C356F56.6010804@ladisch.de>
References: <4C32E3B2.5080707@web.de>
	<4C344340.8060804@web.de>	<4C3476BD.4090702@ladisch.de>
	<4C347EF7.2030401@web.de> <4C348DC6.7070602@ladisch.de>
	<4C34B177.1090500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 7314C2462E
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Jul 2010 08:25:30 +0200 (CEST)
In-Reply-To: <4C34B177.1090500@web.de>
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
> Building Alsa fails after applying your patch:
> 
> patching file quirks.c
> Hunk #2 FAILED at 159.

My patch was against the kernel source; the alsa-driver package
needs this additional patch:

--- alsa-driver/usb/quirks.patch
+++ alsa-driver/usb/quirks.patch
@@ -15,9 +15,9 @@
 +#else
 +	fp->maxpacksize = get_endpoint(alts, 0)->wMaxPacketSize;
 +#endif
+ 	print_hex_dump_bytes("format ", DUMP_PREFIX_OFFSET, fp, sizeof(*fp));
  	usb_set_interface(chip->dev, fp->iface, 0);
  	snd_usb_init_pitch(chip, fp->iface, alts, fp);
- 	snd_usb_init_sample_rate(chip, fp->iface, alts, fp, fp->rate_max);
 @@ -228,7 +234,11 @@
  	fp->endpoint = get_endpoint(alts, 0)->bEndpointAddress;
  	fp->ep_attr = get_endpoint(alts, 0)->bmAttributes;
