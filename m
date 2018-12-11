From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/8] ALSA: fireface: add support for Fireface
	800 with MIDI functionality only
Date: Tue, 11 Dec 2018 19:17:27 +0900
Message-ID: <20181211101735.13735-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 886D8267ACE
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 11:17:44 +0100 (CET)
Received: by mail-pg1-f195.google.com with SMTP id 80so6436730pge.4
 for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2018 02:17:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

In 2004, RME GmbH shipped Fireface 800 as a flagship model of its
Fireface series. This model consists of some chips:
 - TI TSB81BA3D for physical layer on cable environment of EEE 1394 bus
 - TI TSB82AA2 for link layer for 1394 OHCI bus bridge to PCI bus
 - Xilinx Spartan-3 FPGA XC3S400
 - Xilinx High-Performance CPLD XC9572XL

A remarkable point of this model is that its physical/link layer
support S800 (800Mbps) mode of IEEE 1394b. Within devices of audio
and music unit on IEEE 1394 bus, this is an unique model to support it,
as long as I know.

This commit adds support for the model with its MIDI functionality only.
The functionality is quite similar to the one of Fireface 400. In patch
01-06, some codes specific to Fireface 400 are arranged to be shared by
both models.

On the other hand, there're some differences. The largest difference is
that the model has no register to switch enabling/disabling tx
asynchronous transactions for MIDI messages. Therefore the functionality
work well without any assist by userspace.

For this work, I use v2.77 firmware and v3.1.24 driver shipped by RME
GmbH. If finding some differences between older firmware, please report
it with enough information for debug. To help users for test, I prepare
a remote branch including these patches. This can be backport to Linux
v4.17 or later.
https://github.com/takaswie/snd-firewire-improve/tree/topic/ff800-midi

Takashi Sakamoto (8):
  ALSA: fireface: share some registers for status of clock
    synchronization
  ALSA: fireface: share status and configuration dump
  ALSA: fireface: share helper function to get current sampling rate and
    clock source
  ALSA: fireface: add support for second optical interface for ADAT
    stream
  ALSA: fireface: share register for async transaction of MIDI messages
  ALSA: fireface: add driver data for register for MIDI high address
  ALSA: fireface: localize a handler for MIDI messages on tx transaction
  ALSA: fireface: add support for Fireface 800 with MIDI functionality
    only

 sound/firewire/Kconfig                      |   1 +
 sound/firewire/fireface/Makefile            |   3 +-
 sound/firewire/fireface/ff-pcm.c            |   2 +-
 sound/firewire/fireface/ff-proc.c           | 193 +++++++++++++-
 sound/firewire/fireface/ff-protocol-ff400.c | 282 ++------------------
 sound/firewire/fireface/ff-protocol-ff800.c |  27 ++
 sound/firewire/fireface/ff-stream.c         |   2 +-
 sound/firewire/fireface/ff-transaction.c    | 157 ++++++-----
 sound/firewire/fireface/ff.c                |  54 +++-
 sound/firewire/fireface/ff.h                |  31 ++-
 10 files changed, 406 insertions(+), 346 deletions(-)
 create mode 100644 sound/firewire/fireface/ff-protocol-ff800.c

-- 
2.19.1
