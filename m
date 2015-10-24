From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: fireworks: refactoring of substream
	counting
Date: Sat, 24 Oct 2015 11:28:30 +0900
Message-ID: <1445653712-14234-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EBD22656F0
 for <alsa-devel@alsa-project.org>; Sat, 24 Oct 2015 04:28:41 +0200 (CEST)
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

This patchset is for refactoring of substream counting. Currently the
counting has atomic_t type. When utilizing lock by mutex in snd_efw
structure, the counting can have simpler type, unsigned int.

Takashi Sakamoto (2):
  fireworks: move mutex from function callees to callers
  fireworks: change type of substream counter from atomic_t to unsigned
    int

 sound/firewire/fireworks/fireworks.h        |  4 ++--
 sound/firewire/fireworks/fireworks_midi.c   | 16 +++++++++++----
 sound/firewire/fireworks/fireworks_pcm.c    | 28 +++++++++++++++++--------
 sound/firewire/fireworks/fireworks_stream.c | 32 +++++++++++------------------
 4 files changed, 46 insertions(+), 34 deletions(-)

-- 
2.1.4
