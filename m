From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 08/39] firewire-lib: Add support for duplex
 streams synchronization in blocking mode
Date: Mon, 10 Mar 2014 21:21:31 +0900
Message-ID: <531DAE4B.5030300@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-9-git-send-email-o-takashi@sakamocchi.jp>
 <531CD52A.1040902@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DB8E265113
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 13:21:41 +0100 (CET)
In-Reply-To: <531CD52A.1040902@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 3 2014 05:55), Clemens Ladisch wrote:
> This pointer does not report any actual error code either.

OK. I use NULL instead of this.

> Why this change in this patch?

It's my mistake and should be removed.

> It might be easier to check just s->sync_slave instead of multiple flags.
>
>Same here.

Hm. But s->sync_slave->callbacked is also needed. So:

###
if (s->sync_slave && s->sync_slave->callbacked)
###

> This name is rather generic; this is not "the" callback, but the
> "initial" or "first" callback.

OK. I use "amdtp_stream_first_callback" instead of "amdtp_stream_callback".

> This is not necessary here.

Exactly.

> This needs to be done only if sync_mode != CIP_SYNC_TO_DEVICE.

OK.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
