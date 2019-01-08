From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: cs46xx: Potential NULL dereference in
	probe
Date: Tue, 8 Jan 2019 10:43:30 +0300
Message-ID: <20190108074330.GA20166@kadam>
References: <1546895293273.10834@ece.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F1B22667F5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2019 08:44:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1546895293273.10834@ece.ufl.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: security@kernel.org, Vinod Koul <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The "chip->dsp_spos_instance" can be NULL on some of the ealier error
paths in snd_cs46xx_create().

Reported-by: "Yavuz, Tuba" <tuba@ece.ufl.edu>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
We don't really consider NULL derefences as security bugs unless they
can be triggered remotely, but it's definitely worth fixing.

 sound/pci/cs46xx/dsp_spos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index 598d140bb7cb..5fc497c6d738 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -903,6 +903,9 @@ int cs46xx_dsp_proc_done (struct snd_cs46xx *chip)
 	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
 	int i;
 
+	if (!ins)
+		return 0;
+
 	snd_info_free_entry(ins->proc_sym_info_entry);
 	ins->proc_sym_info_entry = NULL;
 
-- 
2.17.1
