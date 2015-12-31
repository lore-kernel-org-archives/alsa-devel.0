From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4 v5] ALSA: dice: improve card registration
	processing
Date: Thu, 31 Dec 2015 13:58:10 +0900
Message-ID: <1451537894-28366-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 99043261563
 for <alsa-devel@alsa-project.org>; Thu, 31 Dec 2015 05:58:24 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, stefanr@s5r6.in-berlin.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my previous one:
[alsa-devel] [PATCH 0/5 v4] ALSA: dice: improve card registration processing
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/102504.html

Changes:
 * Merge patch 02 and 03 in v4.
 * Allocate sound card instance in sound card registration work, independently
   of dice instance, allocated in .probe callback and set as driver_data of
   device structure.
 * Use __be32 type for __be32 data.

In this version, sound card instance is not allocated in .probe callback. In
the callback, dice instance is allocated independently of the card instance.
Thus, in .probe callback, this driver reserve no slot of sound card. The
allocation of sound card instance is performed in a scheduled work. When
processing in the work fails, the work can be re-scheduled again according to
bus reset.

Takashi Sakamoto (4):
  ALSA: dice: split subaddress check from category check
  ALSA: dice: postpone card registration
  ALSA: dice: purge transaction initialization at timeout of Dice
    notification
  ALSA: dice: expand timeout to wait for Dice notification

 sound/firewire/dice/dice-transaction.c | 123 +++++++++++-------
 sound/firewire/dice/dice.c             | 227 +++++++++++++++++----------------
 sound/firewire/dice/dice.h             |   3 +
 3 files changed, 202 insertions(+), 151 deletions(-)

-- 
2.5.0
