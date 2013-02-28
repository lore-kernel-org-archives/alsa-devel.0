From: Daniel Mack <zonque@gmail.com>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
 of serializers
Date: Thu, 28 Feb 2013 14:26:52 +0100
Message-ID: <512F5B1C.4020508@gmail.com>
References: <1631475.f7GPhLiLxV@ganymedes> <8652573.mejjkM8Cr8@ganymedes>
 <512F241F.9080305@topic.nl> <2559045.s5gCxPtNFX@ganymedes>
 <512F5959.9030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f43.google.com (mail-bk0-f43.google.com
 [209.85.214.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 03939265D9D
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 14:26:54 +0100 (CET)
Received: by mail-bk0-f43.google.com with SMTP id jm19so855721bkc.30
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 05:26:54 -0800 (PST)
In-Reply-To: <512F5959.9030004@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

On 28.02.2013 14:19, Daniel Mack wrote:
> On 28.02.2013 12:02, Michal Bachraty wrote:
>> On Thursday, February 28, 2013 10:32:15 Mike Looijmans wrote:
>>
>>> That's a big improvement over "rx_num_evt". The first time I saw this
>>> struct, I thought I had to set rx_num_evt to the number of receiving AXR
>>> pins in use.
>>>
>>> Maybe call it "rx_min_fifo_depth" because just "depth" might be
>>> interpreted as the capaciity or maximum size of the fifo, while in fact
>>> the parameter is a minimum amount of data to be put into the FIFO
>>> buffer. Of maybe "rx_fifo_thd" to indicate it's a threshhold. And use
>>> the same name for the "tx" part as well (tx_fifo_thd or tx_fifo_min_depth).
>>
>>  "rx_min_fifo_depth" or  "tx_min_fifo_depth"  seem to be fine.
>> If I'll have time, I'll prepare patch. That's cosmetic upgrade, but should 
>> help others.
> 
> Be careful with such changes. In general, DT bindings are forever in
> general, because you can't update all the users out there, and so every
> binding that has ever existed has to be supported in the future, for
> backwards compatibility.
> 
> In this case, we might make an exception, given that for AM33xx, the
> necessary DMA bits are still not missing, and Davinci is not yet fully
> ported to DT either. So nobody really uses the driver on this platforms.

Sorry, let me rephrase that last paragraph:

In this case, we might make an exception, given that for AM33xx, the
necessary DMA bits are still missing, and Davinci is not yet fully
ported to DT either. So supposedly nobody really uses the driver on this
platforms via DT.



Daniel
