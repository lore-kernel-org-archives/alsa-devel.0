From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH alsa-lib 1/1] doc: Fix typo in PCM formats
Date: Tue, 27 Mar 2012 17:54:47 +0200
Message-ID: <1332863687-17428-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Of course, 24bit samples are not stored in three bits, but bytes.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index ea1afdc..18b43b3 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -209,13 +209,13 @@ The device is physicaly disconnected. It does not accept any I/O calls in this s
 \section pcm_formats PCM formats
 
 The full list of formats present the #snd_pcm_format_t type.
-The 24-bit linear samples uses 32-bit physical space, but the sample is
-stored in low three bits. Some hardware does not support processing of full
+The 24-bit linear samples use 32-bit physical space, but the sample is
+stored in the lower three bytes. Some hardware does not support processing of full
 range, thus you may get the significant bits for linear samples via
 #snd_pcm_hw_params_get_sbits() function. The example: ICE1712
 chips support 32-bit sample processing, but low byte is ignored (playback)
 or zero (capture). The function snd_pcm_hw_params_get_sbits()
-returns 24 in the case.
+returns 24 in this case.
 
 \section alsa_transfers ALSA transfers
 
-- 
1.7.9.1
