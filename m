From: "M-.-n" <nostromo@arkaos.net>
Subject: Hello and providing ALSA support to sdl
Date: Mon, 07 Jan 2008 15:38:55 +0100
Message-ID: <4782397F.1030608@arkaos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay010.isp.belgacom.be (mailrelay010.isp.belgacom.be
	[195.238.6.177]) by alsa0.perex.cz (Postfix) with ESMTP id BA42E248F0
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 15:37:53 +0100 (CET)
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


Hi there,

My name is Marc and I'm writing a tracker software originally geared 
towards gameconsole (first GP32 but now GP2X, PC, Mac) and since I got 
this lovely eee, I'm planning on porting it to debian-derived platforms. 
Actually it works already but the SDL version I have uses oss and it 
seems to hickup sometimes although the cpu power consumption seems fine.

Other programs (vlc/audacity) seems no to reflect this problem so I 
guess it's due to the fact they use ALSA while the SDL I got doesn't.

When configuring SDL, it seems not to include ALSA (by not finding 
alsa/soundlib.h) and I'd like to add it but I'm a little confused on the 
step to follow. ALSA seems to be installed but I guess I miss the 
includes and compiling libs. Does it mean I need to configure/compile 
alsa-lib ? Do I risk corrupting my system if the installed libraries are 
not compatible ?

Sorry for the rambling, but I'm only a beginner in terms of developping 
audio apps under linux.

Regards,
Marc.
