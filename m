From: sutar.mounesh@gmail.com
Subject: [PATCH 2/2] pcm:plugin: Fix sound capture via MMAP
	access
Date: Tue,  4 Apr 2017 12:00:18 +0530
Message-ID: <1491287418-11297-1-git-send-email-sutar.mounesh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: Mounesh Sutar <sutar.mounesh@gmail.com>, Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Distorted sound is heard if the capture device of an ioplug plugin is used,
which is accessed through any ALSA plugin (like copy, linear, ...) via MMAP access.
E.g. aplay -> loop -> copy -> arecord -M -> aplay -> hw:0
As mentioned in the ALSA API (see pcm/pcm.c:942):
The function #snd_pcm_avail_update() have to be called
before any mmap begin+commit operation.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index aaea2ab..ec57f6e 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -490,7 +490,14 @@ static snd_pcm_sframes_t snd_pcm_plugin_avail_update(snd_pcm_t *pcm)
 			snd_pcm_uframes_t slave_offset;
 			snd_pcm_uframes_t slave_frames = ULONG_MAX;
 			snd_pcm_sframes_t result;
-
+			/* As mentioned in the ALSA API (see pcm/pcm.c:942):
+			 * The function #snd_pcm_avail_update()
+			 * have to be called before any mmap begin+commit operation.
+			 * Otherwise the snd_pcm_areas_copy will not called a second time.
+			 * But this is needed, if the ring buffer wrap is reached and
+			 * there is more data available.
+			 */
+			slave_size = snd_pcm_avail_update(slave);
 			result = snd_pcm_mmap_begin(slave, &slave_areas, &slave_offset, &slave_frames);
 			if (result < 0) {
 				err = result;
-- 
2.7.4
