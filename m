From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/5] ALSA: hdspm - Allow for 8192 period size
	on RME MADI and AES cards
Date: Mon, 15 Aug 2011 00:22:50 +0200
Message-ID: <1313360574-9891-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <20110814215943.GK19500@ltw.loris.tv>
	<1313360574-9891-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1313360574-9891-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

Older RME cards like MADI and AES support period sizes of 8192 samples.
The original hdspm driver already featured this value, apparently, it
was lost during the rewrite.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 493e394..204e1ce 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -5673,7 +5673,7 @@ static int snd_hdspm_prepare(struct snd_pcm_substream *substream)
 }
 
 static unsigned int period_sizes_old[] = {
-	64, 128, 256, 512, 1024, 2048, 4096
+	64, 128, 256, 512, 1024, 2048, 4096, 8192
 };
 
 static unsigned int period_sizes_new[] = {
-- 
1.7.5.4
