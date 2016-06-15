From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 1/9] ctl: add an overview for design of ALSA
	control interface
Date: Wed, 15 Jun 2016 23:57:37 +0900
Message-ID: <1466002665-30048-2-git-send-email-o-takashi@sakamocchi.jp>
References: <1466002665-30048-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id B308126689D
 for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2016 16:57:51 +0200 (CEST)
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

This commit adds a description about the design of ALSA control interface
for  developers to understand a few components of low level.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 src/control/control.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/src/control/control.c b/src/control/control.c
index ae78843..504da1f 100644
--- a/src/control/control.c
+++ b/src/control/control.c
@@ -35,9 +35,29 @@ also interface notifying about control and structure changes.
 
 \section control_general_overview General overview
 
-The primitive controls can be integer, inter64, boolean, enumerators, bytes
-and IEC958 structure.
-
+In ALSA control feature, each sound card can have control elements. The elements
+are managed according to below model.
+
+ - element set
+   - A set of elements with the same attribute (i.e. name, get/put operations).
+     Some element sets can be added to a sound card by drivers in kernel and
+     userspace applications.
+ - element
+   - An element can be identified by userspace applications. Each element has
+     own identical information.
+ - member
+   - An element includes some members to have a value. The value of each member
+     can be changed by both of userspace applications and drivers in kernel.
+
+Each element can be identified by two ways; a combination of name and index, or
+numerical number (numid).
+
+The type of element set is one of integer, integerr64, boolean, enumerators,
+bytes and IEC958 structure. This indicates the type of value for each member in
+elements included in the element set.
+
+When the value of member is changed, corresponding events are transferred to
+userspace applications. The applications should subscribe any events in advance.
 */
 
 #include <stdio.h>
-- 
2.7.4
