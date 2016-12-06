From: libin.yang@intel.com
Subject: [PATCH v4 3/3] ALSA: Documentation about HDA DP MST
	pin init and connection
Date: Tue,  6 Dec 2016 10:48:39 +0800
Message-ID: <1480992519-108079-4-git-send-email-libin.yang@intel.com>
References: <1480992519-108079-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F6E72668D1
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 03:54:41 +0100 (CET)
In-Reply-To: <1480992519-108079-1-git-send-email-libin.yang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: libin.yang@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Add the documentation about HD-audio DP MST:
1. pin initialization
2. device entry connection list

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 Documentation/sound/hd-audio/dp-mst.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/sound/hd-audio/dp-mst.rst b/Documentation/sound/hd-audio/dp-mst.rst
index 58b7243..1617459 100644
--- a/Documentation/sound/hd-audio/dp-mst.rst
+++ b/Documentation/sound/hd-audio/dp-mst.rst
@@ -19,6 +19,23 @@ PCM
 ===
 To be added
 
+Pin Initialization
+==================
+Each pin may have several device entries (virtual pins). On Intel platform,
+the device entries number is dynamically changed. If DP MST hub is connected,
+it is in DP MST mode, and the device entries number is 3. Otherwise, the
+device entries number is 1.
+
+To simplify the implementation, all the device entries will be initialized
+when bootup no matter whether it is in DP MST mode or not.
+
+Connection list
+===============
+DP MST reuses connection list code. The code can be reused because
+device entries on the same pin have the same connection list.
+
+This means DP MST gets the device entry connection list without the
+device entry setting.
 
 Jack
 ====
-- 
2.7.4
