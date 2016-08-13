From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/2] ALSA: rawmidi: add runtime error state for
	disorder of data transmission
Date: Sat, 13 Aug 2016 21:39:15 +0900
Message-ID: <1471091957-14757-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 85793265AED
 for <alsa-devel@alsa-project.org>; Sat, 13 Aug 2016 14:39:23 +0200 (CEST)
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

This patchset is based on an idea addressed in this thread:
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-February/104589.html

For packet-oriented drivers such as USB Audio Device class, message
transmission can fail due to data bus issue. In this case, corresponding
rawmidi runtime should be closed. Although, current ALSA rawmidi core has
no mechanism to help applications/drivers to handle this situation.

This commit adds a helper functions for this aim.

Takashi Sakamoto (2):
  ALSA: rawmidi: handle error state for broken logical channel
  ALSA: rawmidi: add a helper to set runtime error

 include/sound/rawmidi.h |  3 ++
 sound/core/rawmidi.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.7.4
