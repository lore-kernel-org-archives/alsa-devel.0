From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: dice: fix a fatal bug when no sound
	card is registered
Date: Sat, 26 Mar 2016 21:05:57 +0900
Message-ID: <1458993959-22637-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id ECC9D2614FD
 for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2016 13:06:04 +0100 (CET)
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

This patchset is for Linux 4.6-rc2.

ALSA dice driver causes kernel NULL pointer dereference in a case that
no sound card instance is registered and unit is going to be removed.
This is observed when dice-based units are connected to Linux system and
disconnected within 2 seconds, thus it's rare.

Additionally, even if the bug is fixed, the driver dumps warnings for
most dice-based models which supports a pair of isochronous streams.
This can occur regardless of the former bug. Users can see this for
unsupported dice-based models.

This patchset fixes these bugs.

Takashi Sakamoto (2):
  ALSA: dice: fix NULL pointer dereference at remove units when sound
    card is not registered
  ALSA: firewire-lib: skip releasing stream data when it's not
    initialized

 sound/firewire/amdtp-stream.c     |  4 ++++
 sound/firewire/dice/dice-stream.c | 14 ++++----------
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.7.3
