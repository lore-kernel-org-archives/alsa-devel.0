From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: at91sam9260-PCM1808/TAS5709-based
	board	driver
Date: Fri, 28 Aug 2009 13:15:15 +0100
Message-ID: <20090828121514.GA13478@sirena.org.uk>
References: <4A7DB844.3030303@fosstel.com>
	<9e4733910908090635j29db4ebn64f92c2176f3cb85@mail.gmail.com>
	<9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>
	<4A81BB75.3070405@fosstel.com>
	<20090811224132.GB4691@sirena.org.uk>
	<4A94200D.6080707@fosstel.com>
	<20090825182934.GA4317@sirena.org.uk>
	<4A943F86.5000601@fosstel.com>
	<20090826114458.GA14905@sirena.org.uk>
	<47184.207.35.173.122.1251400309.squirrel@mail.colcan.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BDFDA24646
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Aug 2009 14:15:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <47184.207.35.173.122.1251400309.squirrel@mail.colcan.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pedro I. Sanchez" <psanchez@fosstel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[Please note that the standard  thing on Linux mailing lists is to do a
reply to all.]

On Thu, Aug 27, 2009 at 03:11:49PM -0400, Pedro I. Sanchez wrote:

> question. Why is it that if I play a 24-bit encoded play the hw_params()
> function in my driver is called with SNDRV_PCM_FORMAT_S16_LE format? Does
> ALSA makes an on-the-fly conversion?

Yes, ALSA can do on the fly format translations if required to play
things.  This normally happens because the input format is not supported
by the drivers.  Telling the application to use the hardware device
directly will bypass this conversion.
