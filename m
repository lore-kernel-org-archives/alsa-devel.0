From: furrywolf <alsa2@bushytails.net>
Subject: [PATCH - alsa-lib 1/1] Patch for another bug in
	snd_pcm_area_silence().
Date: Thu,  1 Feb 2018 10:12:12 -0800
Message-ID: <1517508732-27545-1-git-send-email-alsa2@bushytails.net>
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
Cc: alsa-devel@alsa-project.org, furrywolf <alsa2@bushytails.net>
List-Id: alsa-devel@alsa-project.org

Only silence areas 64 bits at a time if it's possible to do so, which is
when either the silence values are all zero, or when the format width
divides evenly into 64 bits.  For formats that are neither of these, let
the width-specific code handle the entire silencing.  Silencing formats
that are not evenly divisible into 64 bits in 64-bit chunks, when the
data isn't just zeroes, results in values being written to shifting
positions in the sample, giving garbage.

Makes Takashi Sakamoto's tester happy for all tests.  Yay!  (And Thanks!)

Signed-off-by: furrywolf <alsa2@bushytails.net>

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 1753cda..5f9bd9f 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -2947,7 +2947,7 @@ int snd_pcm_area_silence(const snd_pcm_channel_area_t *dst_area, snd_pcm_uframes
 	dst = snd_pcm_channel_area_addr(dst_area, dst_offset);
 	width = snd_pcm_format_physical_width(format);
 	silence = snd_pcm_format_silence_64(format);
-	if (dst_area->step == (unsigned int) width) {
+	if (dst_area->step == (unsigned int) width && (!silence || !(64 % width))) {
 		unsigned int dwords = samples * width / 64;
 		uint64_t *dstp = (uint64_t *)dst;
 		samples -= dwords * 64 / width;
-- 
1.9.1
