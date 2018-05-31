From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ALSA: xen-front: signdness bug in
	alsa_prepare()
Date: Thu, 31 May 2018 09:25:47 +0300
Message-ID: <20180531062547.xfcmrfx7vmnef6gm@kili.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DE9D826789D
 for <alsa-devel@alsa-project.org>; Thu, 31 May 2018 08:25:59 +0200 (CEST)
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
To: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: xen-devel@lists.xenproject.org, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

"sndif_format" needs to be signed for the error handling to work.

Fixes: 1cee559351a7 ("ALSA: xen-front: Implement ALSA virtual sound driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/sound/xen/xen_snd_front_alsa.c b/sound/xen/xen_snd_front_alsa.c
index 5041f83e98d2..43478f66954a 100644
--- a/sound/xen/xen_snd_front_alsa.c
+++ b/sound/xen/xen_snd_front_alsa.c
@@ -463,7 +463,7 @@ static int alsa_prepare(struct snd_pcm_substream *substream)
 
 	if (!stream->is_open) {
 		struct snd_pcm_runtime *runtime = substream->runtime;
-		u8 sndif_format;
+		int sndif_format;
 		int ret;
 
 		sndif_format = to_sndif_format(runtime->format);
