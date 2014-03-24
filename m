From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/13] ASoC: Track which components have
	been	registered with snd_soc_register_component()
Date: Mon, 24 Mar 2014 11:18:05 +0000
Message-ID: <20140324111805.GI1665@opensource.wolfsonmicro.com>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 633D72616B4
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 12:18:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1395129736-11938-9-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 18, 2014 at 09:02:11AM +0100, Lars-Peter Clausen wrote:
> snd_soc_unregister_component() takes the parent device of the component as a
> parameter and then looks up the component based on this. This is a problem if
> multiple components are registered for the same parent device. Currently drivers
> do not do this, but some drivers register a CPU DAI component and a platform for
> the same parent device. This will become a problem once platforms are also made
> components. To make sure that snd_soc_unregister_component() will not
> accidentally unregister the platform in such a case only consider components
> that were registered with snd_soc_register_component(). This is only meant as
> short term stopgap solution to be able to continue componentisation. Long term
> we'll need something different.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

Do we have any thoughts on what might be a longer term solution
here? Is the parent device actually the right thing to pass to
snd_soc_unregister_component, it feels like that is probably not
going to be enough to accurately identify the component?

Thanks,
Charles
