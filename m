From: Jordi Mallach <jordi@debian.org>
Subject: =?utf-8?q?=5BPATCH_5/8=5D_Fix_spelling_of_=E2=80=9Cs?=
	=?utf-8?b?dWNjZXNzZnVsbHnigJ0u?=
Date: Wed, 15 May 2013 19:19:08 +0200
Message-ID: <1368638351-29200-6-git-send-email-jordi@debian.org>
References: <1368638351-29200-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id C8CBC2652E9
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:22 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 2117662A0B
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 19:19:22 +0200 (CEST)
In-Reply-To: <1368638351-29200-1-git-send-email-jordi@debian.org>
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
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 sb16_csp/cspctl.1 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sb16_csp/cspctl.1 b/sb16_csp/cspctl.1
index 71c4b52..d2f7b5d 100644
--- a/sb16_csp/cspctl.1
+++ b/sb16_csp/cspctl.1
@@ -13,7 +13,7 @@ is a simple CSP microcode loader for Crative Sound Blaster 16ASP and some Sound
 .B cspctl
 can also be used as a post-install function to
 .I snd\-sb16\-csp
-module to load default codec at module installation. If CSP chip is succesfully detected and initialized, it will be installed as a hardware dependant device
+module to load default codec at module installation. If CSP chip is successfully detected and initialized, it will be installed as a hardware dependent device
 .I hwC0D2
 into /dev/snd directory. Currently, following codecs can be loaded to CSP device:
 .IP "" 4
-- 
1.7.10.4
