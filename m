From: Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [bug report] ASoC: mediatek: modify MT2701 AFE
 driver to adapt mfd device
Date: Mon, 22 Jan 2018 19:38:12 +0800
Message-ID: <1516621092.30761.3.camel@mtkswgap22>
References: <20180122100138.GA20468@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 03408266B67
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 12:38:20 +0100 (CET)
In-Reply-To: <20180122100138.GA20468@mwanda>
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
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2018-01-22 at 13:01 +0300, Dan Carpenter wrote:
> Hello Ryder Lee,
> 
> The patch dfa3cbb83e09: "ASoC: mediatek: modify MT2701 AFE driver to
> adapt mfd device" from Jan 4, 2018, leads to the following static
> checker warning:
> 
> 	sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:1535 mt2701_afe_pcm_dev_probe()
> 	error: double free of 'component'
> 
> sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
>   1509          pm_runtime_get_sync(dev);
>   1510  
>   1511          ret = snd_soc_register_platform(dev, &mtk_afe_pcm_platform);
>   1512          if (ret) {
>   1513                  dev_warn(dev, "err_platform\n");
>   1514                  goto err_platform;
>   1515          }
>   1516  
>   1517          ret = snd_soc_add_component(dev, component,
>                                                  ^^^^^^^^^
> snd_soc_add_component() frees "component" on error.  This seems like a
> layering violation to me, and it naturally leads to bugs like this.
> 
>   1518                                      &mt2701_afe_pcm_dai_component,
>   1519                                      mt2701_afe_pcm_dais,
>   1520                                      ARRAY_SIZE(mt2701_afe_pcm_dais));
>   1521          if (ret) {
>   1522                  dev_warn(dev, "err_dai_component\n");
>   1523                  goto err_dai_component;
>   1524          }
>   1525  
>   1526          return 0;
>   1527  
>   1528  err_dai_component:
>   1529          snd_soc_unregister_platform(dev);
>   1530  err_platform:
>   1531          pm_runtime_put_sync(dev);
>   1532  err_pm_disable:
>   1533          pm_runtime_disable(dev);
>   1534  err_init_clock:
>   1535          kfree(component);
>                       ^^^^^^^^^
> Double free

Thanks for catching that. I've just sent a fixup patch.

Ryder
