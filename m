From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5] ALSA: firewire: suppress sparse warnings
	due to endianness handling
Date: Sun, 18 Oct 2015 22:39:48 +0900
Message-ID: <1445175593-11293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E5B1265071
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 15:39:59 +0200 (CEST)
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

This patchset fixes some issues related to sparse warnings about
endianness handling for ALSA firewire stack.

For writing this patchset, I use 'C=1 CF=-D__CHECK_ENDIAN__' options to
'make' command. If they're not enough, please inform to me.

Takashi Sakamoto (5):
  ALSA: dice: correct variable types for __be32 data
  ALSA: dice: assign converted data to the same type of variable
  ALSA: fireworks: use u32 type for be32_to_cpup() macro
  ALSA: bebob: use correct type for __be32 data
  ALSA: firewire-digi00x/firewire-tascam: remove wrong conversion for
    Config ROM

 sound/firewire/bebob/bebob_maudio.c          |  2 +-
 sound/firewire/dice/dice-stream.c            | 12 ++++++------
 sound/firewire/dice/dice.c                   |  3 ++-
 sound/firewire/digi00x/digi00x.c             |  3 +--
 sound/firewire/fireworks/fireworks_command.c |  2 +-
 sound/firewire/tascam/tascam.c               |  3 +--
 6 files changed, 12 insertions(+), 13 deletions(-)

-- 
2.1.4
