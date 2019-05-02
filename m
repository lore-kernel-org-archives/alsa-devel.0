From: stian.skjelstad@gmail.com
Subject: [PATCH - maemo fixes 1/1] maemo plugin has two crashes
	I was able to see in a valgrind log from another user:
Date: Thu,  2 May 2019 23:26:15 +0200
Message-ID: <20190502212615.11457-1-stian.skjelstad@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Stian Skjelstad <stian.skjelstad@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Stian Skjelstad <stian.skjelstad@gmail.com>

* maximum write size was calculated in words (16bit), but checked against
  byte-size length. This causes memcpy later to overflow the buffer
  (normally by up to 12KB).
* remove a double free (by marking free'd data with NULL)

* mmap returns MMAP_FAILED on error, not NULL

I suspect that this plugin/driver might have other issues aswell, since I
am unable to find any logic for checking DSP buffer status, and no
implementation for odelay reporting.

Author: Stian Skjelstad <stian.skjelstad@gmail.com>
Signed-off-by: Stian Skjelstad <stian.skjelstad@gmail.com>

diff --git a/maemo/alsa-dsp.c b/maemo/alsa-dsp.c
index 7e04f6a..3307384 100644
--- a/maemo/alsa-dsp.c
+++ b/maemo/alsa-dsp.c
@@ -135,18 +135,18 @@ static snd_pcm_sframes_t alsa_dsp_transfer(snd_pcm_ioplug_t * io,
 	snd_pcm_alsa_dsp_t *alsa_dsp = io->private_data;
 	DENTER();
 	char *buf;
-	int words;
+	int bytes, words;
 	ssize_t result;
 
-	words = size * alsa_dsp->bytes_per_frame;
-	words /= 2;
-	DPRINT("***** Info: words %d size %lu bpf: %d\n", words, size,
-	       alsa_dsp->bytes_per_frame);
-	if (words > alsa_dsp->dsp_protocol->mmap_buffer_size) {
-		DERROR("Requested too much data transfer (playing only %d)\n",
-		       alsa_dsp->dsp_protocol->mmap_buffer_size);
-		words = alsa_dsp->dsp_protocol->mmap_buffer_size;
+	bytes = size * alsa_dsp->bytes_per_frame;
+	DPRINT("***** Info: samples %lu * bpf %d => bytes %d\n",
+	       size, alsa_dsp->bytes_per_frame, bytes);
+	if (bytes > alsa_dsp->dsp_protocol->mmap_buffer_size) {
+		DERROR("Requested too much data transfer (requested %d, playing only %d)\n",
+		       bytes, alsa_dsp->dsp_protocol->mmap_buffer_size);
+		bytes = alsa_dsp->dsp_protocol->mmap_buffer_size;
 	}
+	words = bytes / 2;
 	if (alsa_dsp->dsp_protocol->state != STATE_PLAYING) {
 		DPRINT("I did nothing - No start sent\n");
 		alsa_dsp_start(io);
diff --git a/maemo/dsp-ctl.c b/maemo/dsp-ctl.c
index 5bcda36..ac05942 100644
--- a/maemo/dsp-ctl.c
+++ b/maemo/dsp-ctl.c
@@ -93,6 +93,7 @@ static void dsp_ctl_close(snd_ctl_ext_t * ext)
 	snd_ctl_dsp_t *dsp_ctl = ext->private_data;
 	DENTER();
 	free(dsp_ctl->controls);
+	dsp_ctl->controls = NULL;
 	free_control_list(&(dsp_ctl->playback_devices));
 	free_control_list(&(dsp_ctl->recording_devices));
 //      free(dsp_ctl);
diff --git a/maemo/dsp-protocol.c b/maemo/dsp-protocol.c
index af67251..32193d3 100644
--- a/maemo/dsp-protocol.c
+++ b/maemo/dsp-protocol.c
@@ -194,7 +194,7 @@ int dsp_protocol_open_node(dsp_protocol_t * dsp_protocol, const char *device)
 	    mmap((void *)0, dsp_protocol->mmap_buffer_size,
 		 PROT_READ | PROT_WRITE, MAP_SHARED, dsp_protocol->fd, 0);
 
-	if (dsp_protocol->mmap_buffer == NULL) {
+	if (dsp_protocol->mmap_buffer == MAP_FAILED) {
 		report_dsp_protocol("Cannot mmap data buffer", dsp_protocol);
 		ret = -ENOMEM;
 		goto unlock;
-- 
2.17.1
