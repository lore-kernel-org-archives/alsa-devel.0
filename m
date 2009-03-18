From: dfoley <dfoley@telus.net>
Subject: soc underrun problem
Date: Tue, 17 Mar 2009 21:56:06 -0700
Message-ID: <gpput6$fv1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id B876C1038AE
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 06:00:04 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Ljnso-00048k-Pa
	for alsa-devel@alsa-project.org; Wed, 18 Mar 2009 05:00:02 +0000
Received: from d75-157-50-35.bchsia.telus.net ([75.157.50.35])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 05:00:02 +0000
Received: from dfoley by d75-157-50-35.bchsia.telus.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 05:00:02 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm currently having a problem with playing wave files

root@tsi-tpcxx:~# aplay /usr/share/sounds/alsa/Front_Center.wav
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, Mono
mapped channel 10 to 2
underrun!!! (at least 130.662 ms long)
underrun!!! (at least 140.809 ms long)

I've narrowed it down to the commit ed3da3d9a0ef13c6fe1414ec73c9c1be12747b62 in linux-next/sound-2.6-tiwai.git.
   ALSA: Rewrite hw_ptr updaters

The audio works fine, when I reverse this commit.

My hardware is: CPU s3c2410 @ 202.8Mhz codecs (ak4550 or tlv320)

Anyone else seeing this ?
