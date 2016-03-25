From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: qcom: add mic support
Date: Fri, 25 Mar 2016 12:00:02 +0300
Message-ID: <20160325090002.GA10634@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 78E0626066B
 for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2016 10:00:13 +0100 (CET)
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
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Srinivas Kandagatla,

The patch fb5d11524eda: "ASoC: qcom: add mic support" from Feb 11,
2016, leads to the following static checker warning:

	sound/soc/qcom/lpass-platform.c:555 lpass_platform_pcm_new()
	error: uninitialized symbol 'ret'.

sound/soc/qcom/lpass-platform.c
   515          csubstream = pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream;
   516          if (csubstream) {
   517                  if (v->alloc_dma_channel)
   518                          data->wrdma_ch = v->alloc_dma_channel(drvdata,
   519                                                  SNDRV_PCM_STREAM_CAPTURE);
   520  
   521                  if (IS_ERR_VALUE(data->wrdma_ch))
   522                          goto capture_alloc_err;

->wrdma_ch is an int so this should just be:

			if (data->wrdma_ch < 0) {
				ret = data->wrdma_ch;
				goto capture_alloc_err;
			}

The other ->alloc_dma_channel uses the same IS_ERR_VALUE() check as well
so we should probably clean that up as well.  The IS_ERR_VALUE()
function is for places which return unsigned long basically.  No need to
be fancy for normal "negative returns are error" code.

   523  
   524                  drvdata->substream[data->wrdma_ch] = csubstream;
   525  
   526                  ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV,
   527                                          soc_runtime->platform->dev,
   528                                          size, &csubstream->dma_buffer);
   529                  if (ret)
   530                          goto capture_alloc_err;
   531  
   532                  ret = regmap_write(drvdata->lpaif_map,
   533                          LPAIF_WRDMACTL_REG(v, data->wrdma_ch), 0);
   534                  if (ret) {
   535                          dev_err(soc_runtime->dev,
   536                                  "%s() error writing to wrdmactl reg: %d\n",
   537                                  __func__, ret);
   538                          goto capture_reg_err;
   539                  }
   540          }
   541  
   542          return 0;
   543  
   544  capture_reg_err:
   545          if (csubstream)
   546                  snd_dma_free_pages(&csubstream->dma_buffer);
   547  
   548  capture_alloc_err:
   549          if (psubstream)
   550                  snd_dma_free_pages(&psubstream->dma_buffer);
   551  
   552   playback_alloc_err:
   553          dev_err(soc_runtime->dev, "Cannot allocate buffer(s)\n");
   554  
   555          return ret;
   556  }

regards,
dan carpenter
