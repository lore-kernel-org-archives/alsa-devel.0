From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH alsa-lib] pcm_dshare: Fix segfault when not
	binding channel 0
Date: Tue, 20 Nov 2018 21:43:44 +0100
Message-ID: <20181120204344.1623-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id C75BE2677E8
 for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2018 21:42:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

Configuration to reproduce:

~~~~
pcm.share_right {
  type dshare
  ipc_key 73
  ipc_perm 0666
  slave {
    pcm "hw:0,0"
  }
  bindings {
    # the seagfault happens when we don't bind channel 0
    1 1
  }
}
~~~~

Execute to reproduce:

~~~~
$ aplay -D plug:share_right test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Segmentation fault
~~~~

For channels whithout binding, values are set to UINT_MAX in function
`snd_pcm_direct_parse_bindings()`:

~~~~
	for (chn = 0; chn < count; chn++)
		bindings[chn] = UINT_MAX;		/* don't route */
~~~~

But, these values are not checked when playing, which causes the segfault.

This commit fixes the issue.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 src/pcm/pcm_dshare.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_dshare.c b/src/pcm/pcm_dshare.c
index 54dc9d48..2bb735fe 100644
--- a/src/pcm/pcm_dshare.c
+++ b/src/pcm/pcm_dshare.c
@@ -67,7 +67,9 @@ static void do_silence(snd_pcm_t *pcm)
 	format = dshare->shmptr->s.format;
 	for (chn = 0; chn < channels; chn++) {
 		dchn = dshare->bindings ? dshare->bindings[chn] : chn;
-		snd_pcm_area_silence(&dst_areas[dchn], 0, dshare->shmptr->s.buffer_size, format);
+		if (dchn != UINT_MAX)
+			snd_pcm_area_silence(&dst_areas[dchn], 0,
+					     dshare->shmptr->s.buffer_size, format);
 	}
 }
 
@@ -91,7 +93,9 @@ static void share_areas(snd_pcm_direct_t *dshare,
 	} else {
 		for (chn = 0; chn < channels; chn++) {
 			dchn = dshare->bindings ? dshare->bindings[chn] : chn;
-			snd_pcm_area_copy(&dst_areas[dchn], dst_ofs, &src_areas[chn], src_ofs, size, format);
+			if (dchn != UINT_MAX)
+				snd_pcm_area_copy(&dst_areas[dchn], dst_ofs,
+						  &src_areas[chn], src_ofs, size, format);
 
 		}
 	}
@@ -834,8 +838,11 @@ int snd_pcm_dshare_open(snd_pcm_t **pcmp, const char *name,
 		dshare->spcm = spcm;
 	}
 
-	for (chn = 0; chn < dshare->channels; chn++)
-		dshare->u.dshare.chn_mask |= (1ULL<<dshare->bindings[chn]);
+	for (chn = 0; chn < dshare->channels; chn++) {
+		unsigned int dchn = dshare->bindings ? dshare->bindings[chn] : chn;
+		if (dchn != UINT_MAX)
+			dshare->u.dshare.chn_mask |= (1ULL << dchn);
+	}
 	if (dshare->shmptr->u.dshare.chn_mask & dshare->u.dshare.chn_mask) {
 		SNDERR("destination channel specified in bindings is already used");
 		dshare->u.dshare.chn_mask = 0;
-- 
2.13.6
