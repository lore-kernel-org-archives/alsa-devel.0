From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v3 5/8] ASoC: da7210: Add support for ADC &
 DAC equalizers
Date: Sat, 15 Oct 2011 13:24:33 +0530
Message-ID: <1318665273.613.1.camel@matrix>
References: <1318590666.12107.524.camel@matrix>
	<20111014194155.GO2931@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 89BA224390
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Oct 2011 09:43:11 +0200 (CEST)
In-Reply-To: <20111014194155.GO2931@opensource.wolfsonmicro.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-10-14 at 20:41 +0100, Mark Brown wrote:
> On Fri, Oct 14, 2011 at 04:41:06PM +0530, Ashish Chavan wrote:
> > This patch adds support for ADC and DAC five band equalizers
> > available on DA7210 codec.
> 
> This and some of the others just adding new controls are good but
> depend on the DAPM patches which I didn't apply.  I'd suggest
> reshuffling them earlier in the series.
> 

OK, will put them before DAPM and repost.
