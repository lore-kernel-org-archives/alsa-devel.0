From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/8] ALSA: hdspm - Fix buffer handling on RME
	MADI/MADIface/AES(32)
Date: Wed, 23 Feb 2011 11:43:09 +0100
Message-ID: <1298457795-28114-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1298457795-28114-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Only RayDAT and AIO provide sane buffer pointers that can be used with
HDSPM_BufferPositionMask, on all other cards, this would result in a
wrong HW pointer leading to xruns and these messages:

[260808.916788] BUG: pcmC0D0p:0, pos = 2976, buffer size = 1024, period size = 512
[260808.961124] BUG: pcmC0D0c:0, pos = 4944, buffer size = 1024, period size = 512

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 9258897..509a35a 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -1231,8 +1231,17 @@ static snd_pcm_uframes_t hdspm_hw_pointer(struct hdspm *hdspm)
 	int position;
 
 	position = hdspm_read(hdspm, HDSPM_statusRegister);
-	position &= HDSPM_BufferPositionMask;
-	position /= 4; /* Bytes per sample */
+
+	switch (hdspm->io_type) {
+	case RayDAT:
+	case AIO:
+		position &= HDSPM_BufferPositionMask;
+		position /= 4; /* Bytes per sample */
+		break;
+	default:
+		position = (position & HDSPM_BufferID) ?
+			(hdspm->period_bytes / 4) : 0;
+	}
 
 	return position;
 }
-- 
1.7.2.3
