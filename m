From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH]ASoC: Create a common directory for AVR32
	and ARM9	atmel boards.
Date: Fri, 3 Oct 2008 14:14:12 +0100
Message-ID: <20081003131411.GC26035@sirena.org.uk>
References: <48E47D42.8080306@atmel.com> <20081002150731.GH2848@sirena.org.uk>
	<48E4F025.80907@atmel.com> <20081002181211.GA3345@sirena.org.uk>
	<48E613BB.6090003@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 042B724720
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 15:14:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48E613BB.6090003@atmel.com>
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

On Fri, Oct 03, 2008 at 02:44:43PM +0200, Sedji Gaouaou wrote:

> > Ah, right.  While I understand that the hardware is pretty much identical
> > are you sure that the APIs for accessing it are the same on both AVR32
> > and AT91?  My understanding was that there was some work required to

> Actually I based my patch on the at32-pcm and at32-ssc files which were 
> based on at91-ssc and at91-pcm files, so I don't think there should be 
> any differences.

Right, they're based on each other but they use different APIs to access
the hardware - this is the most substantial difference between them.
Are you sure that the API you have chosen to use is availiable for both
architectures?  It's possible that it is but there's no mention of this
issue in your patch description and I'd like to confirm.
