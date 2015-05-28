From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: Freescale iMX6SL SSI (I2S master mode) Rising edge
 vs Falling edge
Date: Thu, 28 May 2015 15:15:22 +0800
Message-ID: <5566C08A.6060804@gmail.com>
References: <5566BD87.6040505@gmail.com> <20150528070943.GA3532@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 3AB19260431
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 09:15:28 +0200 (CEST)
Received: by iebgx4 with SMTP id gx4so31772354ieb.0
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 00:15:27 -0700 (PDT)
In-Reply-To: <20150528070943.GA3532@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, niranjan Patil <Niranjan.Patil@infocus.com>, fabio Estevam <festevam@gmail.com>, richard Jiang <Richard.Jiang@infocus.com>
List-Id: alsa-devel@alsa-project.org


On 05/28/2015 03:09 PM, Nicolin Chen wrote:
> On Thu, May 28, 2015 at 03:02:31PM +0800, Xuebing Wang wrote:
>
>> According to iMX6SL reference manual, 'TSCKP = 1' means "Data clocked out on
>> *falling* edge of bit clock." (for I2S master mode), rather than "Data on
>> rising edge of bclk in the comments". This means this comment in the source
>> code is *partially* WRONG, am I correct?
> As you can see, it says "clock out on falling edge" which means
> for the receiver is still latching the data at the rising edge.
>

Nicolin,

Thank you very much. Got you now.

> Nicolin
>

-- 
-- Xuebing
