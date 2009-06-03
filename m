From: "chaithrika" <chaithrika@ti.com>
Subject: Re: [PATCH v3 5/6] ARM: DaVinci: ASoC: Add
	mcasp	support for DM646x
Date: Wed, 3 Jun 2009 16:33:51 +0530
Message-ID: <00ee01c9e43a$fa552550$eeff6ff0$@com>
References: <1243501868-28565-1-git-send-email-chaithrika@ti.com>
	<20090530162647.GA19692@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 13168243FF
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 13:04:57 +0200 (CEST)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n53B4pGC003313
	for <alsa-devel@alsa-project.org>; Wed, 3 Jun 2009 06:04:56 -0500
Received: from tidmzi-ftp.india.ext.ti.com (localhost [127.0.0.1])
	by dflp53.itg.ti.com (8.13.8/8.13.8) with SMTP id n53B4nhU000011
	for <alsa-devel@alsa-project.org>; Wed, 3 Jun 2009 06:04:50 -0500 (CDT)
Received: from symphonyindia.ti.com (symphony-ftp [192.168.247.11])
	by tidmzi-ftp.india.ext.ti.com (Postfix) with SMTP id DD5FB3886B
	for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2009 16:32:11 +0530 (IST)
In-Reply-To: <20090530162647.GA19692@sirena.org.uk>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>, alsa-devel@alsa-project.org, 'Steve Chen' <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, 'Naresh Medisetty' <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark,

> > +static int davinci_i2s_mcasp_probe(struct platform_device *pdev)
> > +{
> > +	struct evm_snd_platform_data *parray = pdev->dev.platform_data;
> > +	struct davinci_pcm_dma_params *dma_data;
> > +	struct resource *mem, *ioarea, *res;
> > +	struct evm_snd_platform_data *pdata;
> 
> Why is the McASP driver using platform data called
> 'evm_snd_patform_data'?
> This suggests that there's some abstraction problem with the separation
> between the machine and McASP drivers.
> 

The platform data consists of information specific to EVM and SoC 
and is used by the platform driver (McASP driver) to get relevant 
data. Therefore it seems right to use the platform data here.
Please let me know your opinion.

Regards,
Chaithrika

> Are the two DAIs directly tied to each other in hardware?  If not it'd
> probably be better to have them registered as separate devices and
> probe
> separately so that if another chip comes along with a different set of
> DAIs it can be accommodated more readily - if the register interfaces
> stay consistent it may simply be a case of registering the new device.
> 
> > +	ret = snd_soc_register_dais(davinci_iis_mcasp_dai,
> > +				ARRAY_SIZE(davinci_iis_mcasp_dai));
> > +	if (ret != 0)
> > +		goto err_release_region;
> 
> You should initialise dev within the DAI to be the struct device for
> the
> platform driver you were probed with.  It might also be nice to tie
> this
> in to num_links somehow.
