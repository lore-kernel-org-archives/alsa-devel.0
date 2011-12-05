From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/21] ASoC: Convert WM8741 to
	devm_kzalloc()
Date: Mon, 5 Dec 2011 12:08:12 +0000
Message-ID: <20111205120811.GJ11150@opensource.wolfsonmicro.com>
References: <1322948009-27658-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1322948009-27658-7-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20111205065931.GA7341@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 224812417B
	for <alsa-devel@alsa-project.org>; Mon,  5 Dec 2011 13:08:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111205065931.GA7341@avionic-0098.mockup.avionic-design.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 05, 2011 at 07:59:31AM +0100, Thierry Reding wrote:

> Any particular reason why this is not collapsed into:

> 	return snd_soc_register_codec(...)

> The same goes for patches 8 and 9.

It's more effort than a fairly mechanical change and we'll want to add
the more structured code back very soon anyway as we push more of the
init into the I2C and SPI inits.
