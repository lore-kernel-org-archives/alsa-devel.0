From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: Freescale iMX6SL SSI (I2S master mode) Rising edge
 vs Falling edge
Date: Thu, 28 May 2015 00:09:44 -0700
Message-ID: <20150528070943.GA3532@Asurada>
References: <5566BD87.6040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 2488126042F
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 09:09:54 +0200 (CEST)
Received: by paza2 with SMTP id a2so16915478paz.3
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 00:09:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5566BD87.6040505@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: alsa-devel@alsa-project.org, niranjan Patil <Niranjan.Patil@infocus.com>, fabio Estevam <festevam@gmail.com>, richard Jiang <Richard.Jiang@infocus.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2015 at 03:02:31PM +0800, Xuebing Wang wrote:

> According to iMX6SL reference manual, 'TSCKP = 1' means "Data clocked out on
> *falling* edge of bit clock." (for I2S master mode), rather than "Data on
> rising edge of bclk in the comments". This means this comment in the source
> code is *partially* WRONG, am I correct?

As you can see, it says "clock out on falling edge" which means
for the receiver is still latching the data at the rising edge.

Nicolin
