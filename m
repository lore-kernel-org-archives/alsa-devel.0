From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK PCM plugin 4/7] jack: Use ALSA data type
	for internal hardware pointer
Date: Wed, 24 Jan 2018 13:00:39 +0100
Message-ID: <1516795241-10219-2-git-send-email-twischer@de.adit-jv.com>
References: <1516795241-10219-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1516795241-10219-1-git-send-email-twischer@de.adit-jv.com>
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
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

to avoid issues with different architetures where
sizeof(unsigned int) != sizeof(snd_pcm_uframes_t)

Additionally the type describes the unit
of the variable, now.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index a4f35f4..53192dc 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -41,7 +41,7 @@ typedef struct {
 	char **port_names;
 	unsigned int num_ports;
 	snd_pcm_uframes_t boundary;
-	unsigned int hw_ptr;
+	snd_pcm_uframes_t hw_ptr;
 	unsigned int sample_bits;
 	snd_pcm_uframes_t min_avail;
 
-- 
2.7.4
