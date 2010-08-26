From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Thu, 26 Aug 2010 14:32:29 +0100
Message-ID: <20100826133229.GA3803@opensource.wolfsonmicro.com>
References: <20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
	<20100824101032.GA15278@rakim.wolfsonmicro.main>
	<20100825135922.5589ba30.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08ACD10383B
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 15:32:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100825135922.5589ba30.jhnikula@gmail.com>
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

On Wed, Aug 25, 2010 at 01:59:22PM +0300, Jarkko Nikula wrote:

> I went back to original idea that prefixes only kcontrols of codec and
> doesn't add any new API. So if we can have DAIless codec drivers (i.e.
> amplifiers) then there is no immediate need for prefixing widgets and
> routes.

Note that even DAIless drivers can have routing in them - see WM9090 for
example.

> Cross-device links and DAPM between them remains unsolved as this tries
> to solve only kcontrol name issue with multiple codecs only.

I really think anything along these lines needs to handle DAPM somehow -
given that virtually every driver has DAPM support of some kind and
there are some fairly standard pin names for things it's likely that
you'll get the same issues there.
