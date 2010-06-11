From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ALSA: usb-audio: parse UAC2
	sample	rate ranges correctly
Date: Fri, 11 Jun 2010 16:18:20 +0100
Message-ID: <20100611151820.GH12436@sirena.org.uk>
References: <1276263191-8652-1-git-send-email-daniel@caiaq.de>
	<1276263191-8652-4-git-send-email-daniel@caiaq.de>
	<AANLkTin3LMCu_f2emsh6kAT8H6G3zKF8Ud-ZUMpZjbmg@mail.gmail.com>
	<20100611150435.GS2698@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A13BF244E1
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jun 2010 17:18:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100611150435.GS2698@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: Alex Lee <alexlee188@gmail.com>, tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 11, 2010 at 05:04:35PM +0200, Daniel Mack wrote:
> On Fri, Jun 11, 2010 at 10:59:44PM +0800, Alex Lee wrote:
> > If the device has a variable clock, it may report a RES of only 1.  So you
> > may end up with thousands (and even millions) of sample rates.  It might be
> > better to have separate code to cater to discrete clocks vs variable clocks.

> AFAIK, ALSA cannot cope with that yet. Am I right?

There's _CONTINUOUS and _KNOT.
