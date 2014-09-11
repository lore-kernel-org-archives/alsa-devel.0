From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: ASoC: soc-pcm: fix dpcm_path_get error handling
Date: Thu, 11 Sep 2014 06:48:07 -0700
Message-ID: <B2A7C617B3AB7F44B7B44C7D374B431E38DB5EF17C@sc-vexch3.marvell.com>
References: <20140911130854.GA21290@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 40D8A26591E
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 15:49:41 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.14.5/8.14.5) with SMTP id s8BDndOr006775
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 06:49:39 -0700
Received: from sc-owa04.marvell.com ([199.233.58.150])
 by mx0b-0016f401.pphosted.com with ESMTP id 1pak4vc7k4-11
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 06:49:39 -0700
In-Reply-To: <20140911130854.GA21290@mwanda>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Dan,

You're right. We should not unlock the mutex here. I'll submit a
patch to fix it soon. sorry for the inconvenience.

Best Regards
Qiao
________________________________________
From: Dan Carpenter [dan.carpenter@oracle.com]
Sent: Thursday, September 11, 2014 6:08 AM
To: Qiao Zhou
Cc: alsa-devel@alsa-project.org
Subject: re: ASoC: soc-pcm: fix dpcm_path_get error handling

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
