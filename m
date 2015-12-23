From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4 v2] ALSA: dice: improve card registration
	processing
Date: Thu, 24 Dec 2015 07:55:06 +0900
Message-ID: <1450911310-15507-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 36813265932
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 23:55:20 +0100 (CET)
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

This patchset is to update my previous one:

[alsa-devel] [PATCH 0/4] ALSA: dice: improve card registration processing
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102357.html

The main purpose of this patchset is to postpone card registration after
successive bus resets, to ensure the processing and related transactions.
This change has an advantage for ALSA dice driver to get proper information
about hardware, especially for Dice II based models.

Changes from v1:
 * fix jiffies64 handling bug 
 * rename some members and functions related to card registration.
  * 'struct snd_dice.probed' -> 'registered'
  * do_probe() -> do_registration()

Takashi Sakamoto (4):
  ALSA: dice: split subaddress check from category check
  ALSA: dice: postpone card registration
  ALSA: dice: purge transaction initialization at timeout of Dice
    notification
  ALSA: dice: expand timeout to wait for Dice notification

 sound/firewire/dice/dice-transaction.c | 122 ++++++++++++++--------
 sound/firewire/dice/dice.c             | 183 ++++++++++++++++-----------------
 sound/firewire/dice/dice.h             |   3 +
 3 files changed, 172 insertions(+), 136 deletions(-)

-- 
2.5.0
