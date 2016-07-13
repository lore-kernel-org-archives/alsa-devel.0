From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ALSA: mixart: don't print an unintialized
	variable on error
Date: Wed, 13 Jul 2016 12:59:53 +0300
Message-ID: <20160713095953.GA29468@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A2002665A6
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 12:00:09 +0200 (CEST)
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
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

My static checker complains that "resp" could be unitialized on error
when we print its value.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/pci/mixart/mixart_mixer.c b/sound/pci/mixart/mixart_mixer.c
index 58fd79eb..51e5349 100644
--- a/sound/pci/mixart/mixart_mixer.c
+++ b/sound/pci/mixart/mixart_mixer.c
@@ -965,7 +965,7 @@ static int mixart_update_monitoring(struct snd_mixart* chip, int channel)
 	int err;
 	struct mixart_msg request;
 	struct mixart_set_out_audio_level audio_level;
-	u32 resp;
+	u32 resp = 0;
 
 	if(chip->pipe_out_ana.status == PIPE_UNDEFINED)
 		return -EINVAL; /* no pipe defined */
