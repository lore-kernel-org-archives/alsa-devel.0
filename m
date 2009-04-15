From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 05/14] ASoC: Provide core support
	for	symmetric sample rates
Date: Wed, 15 Apr 2009 09:29:04 +0100
Message-ID: <20090415082904.GB29399@sirena.org.uk>
References: <20090414123220.GA6342@rakim.wolfsonmicro.main>
	<1239712393-6428-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<200904150931.47272.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D3F0243DD
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 10:29:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904150931.47272.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 15, 2009 at 09:31:46AM +0300, Peter Ujfalusi wrote:
> On Tuesday 14 April 2009 15:33:04 ext Mark Brown wrote:

> > Many devices require symmetric configurations of capture and playback
> > data formats, often due to shared clocking but sometimes also due to

> Would it make sense to add also the channel count and probably sample_bits as 
> constraint as well here?
> I think the symmetric means that you should not be able to change any of the 
> parameters.

Yes, we should have something for those but they are a bit more complex:
normally with bit clock the restriction is actually that you need to
have at least as many clocks as the format needs but can have more.
This means that rather than an absolute symmetry requirement you end up
setting a reduced maximum for both directions.

The two limits play into each other with DSP mode too: you can have
twice as many channels in the same number of bit clocks if you halve the
sameple size.  For I2S style modes the channel count doesn't tend to be
restricted since you always have the clocks for two channels even if
you're only looking at one.
