From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: dice: improve Dice notification
	handling
Date: Thu, 11 Feb 2016 20:18:36 +0900
Message-ID: <1455189518-29261-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D02226067A
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2016 12:18:44 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset improves Dice notification handling mainly for old firmwares.

Dice-based models with earlier firmwares brings 'fail to ensure phase lock'
message to ALSA dice driver. This is due to no Dice transaction at
confirming clock status. Although this patchet enables ALSA dice driver to
handle Dice-based models with old firmwares, I reccomend users to work with
updated firmwares because they may include some bug fixes and improve
device's behaviours.

Regards

Takashi Sakamoto (2):
  ALSA: dice: change notification mask to detect lock status change
  ALSA: dice: old firmware optimization for Dice notification

 sound/firewire/dice/dice-stream.c      | 17 ++++++++++++++---
 sound/firewire/dice/dice-transaction.c |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.5.0
