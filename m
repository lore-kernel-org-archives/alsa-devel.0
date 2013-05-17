From: Jordi Mallach <jordi@debian.org>
Subject: =?utf-8?q?=5BPATCH=5D_pcm=3A_Fix_typo_in_documentati?=
	=?utf-8?q?on=3A_PREPARE_=E2=86=92_PREPARED=2E?=
Date: Fri, 17 May 2013 18:25:51 +0200
Message-ID: <1368807951-22824-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id E63B4261619
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 18:26:14 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 24F9462C08
 for <alsa-devel@alsa-project.org>; Fri, 17 May 2013 18:26:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Jordi Mallach <jordi@debian.org>
---
 src/pcm/pcm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm.c b/src/pcm/pcm.c
index 438fb3f..7ec1f0e 100644
--- a/src/pcm/pcm.c
+++ b/src/pcm/pcm.c
@@ -437,7 +437,7 @@ to #SND_PCM_STATE_SETUP
 if successfully finishes, otherwise the state #SND_PCM_STATE_OPEN
 is entered.
 When it is brought to SETUP state, this function automatically
-calls #snd_pcm_prepare() function to bring to the PREPARE state
+calls #snd_pcm_prepare() function to bring to the PREPARED state
 as below.
 
 \par snd_pcm_prepare
-- 
1.7.10.4
