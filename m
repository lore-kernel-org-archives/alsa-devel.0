From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [PATCH 3/3] fix return value of
	snd_pcm_rewind()/snd_pcm_forward()	to return how much
	actually has been rewound,
	instead of what	actually could have rewound
Date: Fri, 18 Jul 2008 21:24:38 +0200
Message-ID: <20080718192438.GA13519@omega>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id BD2FC24571
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 21:24:39 +0200 (CEST)
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

Make snd_pcm_plugin_rewind()/_forward() actually return how much has
been rewound/forwarded instead of how much could have been
rewounded/forwarded. This makes the code actually do what the
documentation of snd_pcm_rewind() suggests.

Signed-off-by: Lennart Poettering <lennart@poettering.net>
---
 src/pcm/pcm_plugin.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index b377cb2..c4f5b4a 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -222,7 +222,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t
 		frames = plugin->client_frames(pcm, sframes);
 	snd_pcm_mmap_appl_backward(pcm, (snd_pcm_uframes_t) frames);
 	snd_atomic_write_end(&plugin->watom);
-	return n;
+	return (snd_pcm_sframes_t) frames;
 }
 
 static snd_pcm_sframes_t snd_pcm_plugin_forwardable(snd_pcm_t *pcm)
@@ -255,7 +255,7 @@ static snd_pcm_sframes_t snd_pcm_plugin_forward(snd_pcm_t *pcm, snd_pcm_uframes_
 		frames = plugin->client_frames(pcm, sframes);
 	snd_pcm_mmap_appl_forward(pcm, (snd_pcm_uframes_t) frames);
 	snd_atomic_write_end(&plugin->watom);
-	return n;
+	return (snd_pcm_sframes_t) frames;
 }
 
 static snd_pcm_sframes_t snd_pcm_plugin_write_areas(snd_pcm_t *pcm,
-- 
1.5.6



Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
