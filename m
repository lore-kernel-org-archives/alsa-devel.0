From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: fireface: add support for Fireface
	800 with streaming functionality
Date: Sun, 16 Dec 2018 17:32:28 +0900
Message-ID: <20181216083233.11358-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A2D5026789E
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 09:32:49 +0100 (CET)
Received: by mail-pl1-f196.google.com with SMTP id g9so4691887plo.3
 for <alsa-devel@alsa-project.org>; Sun, 16 Dec 2018 00:32:49 -0800 (PST)
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

My former patchset adds support for Fireface 800 with MIDI functionality
only[1]. This patchset updates driver with packet streaming
functionality. As a result, both of PCM frames/MIDI messages are
available.

This patchset is based on my former patch to fix a bug to switch
frame fetching mode:

[alsa-devel] [PATCH] ALSA: fireface: fix for state to fetch PCM frames
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143150.html

Unfortunately, my initial commit of ALSA fireface driver in v4.12 kernel
includes bugs to handle tx isochronous packets. When testing this
patchset, please apply below patchset in advance:

[alsa-devel] [PATCH 0/3] ALSA: firewire-lib: fixes for processing packets without CIP header
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/143146.html

For testers, a remote branch including overall patches is available in
my remote repository in github.com[2]. They can be backport to Linux
kernel v4.17 or later.

I note that this driver can generate hissing noise long-periodically as I
reported for Fireface 400[3]. The cause is not cleared yet.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-December/142826.html
[2] https://github.com/takaswie/snd-firewire-improve/tree/topic/ff800-pcm
[3] http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102261.html

Takashi Sakamoto (5):
  ALSA: fireface: share helper function to switch fetching mode
  ALSA: fireface: code refactoring to handle multiplier mode
  ALSA: fireface: allocate isochronous resources in mode-specific
    implementation
  ALSA: fireface: add support for packet streaming on Fireface 800
  ALSA: fireface: code refactoring to handle model-specific registers

 sound/firewire/fireface/ff-pcm.c            |  33 ++++--
 sound/firewire/fireface/ff-protocol-ff400.c |  81 +++++++------
 sound/firewire/fireface/ff-protocol-ff800.c | 116 ++++++++++++++++++
 sound/firewire/fireface/ff-stream.c         | 124 +++++++++++---------
 sound/firewire/fireface/ff-transaction.c    |   4 +-
 sound/firewire/fireface/ff.c                |  37 +++---
 sound/firewire/fireface/ff.h                |  21 ++--
 7 files changed, 283 insertions(+), 133 deletions(-)

-- 
2.19.1
