From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH v2] ASoC: soc-core: add
 snd_soc_of_parse_master_clkdir() for dt
Date: Wed, 8 Jan 2014 03:35:39 +0000
Message-ID: <554107b2aad04339b6c543ab958d7244@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388630905-1321-1-git-send-email-Li.Xiubo@freescale.com>
 <20140107170538.GA31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ABD72616FF
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 04:35:43 +0100 (CET)
In-Reply-To: <20140107170538.GA31886@sirena.org.uk>
Content-Language: en-US
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH v2] ASoC: soc-core: add snd_soc_of_parse_master_clkdir()
> for dt
> 
> On Thu, Jan 02, 2014 at 10:48:25AM +0800, Xiubo Li wrote:
> > This patch adds snd_soc_of_parse_master_clkdir() and supports below
> > style on dt:
> >
> > master-clkdir-out;
> >
> > If this property is absent 0 will be returned, 1 otherwise.
> > 0 : SND_SOC_CLOCK_IN
> > 1 : SND_SOC_CLOCK_OUT
> 
> This is mostly OK code wise, though it would be good to use those
> constants in the code.  However I'm still not sure about it being a good
> idea - it's similar issues to those with clock IDs but less strong.  Do
> you have a user in mind?

Yes, for the SAI & SGTL5000 DAIs and the existing fsl_ssi.c driver, etc. For
SSI DAI device, it will depend on the sysclk directions to do the different
clock settings.

For the VF610 series, the SAI will provide the clock to SGTL5000 Codec. Using
the simple audio card driver, I must set the CPU and CODEC DAI sysclk dir
values differently.

I will send one simple audio card's use case based SAI & SGTL5000 later.

Thanks,

--
Best Regards,
Xiubo
