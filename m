From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC] dice: simplifying address registration
Date: Sat, 25 Apr 2015 21:25:14 +0900
Message-ID: <553B87AA.60800@sakamocchi.jp>
References: <553A3FC5.60809@sakamocchi.jp> <553B5534.1060005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 95F6C26155B
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2015 14:25:18 +0200 (CEST)
In-Reply-To: <553B5534.1060005@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks for your comment.

On Apr 25 2015 17:49, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Currently Dice driver keeps address ranges for each unit instance. But
>> there's a way to reuse the same address range.
> 
> This requires an additional check for the packet's source node, which is
> essentially a duplicate of the core's address lookup code.
>
>> I think this idea can simplify driver probe processing
> 
> Yes, but that code is just moved to the module load processing.

>From probe processing, thus address allocation is just one time, not
each time IEEE 1394 unit is probed.

>> and save resources of host controller.
> 
> When using multiple DICE devices, this saves four bytes of FireWire
> address space per card, out of the total address space of 2^48 bytes.
> Or what other resources do you mean?

Actually, 2^48 bytes are really huge. But there're some rude devices to
transfer transaction to a certain address (i.e. Fireworks). For me, it's
basically better idea to keep allocated address range as small as possible.

...But seems to be not so practical. OK. I dropped this patch.


Thanks

Takashi Sakamoto
