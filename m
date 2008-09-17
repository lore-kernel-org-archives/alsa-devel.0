From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 18:30:53 +0200
Message-ID: <48D130BD.3060005@atmel.com>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
	<48D11D0E.90701@endrelia.com> <48D120E8.4060504@atmel.com>
	<20080917153029.GD7679@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id EB2A124683
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 18:31:03 +0200 (CEST)
In-Reply-To: <20080917153029.GD7679@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>, Frank Mandarino <fmandarino@endrelia.com>, alsa-devel@alsa-project.org, Geoffrey Wossum <geoffrey@pager.net>
List-Id: alsa-devel@alsa-project.org

Mark Brown a =E9crit :
> If your intention is to produce a combined driver which works for both
> AVR32 and AT91 (which would be excellent!) then it'd probably best to
> create a new directory called atmel or something.  The existing at91 and
> avr32 code could then either be merged into that directory or changed to
> reference it with any processor-specific glue that's needed.
> =

I am not plannig to produce a common audio driver. I just wanted to use =

a common ssc driver. Anyway I will look at how can I change at91-ssc and =

if it is doable.

Cheers,
Sedji
