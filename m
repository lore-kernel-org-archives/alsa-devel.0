From: Liam Girdwood <lrg@kernel.org>
Subject: Re: (SoC) Does i.MX27's SSI work as I2S clock master?
Date: Wed, 26 Nov 2008 08:34:46 +0000
Message-ID: <1227688486.585.89.camel@vega.slimlogic.co.uk>
References: <D66C4C05-340D-4A6E-98FC-7B36F4059C36@drvlabo.jp>
	<20081125202703.GC6572@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 00490244DC
	for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2008 09:34:52 +0100 (CET)
In-Reply-To: <20081125202703.GC6572@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ngc <ngc@drvlabo.jp>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-11-25 at 20:27 +0000, Mark Brown wrote:
> On Wed, Nov 26, 2008 at 04:54:11AM +0900, ngc@drvlabo.jp wrote:
> 
> > Then, I'm trying to play sounds via WM8728 and
> > have not hear any sounds yet.
> > I checked SSI-3 signal set with an oscilloscope,
> > no clock signal appears on SSI3_CLK.
> > I tried the various SSI setting, I2S normal, I2S master,
> > asychronous/synchronous, normal mode/network mode, ...
> > But, I can't see clock signal, yet.
> 
> Is it just SSI3_CLK that produces no output or do you also see nothing
> on the I2S bit clock, frame sync and data signals?
> 
> > I want to know an example setting to act i.MX' SSI as I2S clock master.
> 
> I'm not aware of any public examples of i.MX code other than what is in
> the ASoC git repository and the Freescale BSPs, and the only example I
> can see in ASoC git is for i.MX31.

It's probably also worth checking your AUDMUX settings wrt to SSI clock
source and direction, SSI controller clock and SSI GPIO's.

Liam
