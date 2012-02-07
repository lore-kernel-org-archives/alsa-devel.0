From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add support for TI LM49453 Audio
	codec
Date: Tue, 7 Feb 2012 17:04:05 +0000
Message-ID: <20120207170405.GA15929@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434ABCB420@EXMAIL02.scwf.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 86BC2103BEA
	for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2012 18:04:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <290463D19D2E064191F1F96ECA480A89434ABCB420@EXMAIL02.scwf.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Reddy, MR Swami" <MR.Swami.Reddy@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 06, 2012 at 06:20:26AM -0800, Reddy, MR Swami wrote:

> Changes made in v3:
> o Updated the lm49453_set_dai_pll() as per review comments in v2 patch.
>     o Removed pll disable code in _set_dai_pll().

This doesn't really seem to address the issue at all - you still have
the problems with the set_pll() function not doing anything it's
supposed to do with the input and output frequencies, and now there's no
way to disable the PLL.
