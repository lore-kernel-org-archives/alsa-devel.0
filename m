From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: [PATCH] ICE1712: add surround71 pcm definition
Date: Tue,  1 Jul 2014 00:40:48 +0600
Message-ID: <1404153648-3201-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B59E26558B
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 20:41:18 +0200 (CEST)
Received: by mail-la0-f51.google.com with SMTP id mc6so5050524lab.24
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 11:41:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Alexander E. Patrakov" <patrakov@gmail.com>, mzagrabe@d.umn.edu
List-Id: alsa-devel@alsa-project.org

The M-Audio Delta 1010 card has 7.1 analog output, but no ready-made pcm
definition to use it.

Signed-off-by: Alexander E. Patrakov <patrakov@gmail.com>
Reported-and-tested-by: Matt Zagrabelny <mzagrabe@d.umn.edu>
---
 src/conf/cards/ICE1712.conf | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/conf/cards/ICE1712.conf b/src/conf/cards/ICE1712.conf
index 398fa7a..db62684 100644
--- a/src/conf/cards/ICE1712.conf
+++ b/src/conf/cards/ICE1712.conf
@@ -78,6 +78,7 @@ ICE1712.pcm.surround40.0 {
 <confdir:pcm/surround41.conf>
 <confdir:pcm/surround50.conf>
 <confdir:pcm/surround51.conf>
+<confdir:pcm/surround71.conf>
 
 ICE1712.pcm.surround51.0 {
 	@args [ CARD ]
@@ -98,6 +99,27 @@ ICE1712.pcm.surround51.0 {
 	slave.channels 10
 }
 
+ICE1712.pcm.surround71.0 {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type route
+	ttable.0.0 1
+	ttable.1.1 1
+	ttable.2.2 1
+	ttable.3.3 1
+	ttable.4.4 1
+	ttable.5.5 1
+	ttable.6.6 1
+	ttable.7.7 1
+	slave.pcm {
+		type hw
+		card $CARD
+	}
+	slave.channels 10
+}
+
 <confdir:pcm/iec958.conf>
 
 ICE1712.pcm.iec958.0 {
-- 
2.0.0
