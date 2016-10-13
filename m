From: libin.yang@linux.intel.com
Subject: [RFC PATCH v3 3/3] ALSA: Documentation about HDA DP
	MST pin init and connection
Date: Thu, 13 Oct 2016 15:49:37 +0800
Message-ID: <1476344977-147193-4-git-send-email-libin.yang@linux.intel.com>
References: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AAC8265A98
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 09:54:50 +0200 (CEST)
In-Reply-To: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

Add the documentation about HD-audio DP MST:
1. pin initialization
2. device entry connection list

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt b/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt
index 82744ac..0c5ea7d 100644
--- a/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt
+++ b/Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt
@@ -15,6 +15,23 @@ PCM
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
1.9.1
