From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: fireworks: refactoring of substream
	counting
Date: Sat, 14 Nov 2015 16:54:49 +0900
Message-ID: <1447487691-26037-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E107F261493
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2015 08:54:56 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset is re-post of my previous one.
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/099553.html

This patchset is for refactoring of substream counting. Currently the
counting is with atomic_t type. When utilizing lock by mutex in snd_efw
structure, the counting can be simpler type, unsigned int so as the other
ALSA firewire drivers do.

Takashi Sakamoto (2):
  ALSA: fireworks: move mutex from function callees to callers
  ALSA: fireworks: change type of substream counter from atomic_t to
    unsigned int

 sound/firewire/fireworks/fireworks.h        |  4 ++--
 sound/firewire/fireworks/fireworks_midi.c   | 16 +++++++++++----
 sound/firewire/fireworks/fireworks_pcm.c    | 28 +++++++++++++++++--------
 sound/firewire/fireworks/fireworks_stream.c | 32 +++++++++++------------------
 4 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.5.0
