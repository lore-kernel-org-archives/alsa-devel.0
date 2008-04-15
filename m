From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] soc - pxa2xx-ac97: Add missing
	clk_enable()
Date: Tue, 15 Apr 2008 13:29:06 +0100
Message-ID: <20080415122906.GC24498@rakim.wolfsonmicro.main>
References: <20080414151128.GA23694@rakim.wolfsonmicro.main>
	<1208185942-27637-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<f17812d70804150432t1fd0e20cpedaba34b47eb807d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE9592470F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 14:29:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70804150432t1fd0e20cpedaba34b47eb807d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: eric miao <eric.y.miao@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 15, 2008 at 07:32:39PM +0800, eric miao wrote:

> It looks a bit confused between the commit message and the actual change.
> My understanding would be the pxa{25x,27x} requires this change (adding
> clk_enable), but pxa3xx does not require this. So actually the change is
> addressing some issue on pxa{25x,27x}?

For correctness WRT the clock API it's required on all variants - the
note about PXA3xx is just to indicate how it got through testing.
