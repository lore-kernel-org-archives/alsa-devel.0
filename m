From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: [PATCH] [salsa] Fix 4bit enable/disable flag
Date: Wed, 21 Dec 2011 20:13:47 +0530
Message-ID: <1324478627-32469-1-git-send-email-arun.raghavan@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B7882432E
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 15:43:26 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

The documentation and implementation disagree on the name of the switch.
---
 configure.ac |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6a55813..b72adf3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -116,7 +116,7 @@ AC_ARG_ENABLE(float,
 		 [support floatin-point unit]),
   support_float="$enableval", support_float="no")
 
-AC_ARG_ENABLE(support_4bit,
+AC_ARG_ENABLE(4bit,
   AS_HELP_STRING([--disable-4bit],
 		 [drop the support for 4bit PCM (IMA ADPCM)]),
   support_4bit="$enableval", support_4bit="yes")
-- 
1.7.8
