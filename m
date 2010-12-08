From: Alexander <subaparts@yandex.ru>
Subject: Re: [PATCH 2/3] ASoC: CS4271 codec support
Date: Thu, 09 Dec 2010 01:59:26 +0300
Message-ID: <1291849166.31916.74.camel@r60e>
References: <1291809772.31916.4.camel@r60e>
	<20101208130558.GE16418@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward16.mail.yandex.net (forward16.mail.yandex.net
	[95.108.253.141])
	by alsa0.perex.cz (Postfix) with ESMTP id B997A103B5E
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 23:59:32 +0100 (CET)
In-Reply-To: <20101208130558.GE16418@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Dear Mark,

On Wed, 2010-12-08 at 13:05 +0000, Mark Brown wrote:
> > +static const char *cs4271_de_texts[] = {"None", "44.1KHz", "48KHz", "32KHz"};
> > +static const struct soc_enum cs4271_de_enum =
> > +	SOC_ENUM_SINGLE(CS4271_DACCTL, 4, 4, cs4271_de_texts);
> 
> Ideally the deemphasis would be managed based on the sample rate.
> 

I'm not sure if it's necessary feature at all. And the way it should be
managed is something unclear to me )

All other issues were corrected, the patch will follow soon...

Best regards,
	Alexander A. Sverdlin.
