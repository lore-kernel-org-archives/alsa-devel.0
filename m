From: Wolfgang Scheicher <wolfgang.scheicher@gmail.com>
Subject: pci/hda/patch_via.c - broken between 2.6.36 and 2.6.37
	(bisected)
Date: Sun, 20 Feb 2011 11:50:55 +0100
Message-ID: <ijqrmf$tlg$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id AB33A2437B
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 11:51:09 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pr6se-00024a-E0
	for alsa-devel@alsa-project.org; Sun, 20 Feb 2011 11:51:08 +0100
Received: from 84-119-52-132.dynamic.xdsl-line.inode.at ([84.119.52.132])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 11:51:08 +0100
Received: from wolfgang.scheicher by 84-119-52-132.dynamic.xdsl-line.inode.at
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 20 Feb 2011 11:51:08 +0100
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


After the mentioned Kernel upgrade quite a view things went wrong on my 
hardware ( http://www.asrock.com/mb/overview.asp?Model=890GM%20Pro3 ):

* Microphone doesn't work anymore. neither the front mic nor the rear one. 
Tried all thinkable settings.

* Increasing Microphone levels leads to some strange internal feedback. That 
means, at some point when the feedback starts, it just starts, but i have no 
clue what audio source did actually trigger it.

* Touching the mixer channel "Smart 5.1" in alsamixer makes alsamicer crash.


After quite some days of frustration and the inability to get help i however 
managed to learn how to build a kernel and how to git bisect. So this is 
what i did:


root@Blackrock ~src/alsa-kernel (git)-[7b315bb...|bisect] # git bisect log
git bisect start '--' 'sound/pci'
# bad: [81a2f603f94d6da108ddd8e3535294445097f730] ALSA: ac97: replace open-
coded, error-prone stuff with AC97 bit defines
git bisect bad 81a2f603f94d6da108ddd8e3535294445097f730
# good: [f6f94e2ab1b33f0082ac22d71f66385a60d8157f] Linux 2.6.36
git bisect good f6f94e2ab1b33f0082ac22d71f66385a60d8157f
# bad: [28c4edb71d21623f1e47422194d865d2b6712fd4] ALSA: HDA: Rename "Int 
Mic" to "Internal Mic"
git bisect bad 28c4edb71d21623f1e47422194d865d2b6712fd4
# bad: [0e7adbe263f89ea2ef15b5af5e80a812b2a85025] ALSA: hda - Disable sticky 
PCM stream assignment for AD codecs
git bisect bad 0e7adbe263f89ea2ef15b5af5e80a812b2a85025
# bad: [5637edb2e1c2d13b276748508ae17f319fb7f066] ALSA: HDA: Sort CXT5066 
quirk table
git bisect bad 5637edb2e1c2d13b276748508ae17f319fb7f066
# bad: [18675e4283f575594d55ef1239c14ab5b4de53b6] ALSA: hda - Add fixup for 
FSC Celsius H270
git bisect bad 18675e4283f575594d55ef1239c14ab5b4de53b6
# good: [eea7dc932bfa802ad0377755ea821f416f4f8623] ALSA: hda - Use new 
inputs[] field to parse input-pins for STAC/IDT codecs
git bisect good eea7dc932bfa802ad0377755ea821f416f4f8623
# bad: [263d0328c46995d8e4fb478005177839104483d2] ALSA: hda - Improve input 
control names for IDT/STAC codecs
git bisect bad 263d0328c46995d8e4fb478005177839104483d2
# bad: [9737731d64bfa64ab4fc04b46ae5b650f6432222] Merge branch 'fix/hda' 
into topic/hda
git bisect bad 9737731d64bfa64ab4fc04b46ae5b650f6432222
# bad: [7b315bb4980448250c80a7464c256b54d546cb26] ALSA: hda - Use new 
inputs[] field to parse input-pins for VIA codecs
git bisect bad 7b315bb4980448250c80a7464c256b54d546cb26


root@Blackrock ~src/alsa-kernel (git)-[7b315bb...|bisect] # git bisect bad
7b315bb4980448250c80a7464c256b54d546cb26 is the first bad commit
commit 7b315bb4980448250c80a7464c256b54d546cb26
Author: Takashi Iwai <tiwai@suse.de>
Date:   Mon Aug 30 13:06:30 2010 +0200

    ALSA: hda - Use new inputs[] field to parse input-pins for VIA codecs
    
    Signed-off-by: Takashi Iwai <tiwai@suse.de>

:040000 040000 fb32bef12d78f90f00020cf375fddd36be1cdfbe 
02f61291093ce6c7c8e7e1bd98fd87f9338702a1 M      sound



Oh, and here are debug infos from when i first tried to report the problem:
bad:
http://www.alsa-project.org/db/?f=0f29e6de98ea9fefae5c6e2adb43ff8f8eede697

good:
http://www.alsa-project.org/db/?f=11290fe50066e9bcd6a244f2c83b1c66c9dd201b


I hope someone can take it from here. I'm not much more than a user. Just 
because i managed to build a kernel doesn't mean i can fix this bug.

Wolfgang Scheicher
