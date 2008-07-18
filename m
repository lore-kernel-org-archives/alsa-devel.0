From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 2/3] fix type of internally used sframes
	variable, to avoid	unnecessary casts
Date: Fri, 18 Jul 2008 21:22:50 +0200
Message-ID: <20080718192250.GA13489@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id F21C824570
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 21:22:50 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This minor patch fixes the type of the sframes variable in
snd_pcm_plugin_forward(). With this fix we need to cast less and the
code is less confusing.

Signed-off-by: Lennart Poettering <lennart@poettering.net>
---
 src/pcm/pcm_plugin.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index c199d8d..b377cb2 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -234,7 +234,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 {
 	snd_pcm_plugin_t *plugin = pcm->private_data;
 	snd_pcm_sframes_t n = snd_pcm_mmap_avail(pcm);
-	snd_pcm_uframes_t sframes;
+	snd_pcm_sframes_t sframes;
 
 	if ((snd_pcm_uframes_t)n < frames)
 		frames = n;
@@ -246,8 +246,8 @@ static snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 	else
 		sframes = frames;
 	snd_atomic_write_begin(&plugin->watom);
-	sframes = INTERNAL(snd_pcm_forward)(plugin->gen.slave, (snd_pcm_uframes_t) sframes);
-	if ((snd_pcm_sframes_t) sframes < 0) {
+	sframes = INTERNAL(snd_pcm_forward)(plugin->gen.slave, sframes);
+	if (sframes < 0) {
 		snd_atomic_write_end(&plugin->watom);
 		return sframes;
 	}
-- 
1.5.6

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
