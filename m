From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/13] ASoC: Add snd_soc_kcontrol_codec()
	helper	function
Date: Mon, 24 Mar 2014 10:57:51 +0000
Message-ID: <20140324105750.GH1665@opensource.wolfsonmicro.com>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0BAF2610A0
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 11:57:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1395129736-11938-2-git-send-email-lars@metafoo.de>
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

On Tue, Mar 18, 2014 at 09:02:04AM +0100, Lars-Peter Clausen wrote:
> For CODEC controls snd_kcontrol_chip() currently returns a pointer to the
> CODEC that registered the control. With the upcoming consolidation of
> platform and CODEC controls this will change. Prepare for this by introducing
> the snd_soc_kcontrol_codec() helper function that will hide the implementation
> details of how the CODEC for a control can be obtained. This will allow us to
> change this easily in the future.
> 
> The patch also updates all CODEC drivers to use the new helper function.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

For the Wolfson bits:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
