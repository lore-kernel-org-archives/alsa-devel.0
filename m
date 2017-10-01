From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH] seq: fix snd_seq_set_queue_tempo() usage
 example in the documentation
Date: Sun, 1 Oct 2017 11:23:05 +0200
Message-ID: <20171001112305.8c6d2d0a7fea2cde79ca1675@ao2.it>
References: <20170928134615.20712-1-ao2@ao2.it>
 <9dce17bf-11f0-d2c9-8285-f5d4cd13d86d@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ao2.it (ao2.it [92.243.12.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 1155E266D00
 for <alsa-devel@alsa-project.org>; Sun,  1 Oct 2017 11:23:07 +0200 (CEST)
In-Reply-To: <9dce17bf-11f0-d2c9-8285-f5d4cd13d86d@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 29 Sep 2017 11:04:25 +0900
Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:

> Hi,
> 
> On Sep 28 2017 22:46, Antonio Ospite wrote:
> > snd_seq_set_queue_tempo() requires a queue id as the second argument,
> > fix the example in documentation to reflect that.
> > 
> > Also add the queue id as an argument of the set_tempo() function, just
> > to keep the whole example compilable.
> > 
> > Signed-off-by: Antonio Ospite <ao2@ao2.it>

[...]
> This looks good catch for documentation.
> 
> Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>

Thanks Takashi.

> Unfortunately, a maintainer of this subsystem is absent this week. Your 
> patch is going to put into merge queue after he's back. It may takes a 
> bit longer.
> 

No problem about the delay, it's surely not a critical fix. :)

Ciao ciao,
   Antonio

-- 
Antonio Ospite
https://ao2.it
https://twitter.com/ao2it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
