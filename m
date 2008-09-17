From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 17:35:39 +0100
Message-ID: <20080917163537.GF7679@sirena.org.uk>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
	<48D11D0E.90701@endrelia.com> <48D120E8.4060504@atmel.com>
	<20080917153029.GD7679@sirena.org.uk> <48D130BD.3060005@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0786924686
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 18:35:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48D130BD.3060005@atmel.com>
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
Cc: alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>, Frank Mandarino <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 17, 2008 at 06:30:53PM +0200, Sedji Gaouaou wrote:
> Mark Brown a ?crit :

> > create a new directory called atmel or something.  The existing at91 and
> > avr32 code could then either be merged into that directory or changed to
> > reference it with any processor-specific glue that's needed.

> I am not plannig to produce a common audio driver. I just wanted to use 
> a common ssc driver. Anyway I will look at how can I change at91-ssc and 
> if it is doable.

That sounds like the case I'm talking about with common code in an atmel
directory and other, processor-specific, stuff in the at91 and avr32
directories - the idea was that if it was common code then it shouldn't
be in a processor-specific directory.
