From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 09/10] ASoC: core: Remove
	snd_soc_put_volsw_2r definition
Date: Wed,  5 Oct 2011 10:29:27 +0300
Message-ID: <1317799768-15683-10-git-send-email-peter.ujfalusi@ti.com>
References: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id C5D79103A4A
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Oct 2011 09:29:57 +0200 (CEST)
Received: by bkbzt19 with SMTP id zt19so2010766bkb.23
	for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2011 00:29:55 -0700 (PDT)
In-Reply-To: <1317799768-15683-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We do not have users for snd_soc_put_volsw_2r anymore.
It can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 include/sound/soc.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 14883a4..d73df06 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -393,7 +393,6 @@ int snd_soc_get_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
 int snd_soc_put_volsw(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol);
-#define snd_soc_put_volsw_2r snd_soc_put_volsw
 int snd_soc_info_volsw_s8(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_info *uinfo);
 int snd_soc_get_volsw_s8(struct snd_kcontrol *kcontrol,
-- 
1.7.7
