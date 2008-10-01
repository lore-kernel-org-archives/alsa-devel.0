From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: How to start with a driver for custom hardware?
Date: Wed, 1 Oct 2008 16:52:25 +0100
Message-ID: <20081001155221.GA15760@sirena.org.uk>
References: <20081001174336.b3mj2efijo8kcgwg@correo.alumnos.unican.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B9B0924415
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Oct 2008 17:52:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081001174336.b3mj2efijo8kcgwg@correo.alumnos.unican.es>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier.martinc@alumnos.unican.es
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 01, 2008 at 05:43:36PM +0200, javier.martinc@alumnos.unican.es wrote:

> The situation is the following:
> We are using a Cyclone II FPGA with a nommu NiosII processor and uClinux.
> We have an external TLV320AIC110 codec with I2C control interface and PCM audio
> interface.

> For example, should I used alsa or asoc? In my opinion, alsa documentation is
> more clear than asoc, but it is highlt oriented to pci drivers.

This sounds like a good fit for ASoC - you've got a system with separate
codec and interface/DMA drivers.

Most of the standard ALSA documentation also applies to ASoC, especially
for platform drivers which essentially just get passed through the
standard ALSA operations.  The vast majority of the ASoC specific stuff
is in the codec drivers.  If you have questions then hopefully people
here can help out.

> As you can see it is a simple hardware which control registers are mapped into
> memory. Which part of the alsa driver takes care of accesing these hardware
> dependent registers?

If it were done using ASoC then you'd write ASoC platform drivers
which would do this.
