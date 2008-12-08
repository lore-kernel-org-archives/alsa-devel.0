From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC: hook for codec control updates and clock
	controls
Date: Mon, 8 Dec 2008 11:59:01 +0000
Message-ID: <20081208115900.GA8996@sirena.org.uk>
References: <20081207173825.GB26551@buzzloop.caiaq.de>
	<20081207190239.GA4457@sirena.org.uk>
	<20081208000450.GA30181@buzzloop.caiaq.de>
	<bd7b27490812080149m6de590cn176a317cf49bf4b3@mail.gmail.com>
	<20081208111138.GB5159@sirena.org.uk>
	<bd7b27490812080340h166962d1gca1c103f7148f1ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 08DFF103830
	for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2008 12:59:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <bd7b27490812080340h166962d1gca1c103f7148f1ad@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 08, 2008 at 01:40:28PM +0200, Jarkko Nikula wrote:
> On Mon, Dec 8, 2008 at 1:11 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > TBH I don't really see any benefit from doing this in the codec driver
> > to doing it in the core.

> Agree. Also other codecs might use mclk for their internal state machine.
> IRCC, TSC2301 had some weird internal states and timeouts when mclk was
> required to be on and when it can be shutdown.

It's fairly common, but most devices either only really need the clock
when they've got active paths or aren't supposed to have the clock
removed at all so I'm not sure we need a specific mechanism for this.
