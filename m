From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: add 88pm860x codec driver
Date: Wed, 18 Aug 2010 16:24:34 +0100
Message-ID: <20100818152433.GA32499@opensource.wolfsonmicro.com>
References: <AANLkTimBPhvukwqDGY8iORhY+wg8OnHi9+eOedJB2E8k@mail.gmail.com>
	<20100818141914.GC15536@sirena.org.uk>
	<AANLkTi=2FboP+xhSHjgyoM6LfmKw1khV62gTVrkxxUHF@mail.gmail.com>
	<20100818144027.GB4588@rakim.wolfsonmicro.main>
	<AANLkTikc+=-3Zt+iaD+UatWR-fgv4zL=xkhQH=_0Z4m8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 975AF2453C
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 17:24:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTikc+=-3Zt+iaD+UatWR-fgv4zL=xkhQH=_0Z4m8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 18, 2010 at 11:23:10PM +0800, Haojian Zhuang wrote:

> In my system, there's only one physical jacks. It's four phased plug
> (mic,left,right,gnd). So I needn't split them into two different
> jacks.

Right, but the CODEC driver (which will be used by all systems with this
CODEC) should allow the user that option.
