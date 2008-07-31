From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: I2S simple driver
Date: Thu, 31 Jul 2008 10:52:06 +0100
Message-ID: <20080731095205.GB11790@sirena.org.uk>
References: <4890F69E.8010207@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 359E92458A
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Jul 2008 11:52:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4890F69E.8010207@manoweb.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 30, 2008 at 04:17:50PM -0700, Alessio Sangalli wrote:
> Hi, we are writing a small driver to control a I2S interface on our
> ARM-based system...

Which processor are you using?

> Right now we are going to implement a "easier" interface that allows to
> set some parameters, and then simply write to the device that will
> automatically control the DAC and then to the speakers.

> Now, this is of course not ALSA compliant. How can we estimate the
> effort to make this simple driver ALSA compatible so that every ALSA
> application can use this device for playback? We do not have any volume
> control and the range of sound "modes" is extremely limited.

You might want to have a look at the ASoC subsystem under sound/soc - it
provides a framework which should allow you to bring something up fairly
quickly.  The core of this framework handles the ALSA interfacing that
isn't specific to a given piece of hardware with separate drivers being
provided for each hardware component which only need implement the
specifics for the device.

As well as the code there's some documentation in the kernel sources
under Documentation/sound/alsa/soc.
