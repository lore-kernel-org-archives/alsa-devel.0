From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
 fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 13:40:23 -0500
Message-ID: <4852BF17.50408@freescale.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>	
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>	
	<9e4733910806122016q4e10b56atc2fb9c91e129d6cb@mail.gmail.com>	
	<9e4733910806122036g5b8d86f6wed526f29377a065d@mail.gmail.com>	
	<48526566.8080400@freescale.com>	
	<20080613150427.GA32377@rakim.wolfsonmicro.main>	
	<9e4733910806130810y24e6a04bh12eed5a26d0a79c4@mail.gmail.com>	
	<48528E81.2050901@freescale.com>	
	<9e4733910806130826l55342b78mae243e7715c61e83@mail.gmail.com>	
	<20080613155712.GA9955@rakim.wolfsonmicro.main>
	<9e4733910806130959m5cfbefbbo747642789190c285@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id F1A9A2448D
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 20:40:27 +0200 (CEST)
In-Reply-To: <9e4733910806130959m5cfbefbbo747642789190c285@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:
> Each of these drivers configures
> the psc in to the correct mode when they load. (I think Timur has a
> unified driver, I don't work with his hardware).

I only support the I2S mode of the SSI hardware.  If I were to add AC97 support,
then I would probably make it a unified driver, but I'm not sure because I don't
know enough about AC97 to see how that would work.

-- 
Timur Tabi
Linux kernel developer at Freescale
