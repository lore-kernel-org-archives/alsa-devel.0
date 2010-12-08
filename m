From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: CS4271 codec support
Date: Wed, 8 Dec 2010 13:39:35 +0000
Message-ID: <20101208133935.GI16418@rakim.wolfsonmicro.main>
References: <1291809772.31916.4.camel@r60e>
	<20101208130720.GB2716@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7053244AC
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 14:39:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101208130720.GB2716@pulham.picochip.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: alsa-devel@alsa-project.org, Alexander <subaparts@yandex.ru>, ryan@bluewatersys.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 01:07:20PM +0000, Jamie Iles wrote:

> Doesn't the dependency on SND_SOC_I2C_AND_SPI mean that you will always have 
> I2C and SPI_MASTER?

It's not a dependency for the CODEC driver at all.  It means that when
SND_SOC_ALL_CODECS is selecting the module it will ensure that a
consistent combination of options is chosen but it is unrelated to use
in machine drivers and doesn't force both to be enabled even when it is
selected.
