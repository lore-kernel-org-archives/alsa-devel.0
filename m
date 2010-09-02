From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Thu, 2 Sep 2010 15:25:18 +0100
Message-ID: <20100902142518.GA5809@rakim.wolfsonmicro.main>
References: <20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
	<20100824101032.GA15278@rakim.wolfsonmicro.main>
	<20100825135922.5589ba30.jhnikula@gmail.com>
	<20100826133229.GA3803@opensource.wolfsonmicro.com>
	<20100830141729.75388459.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 63655244A6
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Sep 2010 16:25:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100830141729.75388459.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 30, 2010 at 02:17:29PM +0300, Jarkko Nikula wrote:

> I don't see it are there any problems. For me it looks the routes in
> WM9090 are unique and registered to own codec instance so there should
> not be route prefixing needed.

Meh, right.  DAPM isn't coping with things that cross CODECs really.
This will need to be looked at.

> How these amplifier drivers are actually meant to be probed? Currently
> struct snd_soc_codec_driver->probe is called only from
> soc_probe_dai_link.

We need to set up a list of anciliary devices which are registered
without DAIs for this.
