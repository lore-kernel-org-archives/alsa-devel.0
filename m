From: David Santamauro <david.santamauro@gmail.com>
Subject: ice1712 and the delta 1010
Date: Thu, 26 Aug 2010 06:58:54 -0400
Message-ID: <20100826065854.519ee1d3@debussy>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BA1111037F3
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 13:02:04 +0200 (CEST)
Received: by qwj9 with SMTP id 9so1486004qwj.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 04:02:04 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi all,

this is my first post as I was guided here from the linux audio user
list to follow up on a problem I've been having with my delta 1010.

Background:
Since upgrading my audio PC to 64-bit, the delta 1010 analog inputs
emit a constant 'hiss' -36 -30dB. Analog outputs and digital ins and
outs are fine. The delta 1010 from a hardware perspective is fine as I
tested it on the same pc hardware under windows7 64-bit.

So far, I have tested it in a 32-bit fedora, 32-bit windows vista and
64-bit windows7 all successfully. This problem arises only in 64-bit
fedora.

My kernel:
Linux 2.6.31.12-1.rt21.1.fc12.ccrma.x86_64.rt

My alsa packages and versions:
alsa-lib.x86_64                          1.0.23-1.fc12
alsa-lib-devel.x86_64                    1.0.23-1.fc12
alsa-tools.x86_64                        1.0.22-1.1.fc12.ccrma
alsa-utils.x86_64                        1.0.23-3.fc12

My modinfo:

$ modinfo snd_ice1712
filename:       /lib/modules/2.6.31.12-1.rt21.1.fc12.ccrma.x86_64.rt/kernel/sound/pci/ice1712/snd-ice1712.ko
license:        GPL
description:    ICEnsemble ICE1712 (Envy24)
author:         Jaroslav Kysela <perex@perex.cz>
srcversion:     0B183929429B4C5102B7D09
alias:          pci:v00001412d00001712sv*sd*bc*sc*i*
depends:
snd-pcm,snd,snd-i2c,snd-mpu401-uart,snd-ice17xx-ak4xxx,snd-cs8427,snd-ak4xxx-adda,snd-ac97-codec
vermagic:       2.6.31.12-1.rt21.1.fc12.ccrma.x86_64.rt SMP preempt
mod_unload parm:           index:Index value for ICE1712 soundcard.
(array of int) parm:           id:ID string for ICE1712 soundcard.
(array of charp) parm:           enable:Enable ICE1712 soundcard.
(array of bool) parm:           omni:Enable Midiman M-Audio Delta Omni
I/O support. (array of bool) parm:           cs8427_timeout:Define
reset timeout for cs8427 chip in msec resolution. (array of int)
parm:           model:Use the given board model. (array of charp)
parm:           dxr_enable:Enable DXR support for Terratec DMX6FIRE.
(array of int)


So, my question is simply: has this been reported before, in
particular regarding the 64-bit ice1712 module?

I'm pretty convinced it is a software/driver 32/64-bit issue based on my
observations above and confirmation of the same problem under the same
conditions by another user, but am willing to be corrected.

I'm a pretty competent C/C++ coder but a novice coder in the linux audio
world so I'd be willing to learn and help from a driver perspective
given the right direction -- at the least help debug the problem (if it
is even at the driver level).

Thanks for any input.

David
