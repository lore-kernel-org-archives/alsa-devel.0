From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: dpcm: Add debugFS support for DPCM
Date: Sun, 29 Apr 2012 16:51:25 +0300
Message-ID: <20120429135125.GA19737@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A044103B5C
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2012 15:51:33 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Liam Girdwood,

The patch f86dcef87b77: "ASoC: dpcm: Add debugFS support for DPCM" 
from Apr 25, 2012, leads to the following Smatch warning:
sound/soc/soc-core.c:1221 soc_post_component_init()
	 error: potential null derefence 'dai_link'.


  1143  static int soc_post_component_init(struct snd_soc_card *card,
  1144                                     struct snd_soc_codec *codec,
  1145                                     int num, int dailess)
  1146  {
  1147          struct snd_soc_dai_link *dai_link = NULL;
  1148          struct snd_soc_aux_dev *aux_dev = NULL;
  1149          struct snd_soc_pcm_runtime *rtd;
  1150          const char *temp, *name;
  1151          int ret = 0;
  1152  
  1153          if (!dailess) {
  1154                  dai_link = &card->dai_link[num];
                        ^^^^^^^^
dai_link is only set sometimes; it depends on dailess.

  1155                  rtd = &card->rtd[num];
  1156                  name = dai_link->name;
  1157          } else {
  1158                  aux_dev = &card->aux_dev[num];
  1159                  rtd = &card->rtd_aux[num];
  1160                  name = aux_dev->name;
  1161          }

[snip]

  1219  #ifdef CONFIG_DEBUG_FS
  1220          /* add DPCM sysfs entries */
  1221          if (!dai_link->dynamic)
                     ^^^^^^^^^^
Smatch complains about this.

  1222                  goto out;
  1223  
  1224          ret = soc_dpcm_debugfs_add(rtd);
  1225          if (ret < 0)
  1226                  dev_err(rtd->dev, "asoc: failed to add dpcm sysfs entries: %d\n", ret);
  1227  
  1228  out:
  1229  #endif


regards,
dan carpenter
