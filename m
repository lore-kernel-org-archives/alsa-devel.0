From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: [CONF] All C-Media Codecs based 5.1 Channel USB-
	Headsets
Date: Sun, 04 Nov 2007 08:36:56 +0100
Message-ID: <472D7698.2080700@googlemail.com>
Reply-To: thomas.schorpp@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DD072449C
	for <alsa-devel@alsa-project.org>; Sun,  4 Nov 2007 08:37:00 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id f40so1256185fka
	for <alsa-devel@alsa-project.org>; Sun, 04 Nov 2007 00:36:59 -0700 (PDT)
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

Report to devlist as requested from USB-Audio.conf header:

1. all this headsets with windriver inf files + manual showing c-media driver must have 
the cm106x series 7.1 channel usb-codec in. there's no other from c-media for the design of 5.1 
channel usb headsets available at this time, see:

http://www.cmedia.com.tw/?q=en/usb_audio

2. the headset interface shows up with 8 channels in lsusb -v , 1 8-ch pcm in /proc,
 and must be driven with 
surround7.1 pcm plug instead of surround5.1 or it will not work. speaker-test program 
works with -c6 -Dsurround7.1, test with -c8 works too, but shows that no SideL/R -speakers 
connected/routed/downmixed ( Speedlink Medusa 5.1 Mobile USB Headset, cm106L)

3. it works instantly without extra config using programs that allow specifying 
(-D)surround7.1 like VDR and MPlayer, VLC did not so far 
(maybe can do with special commandline) 
and therere maybe other unconfigurable (or buggy?) players that need a missing extra cm106 
CARD configfile showing those apps a 5.1 channel device instead a 7.1.

i've done none so far, the config file language (especially routing and mappings) 
is not well documented, sorry.

y
tom
