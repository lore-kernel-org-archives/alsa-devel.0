From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SOC: using a codec (ADAU1761) just as an analog
 mixer
Date: Wed, 12 Oct 2011 18:26:55 +0100
Message-ID: <20111012172655.GF1098@sirena.org.uk>
References: <CAC_9p+--aAUjR3vofdY_LZ0TsUr02TicNjfG-epNDtzh+=WHdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A27510382B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 19:26:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAC_9p+--aAUjR3vofdY_LZ0TsUr02TicNjfG-epNDtzh+=WHdA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matteo Fortini <matteo.fortini@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 07:07:28PM +0200, Matteo Fortini wrote:
> I'm using an ADAU1761 codec in a project, but we'd like, for now, to
> use it just as a mixer, i.e. without passing through the ADC/DAC and
> DSP stages.

> Which is the best way of accomplishing that?

Just plumb it into the system as normal, bypass paths should just work.
If there's no digital link at all (not even one that you're not using
right now) then it's an aux_dev.

> In the past I tried to add virtual DAPM routes in order to get the
> relevant power systems powered up, and bypassing the standby modes,
> since the device wouldn't let me use the mixer controls through I2C if
> I don't clock it.

This is a bug in the driver, the driver should be putting the chip in
cache only mode when it can't be written to.  If it's in _OFF and the
device needs clocks for I2C it's reasonable to expect that the driver
would assume they've gone away.
