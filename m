From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
 of serializers
Date: Thu, 28 Feb 2013 10:32:15 +0100
Message-ID: <512F241F.9080305@topic.nl>
References: <1631475.f7GPhLiLxV@ganymedes> <4506811.gzuv2dFpKQ@ganymedes>
 <512DF67A.5030906@topic.nl> <8652573.mejjkM8Cr8@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob14.myregisteredsite.com
 (atl4mhob14.myregisteredsite.com [209.17.115.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D187265D56
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 10:32:19 +0100 (CET)
Received: from mailpod.hostingplatform.com (mail.networksolutionsemail.com
 [205.178.146.50])
 by atl4mhob14.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r1S9WG6v028674
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 04:32:16 -0500
In-Reply-To: <8652573.mejjkM8Cr8@ganymedes>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/28/2013 10:06 AM, Michal Bachraty wrote:
> Hi Mike,
>
> Many thanks!
> Now all about "tx-num-evt" or "rx-num-evt" make sense.
>
>> Maybe the misleading "rx_num_evt" should be renamed to "use_rx_fifo". I
>> understand that not all McASP interfaces have a FIFO
>
> Maybe, "rx_fifo_depth" could be also used.

That's a big improvement over "rx_num_evt". The first time I saw this 
struct, I thought I had to set rx_num_evt to the number of receiving AXR 
pins in use.

Maybe call it "rx_min_fifo_depth" because just "depth" might be 
interpreted as the capaciity or maximum size of the fifo, while in fact 
the parameter is a minimum amount of data to be put into the FIFO 
buffer. Of maybe "rx_fifo_thd" to indicate it's a threshhold. And use 
the same name for the "tx" part as well (tx_fifo_thd or tx_fifo_min_depth).

Mike.
