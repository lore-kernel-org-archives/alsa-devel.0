From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: PXA2xx/3xx AC97 Driver(s)
Date: Wed, 2 Apr 2008 20:32:51 +0100
Message-ID: <20080402193250.GB9451@sirena.org.uk>
References: <47E7A0A8.3010200@oliford.co.uk>
	<20080324134231.GA30281@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id AC52024507
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Apr 2008 21:33:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080324134231.GA30281@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Oliver Ford <ipaqlinux@oliford.co.uk>, linux-arm-kernel@lists.arm.linux.org.uk, alex.meakins@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 24, 2008 at 01:42:32PM +0000, Mark Brown wrote:
> On Mon, Mar 24, 2008 at 12:38:00PM +0000, Oliver Ford wrote:

> > Is there any work currently under way on an AC97 driver for the PXA3xx?

> There is PXA3xx AC97 support present in the ASoC tree:

>    git://opensource.wolfsonmicro.com/linux-2.6-asoc

> It's under the asoc-v2-dev branch at the minute and is probably only
> done for the ASoC AC97 driver, I'd need to check.  The main reason it's

I have now merged the PXA3xx AC97 support into ASoC v1 and the non-ASoC
PXA AC97 driver.  Both drivers onto the dev branch of the above git
tree.  As I mentioned previously the intention is that they be merged
into the mainline during the 2.6.26 cycle.
