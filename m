From: linux@audioscience.com
Subject: [PATCH 05/15] ALSA: asihpi - Revise snd_pcm_debug_name,
 get rid of DEBUG_NAME macro
Date: Fri, 22 Jul 2011 15:52:44 +1200
Message-ID: <1311306785-23116-10-git-send-email-linux@audioscience.com>
References: <1311306785-23116-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-reply-to: <1311306785-23116-1-git-send-email-linux@audioscience.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: tiwai@suse.de, Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>

Work towards moving the function into alsa common header.

Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>
---
 sound/pci/asihpi/asihpi.c |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 023a62a..60444e7 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -49,19 +49,21 @@ MODULE_DESCRIPTION("AudioScience ALSA ASI5000 ASI6000 ASI87xx ASI89xx");
 #if defined CONFIG_SND_DEBUG
 /* copied from pcm_lib.c, hope later patch will make that version public
 and this copy can be removed */
-static void pcm_debug_name(struct snd_pcm_substream *substream,
-			   char *name, size_t len)
+static inline void
+snd_pcm_debug_name(struct snd_pcm_substream *substream, char *buf, size_t size)
 {
-	snprintf(name, len, "pcmC%dD%d%c:%d",
+	snprintf(buf, size, "pcmC%dD%d%c:%d",
 		 substream->pcm->card->number,
 		 substream->pcm->device,
 		 substream->stream ? 'c' : 'p',
 		 substream->number);
 }
-#define DEBUG_NAME(substream, name) char name[16]; pcm_debug_name(substream, name, sizeof(name))
 #else
-#define pcm_debug_name(s, n, l) do { } while (0)
-#define DEBUG_NAME(name, substream) do { } while (0)
+static inline void
+snd_pcm_debug_name(struct snd_pcm_substream *substream, char *buf, size_t size)
+{
+	*buf = 0;
+}
 #endif
 
 #if defined CONFIG_SND_DEBUG_VERBOSE
@@ -304,7 +306,8 @@ static u16 handle_error(u16 err, int line, char *filename)
 static void print_hwparams(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *p)
 {
-	DEBUG_NAME(substream, name);
+	char name[16];
+	snd_pcm_debug_name(substream, name, sizeof(name));
 	snd_printd("%s HWPARAMS\n", name);
 	snd_printd(" samplerate %d Hz\n", params_rate(p));
 	snd_printd(" channels %d\n", params_channels(p));
@@ -576,8 +579,9 @@ static int snd_card_asihpi_trigger(struct snd_pcm_substream *substream,
 	struct snd_card_asihpi *card = snd_pcm_substream_chip(substream);
 	struct snd_pcm_substream *s;
 	u16 e;
-	DEBUG_NAME(substream, name);
+	char name[16];
 
+	snd_pcm_debug_name(substream, name, sizeof(name));
 	snd_printdd("%s trigger\n", name);
 
 	switch (cmd) {
@@ -741,7 +745,9 @@ static void snd_card_asihpi_timer_function(unsigned long data)
 	int loops = 0;
 	u16 state;
 	u32 buffer_size, bytes_avail, samples_played, on_card_bytes;
-	DEBUG_NAME(substream, name);
+	char name[16];
+
+	snd_pcm_debug_name(substream, name, sizeof(name));
 
 	snd_printdd("%s snd_card_asihpi_timer_function\n", name);
 
-- 
1.7.0.4
