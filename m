From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: bebob/fireworks: remove module
	parameters to reduce maintenance work
Date: Tue, 29 Mar 2016 22:22:13 +0900
Message-ID: <1459257735-13596-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ECD5261A8E
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 15:22:23 +0200 (CEST)
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

This patchset removes some module parameters from ALSA bebob and fireworks
driver.

These two modules have three parameters for users to assign preferable
number and strings to a sound card as some modules in ALSA kernel land.
However, they're not used so widely, and practically I suspect their
advantages.

To simplify and unify the shape of modules in ALSA firewire stack, I'd
like to remove them.

Takashi Sakamoto (2):
  ALSA: bebob: remove module parameters to reduce maintenance work
  ALSA: fireworks: remove module parameters to reduce maintenance work

 sound/firewire/bebob/bebob.c         | 49 +++++-------------------------------
 sound/firewire/bebob/bebob.h         |  1 -
 sound/firewire/fireworks/fireworks.c | 43 +++----------------------------
 sound/firewire/fireworks/fireworks.h |  1 -
 4 files changed, 10 insertions(+), 84 deletions(-)

-- 
2.7.3
