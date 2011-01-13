From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Make register_card API available to
	drivers
Date: Thu, 13 Jan 2011 11:26:08 +0000
Message-ID: <20110113112607.GA9936@opensource.wolfsonmicro.com>
References: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C5547245EB
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 12:28:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294901358-14364-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>, selma.bensaid@intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 12:19:18PM +0530, Koul, Vinod wrote:

> The register_card is an internal API which soc_probe uses to register the card.
> In order to create multiple cards we need to create multiple instances of
> soc-audio device. If we exposes the register card API for drivers to use, then
> machine driver can register their cards directly

> This patch makes register_card and unregister_card API available to machine
> drivers. This also maintains compatibility with older method of registration
> which can be marked depreciated and removed eventually.

This is probably mostly OK but it'd be good if you could break it down
into a small patch series.  At present it does a bunch of refactoring
and also adds the API - it'd be better if there were a sequence of
patches, each doing a single refactor, followed by a final patch which
exports the API.

Splitting it up like this will allow bisection if there's a problem
introduced by the change and makes review very much easier as there's
only one change to think about in a given patch.

> @@ -1870,16 +1868,12 @@ static int soc_probe(struct platform_device *pdev)
>  	struct snd_soc_card *card = platform_get_drvdata(pdev);
>  	int ret = 0;
>  
> +	/* no card, so machine driver will register explictly */
> +	if (!card)
> +		return 0;
> +

Hrm, this looks a bit surprising.  When we're registering directly from
the machine drivers I'd not expect us to end up going through soc-probe
at all and...

>  	/* Bodge while we unpick instantiation */
>  	card->dev = &pdev->dev;

...that the card device would be something passed in from the machine
driver (probably something that the architecture code registered in
order to allow the machine driver to probe, but possibly something
else).
