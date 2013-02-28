From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
	of serializers
Date: Thu, 28 Feb 2013 12:02 +0100
Message-ID: <2559045.s5gCxPtNFX@ganymedes>
References: <1631475.f7GPhLiLxV@ganymedes> <8652573.mejjkM8Cr8@ganymedes>
 <512F241F.9080305@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx04.lb01.inode.at [62.99.145.4])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FED5265D81
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2013 12:02:01 +0100 (CET)
In-Reply-To: <512F241F.9080305@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mike Looijmans <mike.looijmans@topic.nl>
List-Id: alsa-devel@alsa-project.org


On Thursday, February 28, 2013 10:32:15 Mike Looijmans wrote:

> That's a big improvement over "rx_num_evt". The first time I saw this
> struct, I thought I had to set rx_num_evt to the number of receiving AXR
> pins in use.
> 
> Maybe call it "rx_min_fifo_depth" because just "depth" might be
> interpreted as the capaciity or maximum size of the fifo, while in fact
> the parameter is a minimum amount of data to be put into the FIFO
> buffer. Of maybe "rx_fifo_thd" to indicate it's a threshhold. And use
> the same name for the "tx" part as well (tx_fifo_thd or tx_fifo_min_depth).

 "rx_min_fifo_depth" or  "tx_min_fifo_depth"  seem to be fine.
If I'll have time, I'll prepare patch. That's cosmetic upgrade, but should 
help others.

Michal.
