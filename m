From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH v2 5/5] ctl: correct documentation about TLV
	feature
Date: Thu, 29 Sep 2016 08:57:24 +0900
Message-ID: <1475107044-30647-6-git-send-email-o-takashi@sakamocchi.jp>
References: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 675F12669A9
 for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2016 01:57:31 +0200 (CEST)
In-Reply-To: <1475107044-30647-1-git-send-email-o-takashi@sakamocchi.jp>
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

>From my misunderstanding, some explanations are wrong. This commit
corrects them.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index 40ee9b7..134ba4c 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -59,27 +59,27 @@ elements included in the element set.
 When the value of member is changed, corresponding events are transferred to
 userspace applications. The applications should subscribe any events in advance.
 
-\section tlv_blob Thredshold level and arbitrary data
+\section tlv_blob Supplemental data for elements in an element set
 
-TLV feature is designed to transfer data about threshold level between a driver
-and any userspace applications. The data is for an element set.
+TLV feature is designed to transfer data in a shape of Type/Length/Value,
+between a driver and any userspace applications. The main purpose is to attach
+supplement information for elements to an element set; e.g. dB range.
 
 At first, this feature was implemented to add pre-defined data readable to
 userspace applications. Soon, it was extended to handle several operations;
 read, write and command. The original implementation remains as the read
 operation. The command operation allows drivers to have own implementations
-against requests from userspace applications. As of 2016, simple write operation
-is not supported yet.
+against requests from userspace applications.
 
 This feature was introduced to ALSA control feature in 2006, at commit
 c7a0708a2362, corresponding to a series of work for Linux kernel (42750b04c5ba
 and 8aa9b586e420).
 
-This feature can transfer arbitrary data in a shape of an array with members of
-unsigned int type, therefore it can be used to deliver quite large arbitrary
-data from userspace to in-kernel drivers via ALSA control character device.
-Focusing on this nature, some in-kernel implementations utilize this feature for
-I/O operations.
+There's no limitation about maximum size of the data, therefore it can be used
+to deliver quite large arbitrary data from userspace to in-kernel drivers via
+ALSA control character device. Focusing on this nature, as of 2016, some
+in-kernel implementations utilize this feature for I/O operations. This is
+against the original design.
 */
 
 #include <stdio.h>
-- 
2.7.4
