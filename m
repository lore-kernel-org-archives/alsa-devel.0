From: Stephen Hassard <steve@hassard.net>
Subject: M-Audio Sonica (USB) support
Date: Wed, 28 Aug 2002 07:36:34 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020828143634.GA384@SHLIAN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from lb1.angio.com ([207.23.249.14])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA05835
	for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2002 16:36:37 +0200
Received: from shlian.angio.com (shlian.angio.com [192.168.100.174])
	by lb1.angio.com (Postfix) with SMTP id C4B1173C83
	for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2002 06:37:20 -0700 (PDT)
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I was trying to get my M-Audio Sonica to work under Alsa. It's a nifty
little single channel out 24/96 USB audio device. Here's the product
page: http://www.m-audio.com/products/consumer/sonica.php

I'm running the CVS version of Alsa from last night (12 hours ago).

snd-usb-audio modprobes fine and doesn't give me any errors. /dev/dsp
doesn't get created properly (snd-pcm-oss is loaded properly), not does
/proc/asound/cards list anything ('--- no soundcards ---'). The device
is properly detected by the linux kernel, as I get properly
connect/disconnect messages. I'm using kernel v2.4.20pre4. The device is
plugged into a UHCI controller (it's a USB 2.0 NEC controller).

I was taking a look around the source to see if I could add the Sonica
device ID, but I can't seem to find where to hack it (if it's even
needed). Anyhow, the device ID for the Sonica is vend/prod 0x763/0x2805.
Any help would be greatly appreciated.

Thanks,
Stephen Hassard


-------------------------------------------------------
This sf.net email is sponsored by: Jabber - The world's fastest growing 
real-time communications platform! Don't just IM. Build it in! 
http://www.jabber.com/osdn/xim
