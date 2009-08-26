From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: at91sam9260-PCM1808/TAS5709-based
	board	driver
Date: Wed, 26 Aug 2009 12:44:58 +0100
Message-ID: <20090826114458.GA14905@sirena.org.uk>
References: <4A7DB844.3030303@fosstel.com>
	<9e4733910908090635j29db4ebn64f92c2176f3cb85@mail.gmail.com>
	<9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>
	<4A81BB75.3070405@fosstel.com>
	<20090811224132.GB4691@sirena.org.uk>
	<4A94200D.6080707@fosstel.com>
	<20090825182934.GA4317@sirena.org.uk>
	<4A943F86.5000601@fosstel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5000324604
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Aug 2009 13:44:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A943F86.5000601@fosstel.com>
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

On Tue, Aug 25, 2009 at 03:46:14PM -0400, Pedro I. Sanchez wrote:

> The big quest for me now is to figure out what "cmr_div" and "period" 
> have to be. They must be different for each sample rate. Any pointers 
> would be appreciated.

There should be a clocking diagram in the CPU manual which will show how
things are interrelated.  The period of a clock will be 1/rate - the
length of time taken for a clock cycle.
