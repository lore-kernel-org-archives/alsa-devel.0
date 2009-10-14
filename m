From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Which transfer mode to use
Date: Wed, 14 Oct 2009 16:44:44 +0200
Message-ID: <4AD5E3DC.5070701@ladisch.de>
References: <op.u1setrz8soui26@mail.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 90FED243FF
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 16:44:46 +0200 (CEST)
In-Reply-To: <op.u1setrz8soui26@mail.gmx.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Till Crueger <Till.Crueger@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Till Crueger wrote:
> 1. Asynchronous callback:
> This method seems to be the best explained by all the tutorials I could
> find, so I am guessing this is the best choice for audio applications.

It's the worst choice; it isn't available on many devices, and the
asynchronous callback cannot do much because it might have interrupted
some non-reentrant function.

> 2. read/write:
> So far this seems the best choice.

Use it.

> For this however I would have to figure out after each polling, how
> much data can be written.

snd_pcm_avail()

> I found some concerns about differences in lattency between these
> three methods.

Those concerned have not measured; the latency is _exactly_ the same.


HTH
Clemens
