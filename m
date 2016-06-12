From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 08/10] ctl: add explaination about threshold
	level feature
Date: Sun, 12 Jun 2016 17:16:09 +0900
Message-ID: <1465719371-27721-9-git-send-email-o-takashi@sakamocchi.jp>
References: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EFD412605E8
 for <alsa-devel@alsa-project.org>; Sun, 12 Jun 2016 10:16:18 +0200 (CEST)
In-Reply-To: <1465719371-27721-1-git-send-email-o-takashi@sakamocchi.jp>
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
index 6893012..1039dc2 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -58,6 +58,28 @@ elements included in the element set.
 
 When the value of member is changed, corresponding events are transferred to
 userspace applications. The applications should subscribe any events in advance.
+
+\section tlv_topology Thredshold level and topology framework
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
+unsigned int type. Focusing on this attribute, this feature is utilized as a
+basin of topology framework introduced in 2015. This framework is mainly used to
+describe widget graph of HDA codecs so that ASoC HDA driver can add control
+element sets without retrieve the data from HDA codecs via HDA controller.
 */
 
 #include <stdio.h>
-- 
2.7.4
