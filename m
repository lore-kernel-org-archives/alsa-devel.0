From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
	and ARM9 atmel boards.
Date: Fri, 3 Oct 2008 15:35:24 +0100
Message-ID: <20081003143523.GE26035@sirena.org.uk>
References: <48E47D42.8080306@atmel.com> <20081002150731.GH2848@sirena.org.uk>
	<48E4F025.80907@atmel.com> <20081002181211.GA3345@sirena.org.uk>
	<48E613BB.6090003@atmel.com> <20081003131411.GC26035@sirena.org.uk>
	<48E62A89.8070803@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A026A24747
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 16:35:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E62A89.8070803@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 03, 2008 at 04:22:01PM +0200, Sedji Gaouaou wrote:

> If you are talking about the API to access ssc(ssc_writel and 
> ssc_readl), it was basically why I needed a new driver in the first 
> place. Indeed we wanted to use the same API across all atmel platforms.

OK, that's good.  It'd be helpful if you could mention this in your
patch descriptions - at the minute there's very little detail there
which makes issues like this less clear than they could be.

I'd still like to see this tested at least somewhat on AVR32, just to
make sure.  Even a build test would be good.
