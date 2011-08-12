From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/4] ALSA: hdspm - Reorder period sizes
	according to their bit representation
Date: Fri, 12 Aug 2011 21:57:48 +0200
Message-ID: <1313179069-8432-4-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1313179069-8432-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

On newer RME cards like RayDAT and AIO, the 8192 samples per period size
are no longer supported. Instead, setting all three bits of
HDSP_LatencyMask to one ({1,1,1}) now corresponds to 32 samples per
period.

To make this more obvious to future developers, let's reorder the array
according to their bit representation, starting at 64 ({0,0,0}) up to
4096 ({1,1,0}) and finally 32 ({1,1,1}).

Note that this patch doesn't change semantics.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 8dc2a89..159133a 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -5677,7 +5677,7 @@ static unsigned int period_sizes_old[] = {
 };
 
 static unsigned int period_sizes_new[] = {
-	32, 64, 128, 256, 512, 1024, 2048, 4096
+	64, 128, 256, 512, 1024, 2048, 4096, 32
 };
 
 /* RayDAT and AIO always have a buffer of 16384 samples per channel */
-- 
1.7.5.4
