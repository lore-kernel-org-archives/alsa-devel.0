From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 3/3] conf: Allow 2.1 surround to use different
	number of channels
Date: Fri, 21 Feb 2014 16:24:22 +0100
Message-ID: <1392996262-27970-4-git-send-email-david.henningsson@canonical.com>
References: <1392996262-27970-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id C41CC2658F8
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 16:24:27 +0100 (CET)
In-Reply-To: <1392996262-27970-1-git-send-email-david.henningsson@canonical.com>
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

This way, cards that support LFE on four channels (e g laptop with
internal subwoofer) can do that, and other cards on a six channel setup
can use that as well.

Well, note that there is still a reference to "pcm.surround51" left here.
In practice, for HDA Intel sound cards this does not matter as both
surround51 and surround40 reference the same definition.
(And that's the only card I currently know of that actually does
surround2.1 over four channels.)

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/pcm/surround21.conf | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/conf/pcm/surround21.conf b/src/conf/pcm/surround21.conf
index be29020..7f4676b 100644
--- a/src/conf/pcm/surround21.conf
+++ b/src/conf/pcm/surround21.conf
@@ -51,10 +51,9 @@ pcm.!surround21 {
 			]
 		}
 	}
-	slave.channels 6
-	ttable.0.0 1
-	ttable.1.1 1
-	ttable.2.5 1
+	ttable.0.FL 1
+	ttable.1.FR 1
+	ttable.2.LFE 1
 	hint {
 		description "2.1 Surround output to Front and Subwoofer speakers"
 		device $DEV
-- 
1.9.0
