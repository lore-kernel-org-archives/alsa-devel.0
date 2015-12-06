From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [PATCH 1/3] fireface: add skeleton
 for RME Fireface series
Date: Mon, 7 Dec 2015 08:43:26 +1030
Message-ID: <20151206221326.GB6103@marvin.atrad.com.au>
References: <1449408224-13955-1-git-send-email-o-takashi@sakamocchi.jp>
 <1449408224-13955-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 536E8264F74
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 23:13:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1449408224-13955-2-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 06, 2015 at 10:23:42PM +0900, Takashi Sakamoto wrote:
> Three types of firmware have been released by RME GmbH; for Fireface 400,
> for Fireface 800 and for UCX/802/UFX.

The FF400 and FF800 firmwares are pretty much the same.  The control
protocol does differ between the two but at a fundamental level they are the
same - especially where streaming is concerned.  They are similar enough
that it would not make sense to implement a separate driver for the FF800.

You are correct in concluding that the latter is a totally new firmware.  In
addition to the UFX/UCX/802 RME have also ported as much as is relevant to
the FF800.  The mixer interface (which doesn't directly concern ALSA) is
completely different.  I have not yet investigated the streaming part in
full but my initial investigations suggest that it may not be significantly
different.

> It's reasonable that these models use different protocol for
> communication.

For FF400 and FF800 the streaming protocol is very similar.  I expect the
same to hold for the newer devices too, but will be able to say more once I
get a chance to fully probe the UFX.  In other words, at this stage it is
fair to say that the streaming component for all devices will be similar,
and there is probably no reason to consider there being three completely
different firmwares.  There are obviously some differences which will need
to be allowed for in places, but the same is true for almost every device
family.

In the patch:

> diff --git a/sound/firewire/fireface/fireface.c b/sound/firewire/fireface/fireface.c
> new file mode 100644
> index 0000000..7e21667
> --- /dev/null
> +++ b/sound/firewire/fireface/fireface.c
> @@ -0,0 +1,139 @@
> +/*
> + * fireface.c - a part of driver for RMW Fireface series

Typo: it should be "RME", obviously.

> +	/* TODO: how to detect all of models? */
> +	model = "Fireface 400";

Though the unit version field of the ConfigROM.

Once I get my head around git and how best to keep track of these patch
series I can provide a patch for this.  Despite several attempts to truly
understand git over the last few years I have so far failed abysmally.  :-(

jonathan
