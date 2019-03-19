From: Alex Ivanov <gnidorah@ya.ru>
Subject: [PATCH] [-, JACK, plugin,
	1/1] jack: use correct port names in 50-jack.conf
Date: Tue, 19 Mar 2019 20:51:44 +0300
Message-ID: <20190319175144.29420-1-gnidorah@ya.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward103o.mail.yandex.net (forward103o.mail.yandex.net
 [37.140.190.177])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A0B9F8968A
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 18:51:50 +0100 (CET)
Received: from mxback1o.mail.yandex.net (mxback1o.mail.yandex.net
 [IPv6:2a02:6b8:0:1a2d::1b])
 by forward103o.mail.yandex.net (Yandex) with ESMTP id 4DAC25F809D2
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 20:51:49 +0300 (MSK)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Change port names in 50-jack.conf from "alsa_pcm" to "system".

JACK1 v0.125.0 still provides alsa_pcm:playback_* and alsa_pcm:capture_*
port names, but only as aliases:
$ jack_lsp -A
system:capture_1
   alsa_pcm:capture_1
system:capture_2
   alsa_pcm:capture_2
system:playback_1
   alsa_pcm:playback_1
system:playback_2
   alsa_pcm:playback_2

JACK2 v1.9.12 doesn't support alsa_pcm:playback_* and alsa_pcm:capture_*
aliases anymore, so 50-jack.conf will fail for JACK2 users:
$ jack_lsp -A
system:capture_1
   alsa_pcm:hw:0:out1
system:capture_2
   alsa_pcm:hw:0:out2
system:playback_1
   alsa_pcm:hw:0:in1
system:playback_2
   alsa_pcm:hw:0:in2

As you see in both cases system:playback_* and system:capture_* are
correct port names.

Signed-off-by: Alex Ivanov <gnidorah@ya.ru>
---
 jack/50-jack.conf | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/jack/50-jack.conf b/jack/50-jack.conf
index d780dfc..9948f2f 100644
--- a/jack/50-jack.conf
+++ b/jack/50-jack.conf
@@ -1,12 +1,12 @@
 pcm.jack {
 	type jack
 	playback_ports {
-		0 alsa_pcm:playback_1
-		1 alsa_pcm:playback_2
+		0 system:playback_1
+		1 system:playback_2
 	}
 	capture_ports {
-		0 alsa_pcm:capture_1
-		1 alsa_pcm:capture_2
+		0 system:capture_1
+		1 system:capture_2
 	}
 	hint {
 		show {
-- 
2.19.2
