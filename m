From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC PCM formats
Date: Mon, 9 Jun 2008 17:42:08 +0100
Message-ID: <20080609164207.GD17278@sirena.org.uk>
References: <9e4733910806061700r6650ded8j7c7680e4774d327d@mail.gmail.com>
	<20080609091742.GA17278@sirena.org.uk>
	<9e4733910806090608p3b7a182fgaf1ac51ee13b8b5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A16A7249D8
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jun 2008 18:42:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910806090608p3b7a182fgaf1ac51ee13b8b5c@mail.gmail.com>
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
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 09, 2008 at 09:08:18AM -0400, Jon Smirl wrote:

> Isn't the wm9712 an AC97 controller? on pxa..

It's an AC97 codec.

> codec dai = SNDRV_PCM_FMTBIT_S16  | SNDRV_PCM_FMTBIT_S24
> platform_dai = SNDRV_PCM_FMTBIT_S16_LE

I assume you mean the AC97 controller driver here?

> dma driver = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |
> SNDRV_PCM_FMTBIT_S32_LE,

> I tried copying this. It sends 16 bit sound through the system.

Right; since the AC97 controller driver only offers 16 bit it constrains
the other two.
