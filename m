From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] alsactl/init: Change the "basic rules"
	description
Date: Mon, 12 Jan 2015 16:48:37 +0100
Message-ID: <1421077718-4147-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B3D0326064E
 for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2015 16:48:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

We now enable more outputs than just the main speaker, so update
the basic rules to reflect the actual situation.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 alsactl/init/default | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alsactl/init/default b/alsactl/init/default
index 5fb0113..64f933f 100644
--- a/alsactl/init/default
+++ b/alsactl/init/default
@@ -3,7 +3,7 @@
 #
 # Basic rules are:
 #  - keep volumes at minimal level, but sound should be hearable
-#  - enable just main speakers for playback and main microphone for recording
+#  - enable standard outputs for playback and main microphone for recording
 #
 
 # **************************************************************************
-- 
1.9.1
