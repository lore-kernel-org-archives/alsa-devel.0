From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH] pcm_plug: fix comparison always true
Date: Mon,  2 Aug 2010 18:50:08 +0300
Message-ID: <1280764208-12923-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from saarni.dnainternet.net (saarni.dnainternet.net [83.102.40.136])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A29C24521
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 17:50:16 +0200 (CEST)
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
Cc: Anssi Hannula <anssi.hannula@iki.fi>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
---
Fixes an obvious mistake which I noticed while reading the code.
Untested.

 src/pcm/pcm_plug.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index 967cf46..e9d2923 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -485,7 +485,7 @@ static int snd_pcm_plug_change_format(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm_p
 	/* No conversion is needed */
 	if (clt->format == slv->format &&
 	    clt->rate == slv->rate &&
-	    clt->channels == clt->channels)
+	    clt->channels == slv->channels)
 		return 0;
 
 	if (snd_pcm_format_linear(slv->format)) {
-- 
1.7.2
