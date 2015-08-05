From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: fireworks/firewire-lib: add support
	for recent firmware quirk
Date: Wed,  5 Aug 2015 09:21:03 +0900
Message-ID: <1438734065-5204-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E61226582D
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 02:21:15 +0200 (CEST)
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
Cc: johannes.oertel@uni-due.de, alsa-devel@alsa-project.org, harryhaaren@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Some users have reported current ALSA Fireworks driver stops packet
streaming due to detecting discontinuity.

[alsa-devel] ALSA snd-fireworks Echo AudioFire 2
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-August/080379.html

[alsa-devel] AudioFire4 quirk
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-July/095697.html

Linux 3.16 or later have this issue.

As long as I investigate, this issue depends on firmware version installed
in these devices. While, it's not clear that which version of firmwares for
which model has this quirk. At least, firmware version 5.7.0, 5.7.3 and
5.8.0 for AudioFire2/AudioFire4/AudioFirePre8 have this quirk.

This patchset applies a solution for this issue, with my assumption that
'the same firmware binary has the same quirk'. These models, AudioFire8
(since Jul 2009) and Gibson Robot Interface Pack (RIP) series uses the
same firmware binary in driver package.

If possible, the second patch should be applied to all of stable kernels.

This patchset updates my previous RFC:
[alsa-devel] [RFC][PATCH 0/2] ALSA: fireworks/firewire-lib: add support for recent firmware quirk
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-August/095849.html

Takashi Sakamoto (2):
  Revert "ALSA: fireworks: add support for AudioFire2 quirk"
  ALSA: fireworks/firewire-lib: add support for recent firmware quirk

 sound/firewire/amdtp.c                      |  5 +++--
 sound/firewire/amdtp.h                      |  2 ++
 sound/firewire/fireworks/fireworks.c        | 10 ++++++++--
 sound/firewire/fireworks/fireworks.h        |  2 +-
 sound/firewire/fireworks/fireworks_stream.c | 12 +++++++++---
 5 files changed, 23 insertions(+), 8 deletions(-)

-- 
2.1.4
