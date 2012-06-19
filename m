From: Ola Lilja <ola.o.lilja@stericsson.com>
Subject: Re: ASoC: codecs: Add AB8500 codec-driver
Date: Tue, 19 Jun 2012 10:50:43 +0200
Message-ID: <4FE03D63.3030108@stericsson.com>
References: <20120616131904.GA17980@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id C9BE524410
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 10:50:49 +0200 (CEST)
In-Reply-To: <20120616131904.GA17980@elgon.mountain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 06/16/2012 03:19 PM, Dan Carpenter wrote:

> Hello Ola Lilja,

> 

Hi Dan!

> The patch 679d7abdc754: "ASoC: codecs: Add AB8500 codec-driver" from
> Jun 7, 2012, leads to the following Sparse warnings:
> 
> sound/soc/codecs/ab8500-codec.c:1960:53:
> 	warning: cast truncates bits from constant value (1013 becomes 13)
> sound/soc/codecs/ab8500-codec.c:1968:53:
> 	warning: cast truncates bits from constant value (1013 becomes 13)
> 
> sound/soc/codecs/ab8500-codec.c
>   1958          /* Set DMic-clocks to outputs */
>   1959          status = abx500_get_register_interruptible(codec->dev, (u8)AB8500_MISC,
>   1960                                                  (u8)AB8500_GPIO_DIR4_REG,
>                                                             ^^^^^^^^^^^^^^^^^^^^
>   1961                                                  &value8);
>   1962          if (status < 0)
>   1963                  return status;
>   1964          value = value8 | GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
>   1965                  GPIO31_DIR_OUTPUT;
>   1966          status = abx500_set_register_interruptible(codec->dev,
>   1967                                                  (u8)AB8500_MISC,
>   1968                                                  (u8)AB8500_GPIO_DIR4_REG,
>                                                         ^^^^^^^^^^^^^^^^^^^^^^^^
>   1969                                                  value);
> 
> In my quick check we only seem to use the truncated values of these
> defines so I'm not sure this was intended.


The error here is that for that variable the bank-byte has (faulty) been
attached to the register-byte, where the bank is 0x10. This should not have been
there and the result after truncation is the correct value of 0x13.
Our registers are only 8-bits. We have fixed this define in an internal patch so
it will show up here eventually.

Thanks for pointing it out!

> 
> regards,
> dan carpenter
> 


regards,
Ola Lilja
