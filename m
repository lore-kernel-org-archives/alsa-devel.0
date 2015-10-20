From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/5 v2] ALSA: firewire-tascam: fix sending the
	same MIDI bytes in two transactions
Date: Tue, 20 Oct 2015 23:46:54 +0900
Message-ID: <1445352419-21827-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 8796D2665CC
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 16:47:04 +0200 (CEST)
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

This patchset is revised version of my previous post:
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-October/099123.html

The main purpose of this patchset is to fix an issue that a transaction can
include MIDI bytes in the next message. The last patch solves this issue,
and the first 4 patches are for better shape of code including a small
fixes.

Changes:
 * add buffer alias
 * refine local variables


Takashi Sakamoto (5):
  ALSA: firewire-tascam: remove buffer initialization in driver side
  ALSA: firewire-tascam: change type of valiables according to function
    prototype
  ALSA: firewire-tascam: use better name for local variables to describe
    their intension
  ALSA: firewire-tascam: fix loop condition with some readable variables
  ALSA: firewire-tascam: clear extra MIDI byte in an asynchronous
    transaction

 sound/firewire/tascam/tascam-transaction.c | 73 +++++++++++++++++-------------
 1 file changed, 41 insertions(+), 32 deletions(-)

-- 
2.1.4
