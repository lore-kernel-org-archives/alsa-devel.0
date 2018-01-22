From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ASoC: mediatek: modify MT2701 AFE driver
 to adapt mfd device
Date: Mon, 22 Jan 2018 13:01:38 +0300
Message-ID: <20180122100138.GA20468@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp2130.oracle.com (aserp2130.oracle.com [141.146.126.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 030E0266D71
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 11:06:49 +0100 (CET)
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
To: ryder.lee@mediatek.com
Cc: alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hello Ryder Lee,

The patch dfa3cbb83e09: "ASoC: mediatek: modify MT2701 AFE driver to
adapt mfd device" from Jan 4, 2018, leads to the following static
checker warning:

	sound/soc/mediatek/mt2701/mt2701-afe-pcm.c:1535 mt2701_afe_pcm_dev_probe()
	error: double free of 'component'

sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
  1509          pm_runtime_get_sync(dev);
  1510  
  1511          ret = snd_soc_register_platform(dev, &mtk_afe_pcm_platform);
  1512          if (ret) {
  1513                  dev_warn(dev, "err_platform\n");
  1514                  goto err_platform;
  1515          }
  1516  
  1517          ret = snd_soc_add_component(dev, component,
                                                 ^^^^^^^^^
snd_soc_add_component() frees "component" on error.  This seems like a
layering violation to me, and it naturally leads to bugs like this.

  1518                                      &mt2701_afe_pcm_dai_component,
  1519                                      mt2701_afe_pcm_dais,
  1520                                      ARRAY_SIZE(mt2701_afe_pcm_dais));
  1521          if (ret) {
  1522                  dev_warn(dev, "err_dai_component\n");
  1523                  goto err_dai_component;
  1524          }
  1525  
  1526          return 0;
  1527  
  1528  err_dai_component:
  1529          snd_soc_unregister_platform(dev);
  1530  err_platform:
  1531          pm_runtime_put_sync(dev);
  1532  err_pm_disable:
  1533          pm_runtime_disable(dev);
  1534  err_init_clock:
  1535          kfree(component);
                      ^^^^^^^^^
Double free

  1536  
  1537          return ret;
  1538  }


regards,
dan carpenter
