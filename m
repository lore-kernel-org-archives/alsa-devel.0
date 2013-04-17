From: Nate Case <ncase@xes-inc.com>
Subject: Re: snd_pcm_avail() and snd_pcm_avail_update() always
	returns buffer_size
Date: Wed, 17 Apr 2013 14:00:52 -0500 (CDT)
Message-ID: <9a2a6a9c-0d6d-4a5f-a9f7-b18997c9ffab@zimbra>
References: <9206524.125916.1365606552656.JavaMail.ncase@ncase1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 83F652616FE
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 21:00:59 +0200 (CEST)
Received: from zimbra.xes-mad.com (cal [10.52.0.127])
 by xes-mad.com (8.13.8/8.13.8) with ESMTP id r3HJ0qk5010661
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 14:00:52 -0500
In-Reply-To: <9206524.125916.1365606552656.JavaMail.ncase@ncase1>
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
List-Id: alsa-devel@alsa-project.org

----- Original Message -----
> I'm debugging an issue where both snd_pcm_avail_update() and
> snd_pcm_avail() are always returning buffer_size, even after
> successfully calling snd_pcm_writei() repeatedly.
> 
> This is causing problems when I first start playback.  My goal was to
> fill up the playback buffer until it's almost full when first
> starting,
> and then enter my regular playback loop where I write period_size
> at a time.
> 
[snip]

Replying to my own thread here:

I looked into this more closely again today, and found an unrelated bug
in my application causing the strange behavior I was observing.  It
turned out that ALSA was behaving exactly as expected for what was
going on.

Thanks,

Nate
