From: <laxmi.devi@in.bosch.com>
Subject: [PATCH - ALSA JACK plugin 2/2] jack: Removing
	snd_pcm_jack_format_t as it is not used
Date: Fri, 11 Jan 2019 10:45:55 +0530
Message-ID: <1547183755-3551-2-git-send-email-laxmi.devi@in.bosch.com>
References: <1547183755-3551-1-git-send-email-laxmi.devi@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1547183755-3551-1-git-send-email-laxmi.devi@in.bosch.com>
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
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org, Laxmi Devi <Laxmi.Devi@in.bosch.com>
List-Id: alsa-devel@alsa-project.org

From: Laxmi Devi <Laxmi.Devi@in.bosch.com>

Signed-off-by: Laxmi Devi <Laxmi.Devi@in.bosch.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index d723b17..b2bc213 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -31,10 +31,6 @@
 
 #define MAX_PERIODS_MULTIPLE 64
 
-typedef enum _jack_format {
-	SND_PCM_JACK_FORMAT_RAW
-} snd_pcm_jack_format_t;
-
 typedef struct {
 	snd_pcm_ioplug_t io;
 
-- 
2.7.4
