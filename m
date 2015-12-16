From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4] ALSA: oxfw: localize stuffs of old
	firewire-speakers module
Date: Wed, 16 Dec 2015 20:37:53 +0900
Message-ID: <1450265877-14390-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 396C126584E
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 12:38:01 +0100 (CET)
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

ALSA oxfw module inherits some stuffs from old firewire-speakers module.
Currently, the module's common structure has some members for the stuffs.
This is not good because these stuffs are not common between all of
supported models. It's better to localize them.

The purpose of this patchset is to enable the module to have memory block
and push model-specific stuffs to each structure. This patchset is a part
of my previous RFCv2 (patch 06-09) and a preparation for rest of the patches:

[alsa-devel] [RFC][PATCH 00/17 v2] ALSA: oxfw: refactoring and merging scs1x module
http://mailman.alsa-project.org/pipermail/alsa-devel/2015-December/101558.html

Takashi Sakamoto (4):
  ALSA: oxfw: enable to keep memory block for model-specific structure
  ALSA: oxfw: move model-specific members from common structure
  ALSA: oxfw: move model-specific parameters from common structure
  ALSA: oxfw: rename a structure so that it means backward compatibility
    to old drivers

 sound/firewire/oxfw/oxfw-spkr.c | 96 ++++++++++++++++++++++++++---------------
 sound/firewire/oxfw/oxfw.c      | 31 +++++++------
 sound/firewire/oxfw/oxfw.h      | 17 +-------
 3 files changed, 79 insertions(+), 65 deletions(-)

-- 
2.5.0
