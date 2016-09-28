From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 0/5][alsa-lib] ctl: sync UAPI header for
	TLV-related macros and apply misc changes
Date: Thu, 29 Sep 2016 08:57:19 +0900
Message-ID: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C220526699B
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 01:57:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset updates my former one:
[alsa-devel] [PATCH 0/4][alsa-lib] ctl: sync UAPI header for TLV-related macros and apply misc changes
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-September/112853.html

In this month, UAPI header of 4.9-pre kernel newly include existent macros
related to TLV operation for user land. This is to allow applications to
register TLV information to element set which they added.

This patchset is for related changes in ALSA user land library. The macros
are put into 'include/sound/tlv.h'. However corresponding macros are not
put into 'include/control.h' yet because currently I have no better idea
for library APIs to construct tlv information.

This patchset also improves some corrections for documentation which
committed with my misunderstandings.


Takashi Sakamoto (5):
  Update include/sound/tlv.h from 4.9-pre kernel uapi
  test: use actual information for TLV operation
  ctl: improve API documentation for TLV operation
  ctl: improve documentation about TLV-related APIs
  ctl: correct documentation about TLV feature

 include/sound/tlv.h         |  77 ++++++++++++++++
 src/control/control.c       |  47 +++++++---
 test/user-ctl-element-set.c | 214 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 289 insertions(+), 49 deletions(-)

-- 
2.7.4
