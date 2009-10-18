From: alsa2@bzzt.net
Subject: [PATCH - report available sample formats in
	aplay/arecord when currently selected one doesn't work]
Date: Sun, 18 Oct 2009 21:34:30 +0200
Message-ID: <1255894470-19966-1-git-send-email-alsa2@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org, Arnout Engelen <alsa2@bzzt.net>
List-Id: alsa-devel@alsa-project.org

From: Arnout Engelen <alsa2@bzzt.net>


Signed-off-by: Arnout Engelen <alsa2@bzzt.net>
---
 aplay/aplay.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index c7c82a1..60f17de 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -941,6 +941,20 @@ static int test_au(int fd, void *buffer)
 	return 0;
 }
 
+static void show_available_sample_formats(snd_pcm_hw_params_t* params)
+{
+	snd_pcm_format_t format;
+
+	fprintf(stderr, "Available formats:\n");
+	for (format = 0; format < SND_PCM_FORMAT_LAST; format++)
+	{
+		if (snd_pcm_hw_params_test_format(handle, params, format) == 0)
+		{
+			fprintf(stderr, "- %s\n", snd_pcm_format_name(format));
+		}
+	}
+}
+
 static void set_params(void)
 {
 	snd_pcm_hw_params_t *params;
@@ -977,6 +991,7 @@ static void set_params(void)
 	err = snd_pcm_hw_params_set_format(handle, params, hwparams.format);
 	if (err < 0) {
 		error(_("Sample format non available"));
+		show_available_sample_formats(params);
 		exit(EXIT_FAILURE);
 	}
 	err = snd_pcm_hw_params_set_channels(handle, params, hwparams.channels);
-- 
1.6.3.3
