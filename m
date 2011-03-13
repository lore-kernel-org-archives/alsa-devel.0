From: pbruskispam@op.pl
Subject: [PATCH - ctxfi driver 2/4] Fix: mask creation was
	incorrect
Date: Sun, 13 Mar 2011 16:18:56 +0100
Message-ID: <1300029538-3147-2-git-send-email-pbruskispam@op.pl>
References: <1300029538-3147-1-git-send-email-pbruskispam@op.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1300029538-3147-1-git-send-email-pbruskispam@op.pl>
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
Cc: alsa-devel@alsa-project.org, Przemyslaw Bruski <pbruskispam@op.pl>
List-Id: alsa-devel@alsa-project.org

From: Przemyslaw Bruski <pbruskispam@op.pl>


Signed-off-by: Przemyslaw Bruski <pbruskispam@op.pl>

diff --git a/pci/ctxfi/ctatc.c b/pci/ctxfi/ctatc.c
index 1bff80c..b932154 100644
--- a/pci/ctxfi/ctatc.c
+++ b/pci/ctxfi/ctatc.c
@@ -869,7 +869,7 @@ spdif_passthru_playback_setup(struct ct_atc *atc, struct ct_atc_pcm *apcm)
 	mutex_lock(&atc->atc_mutex);
 	dao->ops->get_spos(dao, &status);
 	if (((status >> 24) & IEC958_AES3_CON_FS) != iec958_con_fs) {
-		status &= ((~IEC958_AES3_CON_FS) << 24);
+		status &= ~(IEC958_AES3_CON_FS << 24);
 		status |= (iec958_con_fs << 24);
 		dao->ops->set_spos(dao, status);
 		dao->ops->commit_write(dao);
-- 
1.7.1
