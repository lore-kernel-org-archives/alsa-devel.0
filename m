From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: firewire: some trivial fixes
Date: Sun, 27 Mar 2016 16:09:05 +0900
Message-ID: <1459062549-18721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B084260711
 for <alsa-devel@alsa-project.org>; Sun, 27 Mar 2016 09:09:14 +0200 (CEST)
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

This patchset includes some trivial fixes for ALSA firewire stack. I don't
mind to postpone them to 4.7 instead of 4.6-rc2.


Regards

Takashi Sakamoto (4):
  ALSA: bebob: remove needless argument from local function
  ALSA: oxfw: remove needless member from private structure
  ALSA: fireworks: move model quirk detection code to information parser
  ALSA: firewire-tascam: add Kconfig entry for TASCAM FW-1804

 sound/firewire/Kconfig               |  1 +
 sound/firewire/bebob/bebob.c         |  4 ++--
 sound/firewire/fireworks/fireworks.c | 21 +++++++++++----------
 sound/firewire/oxfw/oxfw.h           |  1 -
 4 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.7.3
