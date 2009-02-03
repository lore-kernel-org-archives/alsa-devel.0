From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: pxa-ssp: select PXA_SSP
Date: Tue, 3 Feb 2009 18:15:16 +0100
Message-ID: <74d0deb30902030915x55d36e10yd293cf9da2a27172@mail.gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-5-git-send-email-philipp.zabel@gmail.com>
	<20090203163549.GF23827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 366DA103891
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 18:15:17 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j78so1967025rne.21
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 09:15:16 -0800 (PST)
In-Reply-To: <20090203163549.GF23827@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 3, 2009 at 5:35 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Feb 03, 2009 at 05:19:43PM +0100, Philipp Zabel wrote:
>> snd-soc-pxa-ssp depends on PXA_SSP being enabled.
>> Let SND_PXA_SOC_SSP select it, like SPI_PXA2XX does.
>
>> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>
> Unfortunately Kconfig ignores selects from things that are themselves
> selected so this won't do anything.

Ok. I guess I'll just select it from MACH_MAGICIAN then.

regards
Philipp
