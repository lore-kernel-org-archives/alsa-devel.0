From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: rt5514: add rt5514 SPI driver
Date: Thu, 16 Jun 2016 13:49:25 +0300
Message-ID: <20160616104925.GC24067@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E3652654B6
 for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2016 12:49:45 +0200 (CEST)
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
To: oder_chiou@realtek.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Oder Chiou,

This is a semi-automatic email about new static checker warnings.

The patch 6eebf35b0e4a: "ASoC: rt5514: add rt5514 SPI driver" from 
Jun 6, 2016, leads to the following Smatch complaint:

sound/soc/codecs/rt5514-spi.c:87 rt5514_spi_copy_work()
	 warn: variable dereferenced before check 'rt5514_dsp->substream' (see line 83)

sound/soc/codecs/rt5514-spi.c
    82			container_of(work, struct rt5514_dsp, copy_work.work);
    83		struct snd_pcm_runtime *runtime = rt5514_dsp->substream->runtime;
                                                  ^^^^^^^^^^^^^^^^^^^^^^^
Dereference.

    84		size_t period_bytes, truncated_bytes = 0;
    85	
    86		mutex_lock(&rt5514_dsp->dma_lock);
    87		if (!rt5514_dsp->substream) {
                     ^^^^^^^^^^^^^^^^^^^^^
Checked too late.

    88			dev_err(rt5514_dsp->dev, "No pcm substream\n");
    89			goto done;

regards,
dan carpenter
