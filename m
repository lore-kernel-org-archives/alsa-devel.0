From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] soc-dai: add bitfields for
	hardware	I2S formats
Date: Thu, 5 Mar 2009 12:57:12 +0000
Message-ID: <20090305125711.GG2416@sirena.org.uk>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
	<1236197820-21022-2-git-send-email-daniel@caiaq.de>
	<20090304223057.GD10731@sirena.org.uk>
	<20090304231223.GB20915@buzzloop.caiaq.de>
	<20090305105357.GB2416@sirena.org.uk>
	<20090305113141.GC28878@buzzloop.caiaq.de>
	<20090305120335.GF2416@sirena.org.uk>
	<20090305125521.GB29699@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 393961037F2
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 13:57:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090305125521.GB29699@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 01:55:21PM +0100, Daniel Mack wrote:
> On Thu, Mar 05, 2009 at 12:03:35PM +0000, Mark Brown wrote:

> > That's why the clocking interface is generally used here - it's more
> > orthogonal.

> Hmm, how would you express 24 sample bits with 32 clocks per channel? I
> might not have gotten your point yet - could you provide an example?

You could add a "clock" which is the number of clocks per channel.  It
doesn't need to correspond to a literal clock in the hardware, it'd just
provide a way of setting this number.
