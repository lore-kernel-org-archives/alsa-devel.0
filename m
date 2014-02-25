From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 1/2] ASoC: sst-haswell-ipc: restore IRQs on
	error
Date: Tue, 25 Feb 2014 11:32:50 +0300
Message-ID: <20140225083250.GA22416@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 1759726517F
 for <alsa-devel@alsa-project.org>; Tue, 25 Feb 2014 09:32:56 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

This should be spin_unlock_irqrestore() instead of spin_unlock()

Fixes: 22981243589c ('ASoC: Intel: Add Haswell/Broadwell IPC')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/soc/intel/sst-haswell-ipc.c b/sound/soc/intel/sst-haswell-ipc.c
index 668d486520ae..552aebf2c8f5 100644
--- a/sound/soc/intel/sst-haswell-ipc.c
+++ b/sound/soc/intel/sst-haswell-ipc.c
@@ -527,7 +527,7 @@ static int ipc_tx_message(struct sst_hsw *hsw, u32 header, void *tx_data,
 
 	msg = msg_get_empty(hsw);
 	if (msg == NULL) {
-		spin_unlock(&hsw->dsp->spinlock);
+		spin_unlock_irqrestore(&hsw->dsp->spinlock, flags);
 		return -EBUSY;
 	}
 
