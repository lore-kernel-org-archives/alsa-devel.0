From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC DAI on Atmel AT32AP7000
Date: Sun, 30 Aug 2009 11:19:31 +0100
Message-ID: <20090830101931.GA11738@sirena.org.uk>
References: <608a0a800908291141q47aa9944v47cdcdc88b306002@mail.gmail.com>
	<20090830100227.GB4334@sirena.org.uk>
	<608a0a800908300313q39a8367dka94e2058c2d80ac4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 70DF724346
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Aug 2009 12:19:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <608a0a800908300313q39a8367dka94e2058c2d80ac4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christos Nikolaou <sv1eia@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 30, 2009 at 01:13:45PM +0300, Christos Nikolaou wrote:
> On Sun, Aug 30, 2009 at 1:02 PM, Mark
> Brown<broonie@opensource.wolfsonmicro.com> wrote:

> > That's fine, these are just warning messages and have no actual effect
> > on operation.

> So that means these are generated but the codec driver will eventually
> work right?

Yes, they haev absolutely no effect other than to print that message.

> These statements are already there and the output shown is the drivers
> being intilized properly, this output is on the same log as the No
> device for DAI errors, I was displaying it here to show that although
> the devices are initialized ASoC reports an error

Oh, so your system is actually running fine then?

> So in a feature version, the Atmel platform to ASoC glue drivers like
> playpaq_wm8510.c will initialize the required drivers (probably
> filling the ssc pointer I guess) but as for the time being that
> non-initialization does not create any problems right?

No, the DAI should take care of this for itself - it should be
instantiated as a regular platform device without any intervention from
the machine driver.
