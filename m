From: Luca Bayer <kometto@web.de>
Subject: [PATCH - plugins] oss: avoid conflict between reclev
	and igain mixer ctls
Date: Wed, 04 Dec 2013 03:07:33 +0100
Message-ID: <20131204.86haapnzbu@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EE302652FD
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 03:07:37 +0100 (CET)
Received: from nil ([185.25.253.24]) by smtp.web.de (mrweb002) with ESMTPA
 (Nemesis) id 0LnBPR-1V7H8k3l41-00hLJI for <alsa-devel@alsa-project.org>; Wed,
 04 Dec 2013 03:07:37 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

To fix the following error that happens with Intel HDA driver.

  $ amixer
  ALSA lib simple_none.c:1549:(simple_add1) helem (MIXER,'Capture Volume',0,0,0) appears twice or more
  amixer: Mixer default load error: Invalid argument

Signed-off-by: Luca Bayer <kometto@web.de>

diff --git a/oss/ctl_oss.c b/oss/ctl_oss.c
index b8847b1..b05ba18 100644
--- a/oss/ctl_oss.c
+++ b/oss/ctl_oss.c
@@ -52,7 +52,7 @@ static const char *const vol_devices[SOUND_MIXER_NRDEVICES] = {
 	[SOUND_MIXER_CD] =	"CD Playback Volume",
 	[SOUND_MIXER_IMIX] =	"Monitor Mix Playback Volume",
 	[SOUND_MIXER_ALTPCM] =	"Headphone Playback Volume",
-	[SOUND_MIXER_RECLEV] =	"Capture Volume",
+	[SOUND_MIXER_RECLEV] =	"Master Capture Volume",
 	[SOUND_MIXER_IGAIN] =	"Capture Volume",
 	[SOUND_MIXER_OGAIN] =	"Playback Volume",
 	[SOUND_MIXER_LINE1] =	"Aux Playback Volume",
