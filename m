From: "SeNS" <sens_boston@yahoo.com>
Subject: cmipci: have only surround40 on 6 ch card
Date: Fri, 7 Dec 2007 17:15:40 -0500
Message-ID: <fjcgls$55i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id CB693103876
	for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2007 23:20:15 +0100 (CET)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1J0lYB-0004Cz-1m
	for alsa-devel@alsa-project.org; Fri, 07 Dec 2007 22:20:03 +0000
Received: from c-71-233-211-188.hsd1.ma.comcast.net ([71.233.211.188])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 07 Dec 2007 22:20:03 +0000
Received: from sens_boston by c-71-233-211-188.hsd1.ma.comcast.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 07 Dec 2007 22:20:03 +0000
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

Hello, All!

Sorry for repost; probably, it's a driver problem.

I have 6 channel CMI8738-based card (it works in 6 channel mode under win32; 
and works before under Linux with ALSA).

===============================================
lspci output: "0000:00:0a.0 Multimedia
audio controller: C-Media Electronics Inc CM8738 (rev 10)"
===============================================
my kernel version 2.4.34
alsa version 1.0.15
===============================================
cat /proc/asound/cards
 0 [CMI8738        ]: CMI8738 - C-Media CMI8738
                      C-Media CMI8738 (model 37) at 0xe000, irq 10
===============================================
cat /proc/asound/card0/cmipci

C-Media PCI CMI8738 (model 37) at 0xe000, irq 10

00: 02 00 01 00
04: 10 1c 00 00
08: 03 00 00 01
0c: 00 00 01 00
10: d4 00 00 40
14: 00 00 00 00
18: 00 80 80 08
1c: fa 4c 04 33
20: 10 01 00 00
24: 20 01 ff 00
28: 00 00 00 00
2c: 00 00 00 00
30: ff ff ff ff
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00
===============================================

WBR, SeNS 
