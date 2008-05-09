From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH 2.6.26-rc1] ASoC: Fix TLV320AIC3X mono line
	output interconnect
Date: Fri,  9 May 2008 14:02:45 +0300
Message-ID: <1210330965-24830-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id D2AF324430
	for <alsa-devel@alsa-project.org>;
	Fri,  9 May 2008 13:02:17 +0200 (CEST)
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	m49B1sTO003942
	for <alsa-devel@alsa-project.org>; Fri, 9 May 2008 14:02:15 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>
List-Id: alsa-devel@alsa-project.org

There is no endpoint called MONOLOUT but MONO_LOUT.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 sound/soc/codecs/tlv320aic3x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 630684f..09b1661 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -539,8 +539,8 @@ static const char *intercon[][3] = {
 	{"HPRCOM", NULL, "Right HP Com"},
 
 	/* Mono Output */
-	{"MONOLOUT", NULL, "Mono Out"},
-	{"MONOLOUT", NULL, "Mono Out"},
+	{"MONO_LOUT", NULL, "Mono Out"},
+	{"MONO_LOUT", NULL, "Mono Out"},
 
 	/* Left Input */
 	{"Left Line1L Mux", "single-ended", "LINE1L"},
-- 
1.5.4.4
