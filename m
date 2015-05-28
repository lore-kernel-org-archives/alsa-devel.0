From: Xuebing Wang <xbing6@gmail.com>
Subject: Freescale iMX6SL SSI (I2S master mode) Rising edge vs
 Falling edge
Date: Thu, 28 May 2015 15:02:31 +0800
Message-ID: <5566BD87.6040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f169.google.com (mail-ie0-f169.google.com
 [209.85.223.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 5004026042F
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 09:02:37 +0200 (CEST)
Received: by iesa3 with SMTP id a3so31624114ies.2
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 00:02:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org
Cc: niranjan Patil <Niranjan.Patil@infocus.com>, fabio Estevam <festevam@gmail.com>, richard Jiang <Richard.Jiang@infocus.com>
List-Id: alsa-devel@alsa-project.org

Nicolin and alsa-devel community:

Source code in fsl_ssi.c shows below in function fsl_ssi_set_dai_fmt():
-----------
     switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
     case SND_SOC_DAIFMT_I2S:
... ...
         /* Data on rising edge of bclk, frame low, 1clk before data */
         strcr |= CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TSCKP
             | CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TEFS;
         break;
-----------

According to iMX6SL reference manual, 'TSCKP = 1' means "Data clocked 
out on *falling* edge of bit clock." (for I2S master mode), rather than 
"Data on rising edge of bclk in the comments". This means this comment 
in the source code is *partially* WRONG, am I correct?

However, RSCKP is = 1 (for receiving), it means "Data latched on rising 
edge of bit clock", which is correct.

Also, I am not sure why there is inconsistency in iMX6SL reference 
manual (48.9 SSI Memory Map/Register Definition), that TSCKP = 1 (for 
transmitting) is FALLING_EDGE, but RSCKP = 1 (for receiving) is RISING_EDGE.

Note: SSI (I2S master mode) works perfect on my hardware, I did not 
observe anything wrong.

Thanks.

-- 
Xuebing
