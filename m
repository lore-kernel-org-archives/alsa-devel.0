From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 1/3] clamp snd_pcm_rewind()/snd_pcm_forward()
	into the	right direction
Date: Fri, 18 Jul 2008 21:21:23 +0200
Message-ID: <20080718192123.GA13440@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id E2F8824561
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 21:21:26 +0200 (CEST)
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


The clamping of the input parameter in snd_pcm_rewind()/_forward() is
in the wrong direction.

Signed-off-by: Lennart Poettering <lennart@poettering.net>
---
 src/pcm/pcm_plugin.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index c73a02b..c199d8d 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -203,7 +203,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 	snd_pcm_sframes_t n = snd_pcm_mmap_hw_avail(pcm);
 	snd_pcm_sframes_t sframes;
 
-	if ((snd_pcm_uframes_t)n > frames)
+	if ((snd_pcm_uframes_t)n < frames)
 		frames = n;
 	if (frames == 0)
 		return 0;
@@ -236,7 +236,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 	snd_pcm_sframes_t n = snd_pcm_mmap_avail(pcm);
 	snd_pcm_uframes_t sframes;
 
-	if ((snd_pcm_uframes_t)n > frames)
+	if ((snd_pcm_uframes_t)n < frames)
 		frames = n;
 	if (frames == 0)
 		return 0;
-- 
1.5.6

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
