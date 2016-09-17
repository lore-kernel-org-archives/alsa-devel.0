From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 0/4][alsa-lib] ctl: sync UAPI header for
	TLV-related macros and apply misc changes
Date: Sat, 17 Sep 2016 23:49:24 +0900
Message-ID: <1474123768-13160-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id F1799266499
 for <alsa-devel@alsa-project.org>; Sat, 17 Sep 2016 16:49:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, broonie@kernel.org
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi,

A few days ago, UAPI header of 4.9-pre kernel newly include existent macros
related to TLV operation for user land. Then, applications are going to know
layout of TLV packet payload in the header.

This patchset is for related changes in ALSA user land library. The macros
are put into 'include/sound/tlv.h', however they're not put into
'include/control.h' yet, because currently I have no better idea for library
APIs to parse threshold level information.

Takashi Sakamoto (4):
  Update include/sound/tlv.h from 4.9-pre kernel uapi
  test: use proper threshold level information for user-ctl-element-set
    test
  ctl: improve API documentation for TLV operation
  ctl: improve documentation about TLV-related APIs

 include/sound/tlv.h         | 80 +++++++++++++++++++++++++++++++++++++++++++++
 src/control/control.c       | 21 ++++++++++--
 test/user-ctl-element-set.c | 41 +++++++++++++++--------
 3 files changed, 125 insertions(+), 17 deletions(-)

-- 
2.7.4
