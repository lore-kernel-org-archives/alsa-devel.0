From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: codecs: Add AB8500 codec-driver
Date: Sat, 16 Jun 2012 16:19:04 +0300
Message-ID: <20120616131904.GA17980@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by alsa0.perex.cz (Postfix) with ESMTP id E8BE8243E3
	for <alsa-devel@alsa-project.org>;
	Sat, 16 Jun 2012 15:19:16 +0200 (CEST)
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
To: ola.o.lilja@stericsson.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Ola Lilja,

The patch 679d7abdc754: "ASoC: codecs: Add AB8500 codec-driver" from
Jun 7, 2012, leads to the following Sparse warnings:

sound/soc/codecs/ab8500-codec.c:1960:53:
	warning: cast truncates bits from constant value (1013 becomes 13)
sound/soc/codecs/ab8500-codec.c:1968:53:
	warning: cast truncates bits from constant value (1013 becomes 13)

sound/soc/codecs/ab8500-codec.c
  1958          /* Set DMic-clocks to outputs */
  1959          status = abx500_get_register_interruptible(codec->dev, (u8)AB8500_MISC,
  1960                                                  (u8)AB8500_GPIO_DIR4_REG,
                                                            ^^^^^^^^^^^^^^^^^^^^
  1961                                                  &value8);
  1962          if (status < 0)
  1963                  return status;
  1964          value = value8 | GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
  1965                  GPIO31_DIR_OUTPUT;
  1966          status = abx500_set_register_interruptible(codec->dev,
  1967                                                  (u8)AB8500_MISC,
  1968                                                  (u8)AB8500_GPIO_DIR4_REG,
                                                        ^^^^^^^^^^^^^^^^^^^^^^^^
  1969                                                  value);

In my quick check we only seem to use the truncated values of these
defines so I'm not sure this was intended.

regards,
dan carpenter
