From: Michael Hoffer <info@michaelhoffer.de>
Subject: M-Audio Qattro USB
Date: Mon, 17 Jan 2005 22:44:46 +0100
Message-ID: <200501172244.47086.info@michaelhoffer.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from natjimbo.rzone.de (natjimbo.rzone.de [81.169.145.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2C85D2A2
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 22:42:51 +0100 (MET)
Received: from noname (p508B9852.dip0.t-ipconnect.de [80.139.152.82])
	by post.webmailer.de (8.13.1/8.13.1) with ESMTP id j0HLgh2p013401
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 22:42:44 +0100 (MET)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

HI!

I read the Install-Howto for snd-usb-audio on www.alsa-project.org. I use
Gentoo-Linux (kernel 2.6.9). I have the feeling that the .asoundrc file had
no effect on my system. 

When I tried to record with a samplerate of 96000 Hz
audacity could not open the sounddevice. With 48000 Hz it worked 
fine in audacity. 

With arecord I get the following error message. It doesn't make a difference 
if I use other sample rates or sample formates.
arecord gives the following output:

bash-2.05b$ arecord -D quattro -f S24_3LE -r 96000 -c 2 -d 10 test.raw
Recording WAVE 'test.raw' : Signed 24 bit Little Endian in 3bytes, Rate 96000 
Hz, Stereo
arecord: set_params:854: Sample format non available

Thanks for your help!


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
