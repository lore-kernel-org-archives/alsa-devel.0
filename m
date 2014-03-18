From: Maarten Baert <maarten-baert@hotmail.com>
Subject: [PATCH] Use jack_client_open instead of deprecated
	jack_client_new.
Date: Tue, 18 Mar 2014 17:55:14 +0100
Message-ID: <BLU0-SMTP43AF44544297B1681F68AE27C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s29.blu0.hotmail.com (blu0-omc3-s29.blu0.hotmail.com
 [65.55.116.104])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D9C2615DC
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 17:55:21 +0100 (CET)
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

Signed-off-by: Maarten Baert <maarten-baert@hotmail.com>
---
 jack/pcm_jack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 4213708..7a8b24d 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -370,7 +370,7 @@ static int snd_pcm_jack_open(snd_pcm_t **pcmp, const char *name,
 			__func__, jack_client_name, (int)strlen(jack_client_name));
 	}
 
-	jack->client = jack_client_new(jack_client_name);
+	jack->client = jack_client_open(jack_client_name, JackNoStartServer, NULL);
 
 	if (jack->client == 0) {
 		snd_pcm_jack_free(jack);
-- 
1.9.0
