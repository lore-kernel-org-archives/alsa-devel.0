From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/3] ASoC: Convert wm8753 to a new-style
	i2c driver
Date: Mon, 1 Sep 2008 16:57:53 +0100
Message-ID: <20080901155752.GF2722@sirena.org.uk>
References: <20080901174534.663528a3@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 320912447C
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 17:57:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080901174534.663528a3@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Graeme Gregory <graeme@openmoko.org>, Ville@alsa-project.org, alsa-devel@alsa-project.org, Tim Niemeyer <reddog@mastersword.de>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 01, 2008 at 05:45:34PM +0200, Jean Delvare wrote:
> Convert the wm8753 codec driver to the new (standard) i2c device
> driver binding model.

> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Ville Syrjala <syrjala@sci.fi>
> Cc: Frank Mandarino <fmandarino@endrelia.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> Warning: this assumes that the neo1973 has its codec chip on I2C bus
> 0, which may or may not be the case. Someone with this machine please
> test and report.

I can confirm that the codec is on bus zero (but haven't actually tested
with this patch on the Neo!).
