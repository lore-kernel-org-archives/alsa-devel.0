From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC v2 driver structure
Date: Tue, 29 Jan 2008 20:05:36 +0000
Message-ID: <20080129200526.GA30467@sirena.org.uk>
References: <9e4733910801270845i58b41269s708cb1ee58e7eba8@mail.gmail.com>
	<9e4733910801271115w576fcd61pec8a5586138744c5@mail.gmail.com>
	<1201525570.3551.47.camel@localhost.localdomain>
	<9e4733910801280803j4e3bf177xa65c8b5511946fce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BA1A1038AF
	for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2008 21:05:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e4733910801280803j4e3bf177xa65c8b5511946fce@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 28, 2008 at 11:03:06AM -0500, Jon Smirl wrote:

> Another problem is how the drivers for the i2s/ac97 channels get
> loaded. In the pxa270 the machine driver loads the i2s/ac97 driver and
> it is hooked to the asoc bus. But in the powerpc world drivers for
> these channels load via the device tree and they get hooked to the
> of_platform_bus. Some of these assumptions in how machines are created
> need to be changed to support these drivers on the of_platform_bus.

As discussed in the thread about Timur's patches this is something
that's going to be possible before v2 is submitted - it will be possible
to register all the components of an ASoC machine asynchronously with
the core taking responsibility for ensuring that everything is in place
before registering each machine as a card with ALSA.

This requirement is not unique to PowerPC - for example, more modern ARM
systems that use the platform bus more want it too (I've actually been
looking at this today for the modernised PXA support that's pending for
2.6.25).
