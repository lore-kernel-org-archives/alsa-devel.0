From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: soc-pcm: fix dpcm_path_get error handling
Date: Thu, 11 Sep 2014 16:08:54 +0300
Message-ID: <20140911130854.GA21290@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id A29F22656F9
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 15:09:12 +0200 (CEST)
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
To: zhouqiao@marvell.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Qiao Zhou,

The patch 8f70e515a8bb: "ASoC: soc-pcm: fix dpcm_path_get error
handling" from Sep 10, 2014, leads to the following static checker
warning:

	sound/soc/soc-compress.c:149 soc_compr_open_fe()
	error: double unlock 'mutex:&fe->card->mutex'

sound/soc/soc-compress.c
   104          ret = dpcm_path_get(fe, stream, &list);
   105          if (ret < 0) {
   106                  mutex_unlock(&fe->card->mutex);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
First unlock.

   107                  goto fe_err;
   108          } else if (ret == 0) {
   109                  dev_dbg(fe->dev, "ASoC: %s no valid %s route\n",
   110                          fe->dai_link->name, stream ? "capture" : "playback");
   111          }
   112  

[ snip ]

   140  
   141  fe_err:
   142          if (fe->dai_link->compr_ops && fe->dai_link->compr_ops->shutdown)
   143                  fe->dai_link->compr_ops->shutdown(cstream);
   144  machine_err:
   145          if (platform->driver->compr_ops && platform->driver->compr_ops->free)
   146                  platform->driver->compr_ops->free(cstream);
   147  out:
   148          fe->dpcm[stream].runtime_update = SND_SOC_DPCM_UPDATE_NO;
   149          mutex_unlock(&fe->card->mutex);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Second unlock.

   150          return ret;
   151  }

regards,
dan carpenter
