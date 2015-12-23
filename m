From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH 12/19] ASoC: codec: rt5651: add ACPI and OF
	support
Date: Wed, 23 Dec 2015 05:29:53 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7010E35FA@RTITMBSV03.realtek.com.tw>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1450406156-22246-13-git-send-email-pierre-louis.bossart@linux.intel.com>
 <20151219115047.GI5727@sirena.org.uk> <56782662.8050907@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 679A92654D4
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 06:30:00 +0100 (CET)
In-Reply-To: <56782662.8050907@linux.intel.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Tuesday, December 22, 2015 12:19 AM
> To: Mark Brown
> Cc: Bard Liao; alsa-devel@alsa-project.org; Jack Yu
> Subject: Re: [alsa-devel] [PATCH 12/19] ASoC: codec: rt5651: add ACPI and
> OF support
> 
> On 12/19/15 5:50 AM, Mark Brown wrote:
> > On Thu, Dec 17, 2015 at 08:35:49PM -0600, Pierre-Louis Bossart wrote:
> >
> >> +#if defined(CONFIG_OF)
> >> +static const struct of_device_id rt5651_of_match[] = {
> >> +	{ .compatible = "realtek,rt5651", },
> >> +	{},
> >> +};
> >> +MODULE_DEVICE_TABLE(of, rt5651_of_match); #endif
> >
> > You need a binding document for new DT bindings.
> 
> Ah yes.
> I added ACPI and OF support through copy-paste and s/rt5640/rt5651/, but
> I can only test ACPI and wouldn't know what bindings are required so will
> remove this OF part in the next batch.
> Bard and team if you want to add OF support please go ahead.

Sure, I will do it.

> 
> 
> 
> ------Please consider the environment before printing this e-mail.
