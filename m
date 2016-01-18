From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] tinycompress: cplay: make functions static
Date: Mon, 18 Jan 2016 22:00:01 +0530
Message-ID: <1453134603-25356-2-git-send-email-vinod.koul@intel.com>
References: <1453134603-25356-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB7626517F
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 17:26:29 +0100 (CET)
In-Reply-To: <1453134603-25356-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Sparse rightly complains some functions should be static so make them static

cplay.c:100:5: warning: symbol 'parse_mp3_header' was not declared. Should it be static?
cplay.c:129:5: warning: symbol 'check_codec_format_supported' was not declared. Should it be static?
../../include/tinycompress/tinymp3.h:66:11: warning: symbol 'mp3_sample_rates' was not declared. Should it be static?
../../include/tinycompress/tinymp3.h:72:11: warning: symbol 'mp3_bit_rates' was not declared. Should it be static?

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/tinycompress/tinymp3.h | 4 ++--
 src/utils/cplay.c              | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tinycompress/tinymp3.h b/include/tinycompress/tinymp3.h
index b7b45e3a6109..a709c397ee09 100644
--- a/include/tinycompress/tinymp3.h
+++ b/include/tinycompress/tinymp3.h
@@ -63,13 +63,13 @@ extern "C" {
 
 #define MP3_SYNC 0xe0ff
 
-const int mp3_sample_rates[3][3] = {
+static const int mp3_sample_rates[3][3] = {
 	{44100, 48000, 32000},        /* MPEG-1 */
 	{22050, 24000, 16000},        /* MPEG-2 */
 	{11025, 12000,  8000},        /* MPEG-2.5 */
 };
 
-const int mp3_bit_rates[3][3][15] = {
+static const int mp3_bit_rates[3][3][15] = {
 	{
 		/* MPEG-1 */
 		{  0, 32, 64, 96, 128, 160, 192, 224, 256, 288, 320, 352, 384, 416, 448}, /* Layer 1 */
diff --git a/src/utils/cplay.c b/src/utils/cplay.c
index 2d1a1760b3ec..032a97111402 100644
--- a/src/utils/cplay.c
+++ b/src/utils/cplay.c
@@ -97,7 +97,7 @@ struct mp3_header {
 	uint8_t format2;
 };
 
-int parse_mp3_header(struct mp3_header *header, unsigned int *num_channels,
+static int parse_mp3_header(struct mp3_header *header, unsigned int *num_channels,
 		unsigned int *sample_rate, unsigned int *bit_rate)
 {
 	int ver_idx, mp3_version, layer, bit_rate_idx, sample_rate_idx, channel_idx;
@@ -126,7 +126,7 @@ int parse_mp3_header(struct mp3_header *header, unsigned int *num_channels,
 	return 0;
 }
 
-int check_codec_format_supported(unsigned int card, unsigned int device, struct snd_codec *codec)
+static int check_codec_format_supported(unsigned int card, unsigned int device, struct snd_codec *codec)
 {
 	if (is_codec_supported(card, device, COMPRESS_IN, codec) == false) {
 		fprintf(stderr, "Error: This codec or format is not supported by DSP\n");
-- 
1.9.1
