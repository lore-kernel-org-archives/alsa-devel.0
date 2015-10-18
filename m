From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/3] fix sending the same MIDI bytes in two
	transactions
Date: Sun, 18 Oct 2015 19:02:15 +0900
Message-ID: <1445162538-12293-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 262E0261583
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 12:02:26 +0200 (CEST)
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

In former commits, MIDI functionality is added to TASCAM driver, while
it includes a bug to send the same MIDI bytes in two continuous
transactions.

This patchset is to fix this bug, including some code improvements.

Takashi Sakamoto (3):
  ALSA: tascam: remove buffer initialization in driver side
  ALSA: tascam: improve loop condition to filling MIDI bytes in
    transaction
  ALSA: tascam: clear extra MIDI byte of asynchronous transaction

 sound/firewire/tascam/tascam-transaction.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.1.4
