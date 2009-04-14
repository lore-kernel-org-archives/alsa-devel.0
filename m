From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/2] ASoC: omap-mcbsp: Correct the
	DSP_B	mode
Date: Tue, 14 Apr 2009 10:31:33 +0100
Message-ID: <20090414093133.GB12678@sirena.org.uk>
References: <1239695131-30367-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239695131-30367-2-git-send-email-peter.ujfalusi@nokia.com>
	<20090414112016.c0dec32a.jarkko.nikula@nokia.com>
	<200904141140.17195.peter.ujfalusi@nokia.com>
	<20090414120221.f0e89499.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 775B61037EC
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 11:31:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090414120221.f0e89499.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 14, 2009 at 12:02:21PM +0300, Jarkko Nikula wrote:

> The pairs must mach. It's clearly a bug if another end is have to set
> different polarity than another. Those polarity defines are with
> respect to the mode, not e.g. what's the McBSP default.

Indeed.  However, the osk5912 board file that Peter pointed at as not
needing any modifications for DSP_B already uses inverted frame clock
for both CODEC and CPU.  In that case either both are wrong or it's just
that the driver is limited in what it supports which is not a problem.
