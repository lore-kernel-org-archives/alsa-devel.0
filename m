From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: pxa2xx-ssp
Date: Mon, 27 Oct 2008 12:47:06 +0000
Message-ID: <20081027124705.GE5896@sirena.org.uk>
References: <1224809675.8330.4.camel@brutus>
	<1224863678.28382.54.camel@dell-desktop.example.com>
	<1224912767.5426.19.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id ED8D324734
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 13:47:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1224912767.5426.19.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 25, 2008 at 03:32:47AM -0200, Daniel Ribeiro wrote:

> 	To ease your reading, attached is a diff against [0]. It is updated to
> build on the latest linus tree and handles DAIFMT_I2S and DAIFMT_MSB
> differently.

Please work against the pxa-ssp driver, not the pxa2xx-ssp driver.
There are no plans to merge the pxa2xx-ssp driver - the pxa-ssp should
be able to cover everything, perhaps with a couple of functions selected
per-CPU, but it's not been tested on pxa2xx yet.  It should hopefully be
making its way upstream today or tomorrow.
