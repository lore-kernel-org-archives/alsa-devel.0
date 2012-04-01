From: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Subject: Rawmidi vs. /dev/snd/*
Date: Sat, 31 Mar 2012 23:25:18 -0700
Message-ID: <7F5048EEC8BC46EE9D6306291A92F3EC@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-curtail.atl.sa.earthlink.net
	(elasmtp-curtail.atl.sa.earthlink.net [209.86.89.64])
	by alsa0.perex.cz (Postfix) with ESMTP id C5B95103E57
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Apr 2012 08:24:50 +0200 (CEST)
Received: from [76.89.179.141] (helo=PAULD)
	by elasmtp-curtail.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <pderocco@ix.netcom.com>) id 1SEEDb-0007b0-VN
	for alsa-devel@alsa-project.org; Sun, 01 Apr 2012 02:24:52 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In writing an embedded app that will be the only thing talking to MIDI, and
in which I don't need any timing or routing capability, is there any reason
to use ALSA Rawmidi, as opposed to merely reading and writing the device via
the file system? Which is the lower-level, and therefore most efficient,
interface? I'm leaning toward the latter, because I already know how to use
poll() to wait for incoming data on multiple input devices, but I don't see
how to do that via Rawmidi.

-- 

Ciao,               Paul D. DeRocco
Paul                mailto:pderocco@ix.netcom.com 
