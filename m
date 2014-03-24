From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 08/13] ASoC: Track which components have
 been registered with snd_soc_register_component()
Date: Mon, 24 Mar 2014 13:07:08 +0100
Message-ID: <53301FEC.6090507@metafoo.de>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-9-git-send-email-lars@metafoo.de>
 <20140324111805.GI1665@opensource.wolfsonmicro.com>
 <533019C1.6090402@metafoo.de> <20140324114837.GJ2269@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-085.synserver.de (smtp-out-091.synserver.de
 [212.40.185.91])
 by alsa0.perex.cz (Postfix) with ESMTP id F3580261A38
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 13:06:25 +0100 (CET)
In-Reply-To: <20140324114837.GJ2269@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On 03/24/2014 12:48 PM, Mark Brown wrote:
> On Mon, Mar 24, 2014 at 12:40:49PM +0100, Lars-Peter Clausen wrote:
>
>> My plan is to let it take a pointer to the component itself. I'm just not
>> too sure about the implementation details yet.
>
> The question there is why you'd ever want to only unregister a single
> thing that the device registered.  devm_ does make this a bit more
> academic but still.
>

I you probably wouldn't, but I think it makes the interface cleaner and devm 
doesn't really care whether we store a pointer to the parent device or a 
pointer to the component in the devm data.

- Lars
