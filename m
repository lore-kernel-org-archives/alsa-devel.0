From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH alsa-lib 2/2] pcm_dmix: Fix compiler warnings
	-Wunused-result
Date: Thu, 15 Nov 2018 08:19:57 +0100
Message-ID: <20181115071957.22753-2-kmarinushkin@birdec.tech>
References: <20181115071957.22753-1-kmarinushkin@birdec.tech>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from host.euro-space.net (host.euro-space.net [87.117.239.2])
 by alsa0.perex.cz (Postfix) with ESMTP id CD145267A61
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2018 08:18:40 +0100 (CET)
In-Reply-To: <20181115071957.22753-1-kmarinushkin@birdec.tech>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kirill Marinushkin <kmarinushkin@birdec.tech>
List-Id: alsa-devel@alsa-project.org

Before this commit, compilation of `pcm_dmix` causes warnings "ignoring
return value" for `fgets` operations:

~~~~
pcm_dmix_i386.c:108:5: warning: ignoring return value of 'fgets', declared
with attribute warn_unused_result [-Wunused-result]
     fgets(line, sizeof(line), in);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~

This commit fixes the warnings.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
---
 src/pcm/pcm_dmix_i386.c   | 3 ++-
 src/pcm/pcm_dmix_x86_64.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_dmix_i386.c b/src/pcm/pcm_dmix_i386.c
index 1ab983a8..81265517 100644
--- a/src/pcm/pcm_dmix_i386.c
+++ b/src/pcm/pcm_dmix_i386.c
@@ -105,7 +105,8 @@ static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 		in = fopen("/proc/cpuinfo", "r");
 		if (in) {
 			while (!feof(in)) {
-				fgets(line, sizeof(line), in);
+				if (!fgets(line, sizeof(line), in))
+					continue;
 				if (!strncmp(line, "processor", 9))
 					smp++;
 				else if (!strncmp(line, "flags", 5)) {
diff --git a/src/pcm/pcm_dmix_x86_64.c b/src/pcm/pcm_dmix_x86_64.c
index 34c40d4e..c96af69b 100644
--- a/src/pcm/pcm_dmix_x86_64.c
+++ b/src/pcm/pcm_dmix_x86_64.c
@@ -88,7 +88,8 @@ static void mix_select_callbacks(snd_pcm_direct_t *dmix)
 		in = fopen("/proc/cpuinfo", "r");
 		if (in) {
 			while (!feof(in)) {
-				fgets(line, sizeof(line), in);
+				if (!fgets(line, sizeof(line), in))
+					continue;
 				if (!strncmp(line, "processor", 9))
 					smp++;
 			}
-- 
2.13.6
