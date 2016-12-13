From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] pcm: fix wrong document references to PCM
 APIs which perform direct memory access with frame copying
Date: Tue, 13 Dec 2016 09:03:30 +0900
Message-ID: <ebc3d442-d2ca-b6c3-3b72-77c9d6974911@sakamocchi.jp>
References: <20161211113138.32468-1-o-takashi@sakamocchi.jp>
 <s5hy3zkzv63.wl-tiwai@suse.de>
 <acda020e-47d2-f1a2-603e-a16999355324@sakamocchi.jp>
 <s5hk2b4zqhf.wl-tiwai@suse.de> <s5hh968zq4v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 5A15026658E
 for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2016 01:03:55 +0100 (CET)
In-Reply-To: <s5hh968zq4v.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 13 2016 08:25, Takashi Iwai wrote:
> Actually I took the second one (the removal of unused variables), as
> it's a good cleanup.
>
> But the first one, the change of the type, is in a gray zone, and I'd
> like to leave such a thing.  Changing the loop variable like i to
> unsigned int is rather confusing, and it may be a source of bugs if
> anyone reuses i for another loop.  The warning is merely an annoyance,
> and IMO, we just should suppress the compile warning like the kernel
> does.
>
> The third patch, the removal of the unused table, is postponed because
> I don't know whether it's intentional or overlook unless confirmation
> from Intel people.

OK. I wait for their ack about these two patches. Thanks for your reviewing!

>>> [alsa-devel] [PATCH][alsa-lib] topology: fix sign-compare warning
>>> introduced to set_link_hw_config() and tplg_add_link_object()
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115245.html
>>>
>>> [alsa-devel] [PATCH][alsa-lib] topology: fix unused-variable warnings
>>> introduced to build_link()
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115246.html
>>>
>>> [alsa-devel] [PATCH][alsa-lib] topology: fix unused-const-variable warning
>>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115247.html


Gute Nacht.

Takashi Sakamoto
