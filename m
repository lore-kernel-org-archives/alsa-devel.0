From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] Allow passing platform_data to devices
 attached to AC97 bus
Date: Thu, 23 Jul 2009 11:16:55 +0100
Message-ID: <20090723101654.GA6673@rakim.wolfsonmicro.main>
References: <200907211633.14388.marek.vasut@gmail.com>
	<200907212151.05301.marek.vasut@gmail.com>
	<20090722104029.GC21171@rakim.wolfsonmicro.main>
	<200907221259.13644.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4CA31039AA
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jul 2009 12:16:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907221259.13644.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 22, 2009 at 12:59:13PM +0200, Marek Vasut wrote:

> This patch allows passing platform_data to devices attached to AC97 bus
> (like touchscreens, battery measurement chips ...).
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Takashi, should I apply this to ASoC or do you want to merge it given
that it touches ALSA core stuff?
