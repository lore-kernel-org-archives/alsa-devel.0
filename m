From: Adam Miartus <amiartus@de.adit-jv.com>
Subject: [PATCH 1/2] pcm_file: remove double line
Date: Mon, 24 Jun 2019 13:23:23 +0200
Message-ID: <1561375404-25252-1-git-send-email-amiartus@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_pcm_file_add_frames called two times by mistake, introduced in
2a800c0c4f259043c9217a4aa6a57afaf9f77477

Signed-off-by: Adam Miartus <amiartus@de.adit-jv.com>
---
 src/pcm/pcm_file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/pcm/pcm_file.c b/src/pcm/pcm_file.c
index ca8e0c8..11d0953 100644
--- a/src/pcm/pcm_file.c
+++ b/src/pcm/pcm_file.c
@@ -613,7 +613,6 @@ static snd_pcm_sframes_t snd_pcm_file_readi(snd_pcm_t *pcm, void *buffer, snd_pc
 	snd_pcm_areas_from_buf(pcm, areas, buffer);
 	snd_pcm_file_areas_read_infile(pcm, areas, 0, frames);
 	__snd_pcm_lock(pcm);
-	snd_pcm_file_add_frames(pcm, areas, 0, frames);
 	if (snd_pcm_file_add_frames(pcm, areas, 0, frames) < 0) {
 		__snd_pcm_unlock(pcm);
 		return -EPIPE;
-- 
2.7.4
