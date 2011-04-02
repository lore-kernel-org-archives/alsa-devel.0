From: Tim Blechmann <tim@klingt.org>
Subject: hdspmixer broken for 96khz
Date: Sat, 02 Apr 2011 14:28:02 +0200
Message-ID: <in74oi$qce$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 75CE6103815
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 14:28:24 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Q5zwA-0007eo-3H
	for alsa-devel@alsa-project.org; Sat, 02 Apr 2011 14:28:18 +0200
Received: from 85-127-15-226.dynamic.xdsl-line.inode.at ([85.127.15.226])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 02 Apr 2011 14:28:18 +0200
Received: from tim by 85-127-15-226.dynamic.xdsl-line.inode.at with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 02 Apr 2011 14:28:18 +0200
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

the updated hdspmixer doesn't work for 96khz any more. the 44.1/48 khz versions 
are drawn correctly, the 88.2/96 khz version hides all controls, so just the 
menu is visible.

bisecting fails, since some versions of hdspmixer simply segfault. the bisect 
report gives me:

There are only 'skip'ped commits left to test.
The first bad commit could be any of:
0201fd1778fb536b2b1f2f5305e64a162667769c
69991756aa544021bff485eae64c02ee674c3e30
9ea2fb1f880667388435f4983f6d727d6b55875a
cef20c040c962e3183e20093478d30f2ffc1ee46
073fad25cb1e05c6fa00d9d2f3fb3781156e6988
5d4bcc44ce054cedaa6f998bcb6a7c0746d19f69
3f34b2c0f2aba38b819d4b05a25b2ff2f090f512
4c63a6b7beec6d9402b5e3fd8a5a075e436f6055
3506d3d9a7d13c40f8080bf36e2c745a73310da9
d0d9470deeb06d1cc5405e37695229db68cde3bd
97e96addffef14f71739bdf1e51030cce854904b
f2bb47662d65ecb358f51b66dfd64eed1f38dde1
646eacb626355a7010aab901dbe4dcfa66ede70f

oddly, i cannot get any earler version of hdspmixer working: the version tagged 
with v1.0.24.1 gives me:
HDSPMixer 1.6 - Copyright (C) 2003 Thomas Charbonnel <thomas@undata.org>
This program comes with ABSOLUTELY NO WARRANTY
HDSPMixer is free software, see the file COPYING for details

Looking for RME cards :
Card 0 : HDA Intel at 0xf7ff8000 irq 70
Card 1 : RME Hammerfall DSP + Multiface at 0xfbef0000, irq 16
Uninitialized HDSP card found.
Use hdsploader to upload configuration data to the card.
No RME cards found.

hdspconf can connect to the card, though

thoughts?

-- 
tim@klingt.org
http://tim.klingt.org

Your mind will answer most questions if you learn to relax and wait
for the answer.
  William S. Burroughs
