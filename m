From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Advice on ASoC support for series of boards
Date: Fri, 15 May 2009 20:56:53 +0100
Message-ID: <20090515195653.GA16607@sirena.org.uk>
References: <20090515193406.GD23895@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B0BF51039B9
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 21:56:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090515193406.GD23895@trinity.fluff.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 15, 2009 at 08:34:06PM +0100, Ben Dooks wrote:

> Is there a standard method for binding an AMP to an driver, or is it
> necessary to have the AMPs in the driver itself? If not, what would
> people recommend to be the best example of this?

There's several drivers involved in an ASoC system - these things are
generally handled in the machine driver.

For power control for things like amplifiers this is done by providing
an event callback for one of the widgets for an output (eg, a
SND_SOC_DAPM_SPK()) and doing whatever is required to enable or disalbe
the device (usually updating a GPIO) in the callback.  This ensures that
the power control is integrated with DAPM power sequencing.  See the Mic
Jack handling in spitz.c for a mainline example of this.

For non-power control (eg, a mute controlled by a GPIO) a regular
control would be registered by the machine driver - the _EXT() controls
ASoC provides are designed for use here, allowing callbacks to be
registered to update GPIOs or do whatever other changes are required.
Of course, it's also possible to register normal ALSA controls as normal
without any ASoC specific stuff if desired.  Spitz also has some
examples of this.

I'm not sure if that answers your question?
