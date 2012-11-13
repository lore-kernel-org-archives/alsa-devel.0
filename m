From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH v3 1/2] aplay: Show usage if no parameter is
	passed
Date: Tue, 13 Nov 2012 10:05:39 -0200
Message-ID: <1352808340-10561-1-git-send-email-fabio.estevam@freescale.com>
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
To: perex@perex.cz
Cc: tiwai@suse.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, patch@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

When aplay/arecord are called without any argument the application hangs forever.

Instead of hanging, print the usage and exit.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- return 1 instead of 0 
- Use stdout for the arecord case
Changes since v1:
- Also check for isatty, so that 'aplay < file.wav' can still work
 aplay/aplay.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index 741979a..66cc78f 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -493,6 +493,7 @@ int main(int argc, char *argv[])
 	int tmp, err, c;
 	int do_device_list = 0, do_pcm_list = 0;
 	snd_pcm_info_t *info;
+	FILE *direction;
 
 #ifdef ENABLE_NLS
 	setlocale(LC_ALL, "");
@@ -511,14 +512,21 @@ int main(int argc, char *argv[])
 		file_type = FORMAT_WAVE;
 		command = "arecord";
 		start_delay = 1;
+		direction = stdout;
 	} else if (strstr(argv[0], "aplay")) {
 		stream = SND_PCM_STREAM_PLAYBACK;
 		command = "aplay";
+		direction = stdin;
 	} else {
 		error(_("command should be named either arecord or aplay"));
 		return 1;
 	}
 
+	if (isatty(fileno(direction)) && (argc == 1)) {
+		usage(command);
+		return 1;	
+	}
+	
 	chunk_size = -1;
 	rhwparams.format = DEFAULT_FORMAT;
 	rhwparams.rate = DEFAULT_SPEED;
-- 
1.7.9.5
