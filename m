From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/3] route: Allow chmap syntax for slave
	channels in ttable
Date: Fri, 21 Feb 2014 16:24:20 +0100
Message-ID: <1392996262-27970-2-git-send-email-david.henningsson@canonical.com>
References: <1392996262-27970-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B5D682658F4
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 16:24:25 +0100 (CET)
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

Instead of writing e g "0" and "1", one can now write "FL" and "FR" instead.

E g:
	ttable.0.FL 1
	ttable.1.FR 1
	ttable.2.LFE 1

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/pcm/pcm_route.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_route.c b/src/pcm/pcm_route.c
index 2beedf6..ffc283f 100644
--- a/src/pcm/pcm_route.c
+++ b/src/pcm/pcm_route.c
@@ -789,6 +789,24 @@ static void snd_pcm_route_dump(snd_pcm_t *pcm, snd_output_t *out)
 	snd_pcm_dump(route->plug.gen.slave, out);
 }
 
+static int safe_chmapchannel(const char *id, long *channel)
+{
+	int err;
+	int ch;
+	err = safe_strtol(id, channel);
+	if (err >= 0)
+		return err;
+
+	ch = (int) snd_pcm_chmap_from_string(id);
+	if (ch == -1)
+		return -EINVAL;
+
+	/* For now, assume standard channel mapping */
+	*channel = ch - SND_CHMAP_FL;
+	return 0;
+}
+
+
 static const snd_pcm_ops_t snd_pcm_route_ops = {
 	.close = snd_pcm_route_close,
 	.info = snd_pcm_generic_info,
@@ -983,7 +1001,7 @@ int snd_pcm_route_determine_ttable(snd_config_t *tt,
 			const char *id;
 			if (snd_config_get_id(jnode, &id) < 0)
 				continue;
-			err = safe_strtol(id, &schannel);
+			err = safe_chmapchannel(id, &schannel);
 			if (err < 0) {
 				SNDERR("Invalid slave channel: %s", id);
 				return -EINVAL;
@@ -1046,7 +1064,7 @@ int snd_pcm_route_load_ttable(snd_config_t *tt, snd_pcm_route_ttable_entry_t *tt
 			const char *id;
 			if (snd_config_get_id(jnode, &id) < 0)
 				continue;
-			err = safe_strtol(id, &schannel);
+			err = safe_chmapchannel(id, &schannel);
 			if (err < 0 || 
 			    schannel < 0 || (unsigned int) schannel > tt_ssize || 
 			    (schannels > 0 && schannel >= schannels)) {
-- 
1.9.0
