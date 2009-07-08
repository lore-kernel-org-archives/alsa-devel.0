From: Chris Lasher <chris.lasher@gmail.com>
Subject: Choosing correct nid and xindex for hda_intel realtek
	patch for MacBook 5.1
Date: Wed, 8 Jul 2009 15:03:08 -0400
Message-ID: <128a885f0907081203p467526amb93ee124443c6693@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B51A24454
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jul 2009 21:03:30 +0200 (CEST)
Received: by qyk15 with SMTP id 15so5408811qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 08 Jul 2009 12:03:28 -0700 (PDT)
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

I'm trying to fix support for my MacBook 5.1. A patch by Kacper is getting
me part of the way there but it seems my pin configuration is different than
his model of MacBook. I'm trying to wire up my pins to his correctly. I am
trying to figure out the bits of snd_kcontrol_new (in
alsa-driver-1.0.19/alsa-kernel/pci/hda/patch_realtek.c) for the
HDA_CODEC_VOLUME and HDA_BIND_MUTE. There is:
string_description, nid , xindex, HDA_INPUT/HDA_OUTPUT

I'm trying to figure out how to choose the correct values for nid and
xindex. Actually, I'm really wondering how to identify the right xindex for
a given nid, as I realize the nid's come from the Node #s from the output of
/proc/asound/card0/codec#0.

I also need some assistance with regards to the hda_verb settings for
modifying the alc885_mb5_init_verbs section; if anyone can offer pointers
there, I'd appreciate it.

This is directly related to Bug #337314 in Launchpad
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/337314?comments=all
and
ALSA bug 4432:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4432

Kacper's patch is linked to in both bug reports.

The output of my soundcard's codec#0 is attached to the Launchpad report
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/337314/comments/110

The output from a soundcard that does seem to have full support by Kacper's
patch is available at
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/337314/comments/130

Any help would be much appreciated.

Thanks,
Chris
