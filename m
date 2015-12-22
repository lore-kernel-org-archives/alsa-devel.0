From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: dice: improve card registration
	processing
Date: Tue, 22 Dec 2015 22:45:39 +0900
Message-ID: <1450791943-14624-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 09CD1265834
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2015 14:45:48 +0100 (CET)
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

This patchset is to update a part of my previous RFCv2 (patch 01, 03 and 04. 02 is dropped according to Clemens' comment).

[alsa-devel] [RFC][PATCH 00/10 v2] ALSA: dice: stabiliza packet streaming
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101897.html

The main purpose of this patchset is to postpone card registration after
successive bus resets, to ensure probe processing and related transactions.
This change has effects for ALSA dice driver to get proper information about
hardware, especially for Dice II based models.

Changes from RFC v2:
 * Patch 03 is newly added to drop a workaround to ensure transactions under
   a situation of probe processing with successive bus reset.
 * Comment updates.

Takashi Sakamoto (4):
  ALSA: dice: split subaddress check from category check
  ALSA: dice: postpone card registration
  ALSA: dice: purge transaction initialization at timeout of Dice
    notification
  ALSA: dice: expand timeout to wait for Dice notification

 sound/firewire/dice/dice-transaction.c | 122 +++++++++++++++--------
 sound/firewire/dice/dice.c             | 177 ++++++++++++++++-----------------
 sound/firewire/dice/dice.h             |   3 +
 3 files changed, 166 insertions(+), 136 deletions(-)

-- 
2.5.0
