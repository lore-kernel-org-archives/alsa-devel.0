From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/6] ALSA: fireface: support MIDI functionality
	of Fireface UCX
Date: Tue, 22 Jan 2019 22:16:59 +0900
Message-ID: <20190122131705.23213-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com
 [209.85.214.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0406E26749F
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 14:17:14 +0100 (CET)
Received: by mail-pl1-f193.google.com with SMTP id y1so11468094plp.9
 for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2019 05:17:14 -0800 (PST)
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

This patchset is a supplement of my previous one and to complete support
for Fireface UCX:
[alsa-devel] [PATCH 0/9] ALSA: fireface: add support for Fireface UCX
http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144465.html

The mechanism to use MIDi functionality of Fireface UCX is different
from the other supported devices; Fireface 800 and Fireface 400. This
patchset extends abstraction layer of hardware specification and
communication protocol.

Unfortunately, a bitflag to decide lower part of address to transfer
asynchronous transaction for MIDI message is in option register which
has the other options. This driver expects userspace applications to
configure the option as expected. In detail please refer to third patch.

For testers, a remote branch is available to backport a series of
patches to Linux kernel v4.17 or later:
https://github.com/takaswie/snd-firewire-improve/tree/topic/ff-ucx-midi

A userspace tool to configure addressed register is available in another
remote branch for hinawa-utils:
https://github.com/takaswie/hinawa-utils/tree/topic/ff-ucx

As I noted in previous patchset, this work is based on my packet analysis
from rent device for a short term (2 weeks). I'm happy to get your
response till next weekend.

Regards

Takashi Sakamoto (6):
  ALSA: fireface: change prototype of handler for async transaction with
    MIDI messages
  ALSA: fireface: add model-dependent parameter for address range to
    receive async transaction
  ALSA: fireface: support tx MIDI functionality of Fireface UCX
  ALSA: fireface: add model-dependent parameter for address to receive
    async transaction for MIDI messages
  ALSA: fireface: add protocol-specific operation to fill transaction
    buffer with MIDI messages
  ALSA: fireface: support rx MIDI functionality for Fireface UCX

 sound/firewire/fireface/ff-midi.c            |   2 +-
 sound/firewire/fireface/ff-protocol-former.c |  29 +++-
 sound/firewire/fireface/ff-protocol-latter.c | 139 +++++++++++++++++++
 sound/firewire/fireface/ff-transaction.c     |  44 +++---
 sound/firewire/fireface/ff.c                 |  31 +++--
 sound/firewire/fireface/ff.h                 |  10 +-
 6 files changed, 210 insertions(+), 45 deletions(-)

-- 
2.19.1
