From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: PATCH: mpc5200_psc_ac97 (was Re: AC97 on
	pcm030 board	with WM9712 codec)
Date: Wed, 22 Jul 2009 00:08:36 +0100
Message-ID: <20090721230836.GC3472@opensource.wolfsonmicro.com>
References: <1248132551.6532.267.camel@riker>
	<20090721090104.GA12667@rakim.wolfsonmicro.main>
	<1248207844.27542.16.camel@riker>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F7741038B5
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Jul 2009 01:08:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1248207844.27542.16.camel@riker>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Bonesio <bones@secretlab.ca>
Cc: Grant Likely <grant.likely@secretlab.ca>, alsa-devel@alsa-project.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 21, 2009 at 01:24:04PM -0700, John Bonesio wrote:

> Reset was failing with the original udelay(50) between the code in
> psc_ac97_cold_reset() and the call to psc_ac97_warm_reset(). Through testing
> it was found that a delay of 1ms was necessary for the cold_reset code to
> consistently complete successfully.

Applied, thanks.
