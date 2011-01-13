From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc core allow machine driver to
 register the card
Date: Thu, 13 Jan 2011 23:41:35 +0000
Message-ID: <20110113234135.GD13717@opensource.wolfsonmicro.com>
References: <1294939150-26443-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 483E32432F
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 00:41:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294939150-26443-1-git-send-email-vinod.koul@intel.com>
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
Cc: Harsha Priya <harsha.priya@intel.com>, alsa-devel@alsa-project.org, selma.bensaid@intel.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 10:49:10PM +0530, Koul, Vinod wrote:

> @@ -1870,6 +1868,10 @@ static int soc_probe(struct platform_device *pdev)
>  	struct snd_soc_card *card = platform_get_drvdata(pdev);
>  	int ret = 0;
>  
> +	/* no card, so machine driver is registering card */
> +	if (!card)
> +		return 0;
> +

I'll review this one more closely tomorrow - as I said with the combined
patch I'd not expect the soc-audio device to be involved when the
machine driver is registering a card so I'd like to understand in more
detail why this is still required.
