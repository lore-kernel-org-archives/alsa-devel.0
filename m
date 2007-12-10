From: "SeNS" <sens_boston@yahoo.com>
Subject: Re: cmipci: have only surround40 on 6 ch card
Date: Mon, 10 Dec 2007 11:22:17 -0500
Message-ID: <fjjp3d$ckb$1@ger.gmane.org>
References: <fjcgls$55i$1@ger.gmane.org>
	<1197284022.25582.1225725951@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F9741037F4
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 17:22:24 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1J1lOW-00042V-JZ
	for alsa-devel@alsa-project.org; Mon, 10 Dec 2007 16:22:12 +0000
Received: from c-71-233-211-188.hsd1.ma.comcast.net ([71.233.211.188])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 16:22:12 +0000
Received: from sens_boston by c-71-233-211-188.hsd1.ma.comcast.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2007 16:22:12 +0000
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

Hello, Clemens!
You wrote  on Mon, 10 Dec 2007 11:53:42 +0100:

 CL> In what ALSA version did it work?

Unfortunatelly can't remember that :-( Some like 1.0.10RC3 (latest on the 
end of 2006).

 >> cat /proc/asound/card0/cmipci
 >> C-Media PCI CMI8738 (model 37) at 0xe000, irq 10
 >> ...
 >> 08: 03 00 00 01
 >> 0c: 00 00 01 00

 CL> These registers identify the chip as model 37 with four channels.
 CL> What model is this?

It's cheap, noname, made in China card. AFAIR cover box says "6 channel 
multimedia card" or something like that. But it have 3 stereo jacks onboard 
(front, rear, center+LFE) and 100% works with previous ALSA (I use "Test AC3 
v2.0.avi" to be sure)

WBR, SeNS 
