From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: davinci-mcasp: Choose PCM driver based on
 configured DMA controller
Date: Thu, 11 Jun 2015 18:06:06 +0300
Message-ID: <20150611150605.GB12192@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id B532326653E
 for <alsa-devel@alsa-project.org>; Thu, 11 Jun 2015 17:06:19 +0200 (CEST)
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
To: jsarha@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Jyri Sarha,

The patch 9fbd58cf4ab0: "ASoC: davinci-mcasp: Choose PCM driver based
on configured DMA controller" from Jun 2, 2015, leads to the
following static checker warning:

	sound/soc/davinci/davinci-mcasp.c:1842 davinci_mcasp_probe()
	info: ignoring unreachable code.

sound/soc/davinci/davinci-mcasp.c
  1812          switch (ret) {
  1813          case PCM_EDMA:
  1814  #if IS_BUILTIN(CONFIG_SND_EDMA_SOC) || \
  1815          (IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
  1816           IS_MODULE(CONFIG_SND_EDMA_SOC))
  1817                  ret = edma_pcm_platform_register(&pdev->dev);
  1818  #else
  1819                  dev_err(&pdev->dev, "Missing SND_EDMA_SOC\n");
  1820                  ret = -EINVAL;
  1821                  goto err;
  1822  #endif
  1823                  break;
  1824          case PCM_SDMA:
  1825  #if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
  1826          (IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
  1827           IS_MODULE(CONFIG_SND_OMAP_SOC))
  1828                  ret = omap_pcm_platform_register(&pdev->dev);
  1829  #else
  1830                  dev_err(&pdev->dev, "Missing SND_SDMA_SOC\n");
  1831                  ret = -EINVAL;
  1832                  goto err;
  1833  #endif
  1834                  break;
  1835          default:
  1836                  dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
  1837          case -EPROBE_DEFER:
  1838                  goto err;
  1839                  break;
  1840          }
  1841  

Depending on the ifdefs then this is reachable, I guess...

  1842          if (ret) {
  1843                  dev_err(&pdev->dev, "register PCM failed: %d\n", ret);
  1844                  goto err;
  1845          }
  1846  
  1847          return 0;
  1848  
  1849  err:
  1850          pm_runtime_disable(&pdev->dev);
  1851          return ret;
  1852  }
  1853  

regards,
dan carpenter
