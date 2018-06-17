From: Stefan Agner <stefan@agner.ch>
Subject: [PATCH] ALSA: ctxfi: use enum type CT_SUM_CTL where
	appropriate
Date: Sun, 17 Jun 2018 15:46:49 +0200
Message-ID: <20180617134652.1638-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kmu-office.ch (mail.kmu-office.ch [178.209.48.109])
 by alsa0.perex.cz (Postfix) with ESMTP id CA025266E8B
 for <alsa-devel@alsa-project.org>; Sun, 17 Jun 2018 15:47:33 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
List-Id: alsa-devel@alsa-project.org

Currently a variable of type enum CT_AMIXER_CTL is used for enum
CT_SUM_CTL values. This leads to warnings when using clang:
sound/pci/ctxfi/ctmixer.c:945:32: warning: implicit conversion from enumeration type
      'enum CT_SUM_CTL' to different enumeration type 'enum CT_AMIXER_CTL'
      [-Wenum-conversion]
        for (i = AMIXER_MASTER_F, j = SUM_IN_F;
                                    ~ ^~~~~~~~
sound/pci/ctxfi/ctmixer.c:975:29: warning: implicit conversion from enumeration type
      'enum CT_SUM_CTL' to different enumeration type 'enum CT_AMIXER_CTL'
      [-Wenum-conversion]
        for (i = AMIXER_PCM_F, j = SUM_IN_F; i <= AMIXER_PCM_S; i++, j++) {
                                 ~ ^~~~~~~~

Introduce enum CT_SUM_CTL k and it instead.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 sound/pci/ctxfi/ctmixer.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/sound/pci/ctxfi/ctmixer.c b/sound/pci/ctxfi/ctmixer.c
index db710d0a609f..4777d50fbbf8 100644
--- a/sound/pci/ctxfi/ctmixer.c
+++ b/sound/pci/ctxfi/ctmixer.c
@@ -938,17 +938,18 @@ static int ct_mixer_topology_build(struct ct_mixer *mixer)
 	struct sum *sum;
 	struct amixer *amix_d, *amix_s;
 	enum CT_AMIXER_CTL i, j;
+	enum CT_SUM_CTL k;
 
 	/* Build topology from destination to source */
 
 	/* Set up Master mixer */
-	for (i = AMIXER_MASTER_F, j = SUM_IN_F;
-					i <= AMIXER_MASTER_S; i++, j++) {
+	for (i = AMIXER_MASTER_F, k = SUM_IN_F;
+					i <= AMIXER_MASTER_S; i++, k++) {
 		amix_d = mixer->amixers[i*CHN_NUM];
-		sum = mixer->sums[j*CHN_NUM];
+		sum = mixer->sums[k*CHN_NUM];
 		amix_d->ops->setup(amix_d, &sum->rsc, INIT_VOL, NULL);
 		amix_d = mixer->amixers[i*CHN_NUM+1];
-		sum = mixer->sums[j*CHN_NUM+1];
+		sum = mixer->sums[k*CHN_NUM+1];
 		amix_d->ops->setup(amix_d, &sum->rsc, INIT_VOL, NULL);
 	}
 
@@ -972,12 +973,12 @@ static int ct_mixer_topology_build(struct ct_mixer *mixer)
 	amix_d->ops->setup(amix_d, &amix_s->rsc, INIT_VOL, NULL);
 
 	/* Set up PCM-in mixer */
-	for (i = AMIXER_PCM_F, j = SUM_IN_F; i <= AMIXER_PCM_S; i++, j++) {
+	for (i = AMIXER_PCM_F, k = SUM_IN_F; i <= AMIXER_PCM_S; i++, k++) {
 		amix_d = mixer->amixers[i*CHN_NUM];
-		sum = mixer->sums[j*CHN_NUM];
+		sum = mixer->sums[k*CHN_NUM];
 		amix_d->ops->setup(amix_d, NULL, INIT_VOL, sum);
 		amix_d = mixer->amixers[i*CHN_NUM+1];
-		sum = mixer->sums[j*CHN_NUM+1];
+		sum = mixer->sums[k*CHN_NUM+1];
 		amix_d->ops->setup(amix_d, NULL, INIT_VOL, sum);
 	}
 
-- 
2.17.1
