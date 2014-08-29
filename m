From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] Fix a regression for Dice driver at higher
	sampling rate
Date: Fri, 29 Aug 2014 13:40:43 +0900
Message-ID: <1409287245-15184-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EE99266704
 for <alsa-devel@alsa-project.org>; Fri, 29 Aug 2014 06:40:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: drobbins@funtoo.org, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Commit 10550bea44a8 ("ALSA: dice/firewire-lib: Keep dualwire mode but 
obsolete CIP_HI_DUALWIRE") brought a regression to Dice driver. As a 
result, Dice driver cannot work correctly at higher sampling rate.

This series of patches fixes the regression.

Reported-by: Daniel Robbins <drobbins@funtoo.org>
Fixes: 10550bea44a8 ("ALSA: dice/firewire-lib: Keep dualwire mode but obsolete CIP_HI_DUALWIRE")

Takashi Sakamoto (2):
  ALSA: dice: fix wrong channel mappping at higher sampling rate
  ALSA: firewire-lib/dice: add arrangements of PCM pointer and
    interrupts for Dice quirk

 sound/firewire/amdtp.c | 11 ++++++++++-
 sound/firewire/amdtp.h |  1 +
 sound/firewire/dice.c  | 29 ++++++++++++++++++++---------
 3 files changed, 31 insertions(+), 10 deletions(-)

-- 
1.9.1
