From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 7/9] ctl: add explanation about threshold level
	feature
Date: Wed, 15 Jun 2016 23:57:43 +0900
Message-ID: <1466002665-30048-8-git-send-email-o-takashi@sakamocchi.jp>
References: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 19C50266AEA
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:57:53 +0200 (CEST)
In-Reply-To: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
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

ALSA ctl feature includes threshold level feature. This is introduced in
2006, and there's little resources about it.

This commit adds a simple explanation about the feature.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/control/control.c b/src/control/control.c
index 38700bb..a1d7098 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -58,6 +58,28 @@ elements included in the element set.
 
 When the value of member is changed, corresponding events are transferred to
 userspace applications. The applications should subscribe any events in advance.
+
+\section tlv_blob Thredshold level and arbitrary data
+
+TLV feature is designed to transfer data about threshold level between a driver
+and any userspace applications. The data is for an element set.
+
+At first, this feature was implemented to add pre-defined data readable to
+userspace applications. Soon, it was extended to handle several operations;
+read, write and command. The original implementation remains as the read
+operation. The command operation allows drivers to have own implementations
+against requests from userspace applications. As of 2016, simple write operation
+is not supported yet.
+
+This feature was introduced to ALSA control feature in 2006, at commit
+c7a0708a2362, corresponding to a series of work for Linux kernel (42750b04c5ba
+and 8aa9b586e420).
+
+This feature can transfer arbitrary data in a shape of an array with members of
+unsigned int type, therefore it can be used to deliver quite large arbitrary
+data from userspace to in-kernel drivers via ALSA control character device.
+Focusing on this nature, some in-kernel implementations utilize this feature for
+I/O operations.
 */
 
 #include <stdio.h>
-- 
2.7.4
