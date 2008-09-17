From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA:AT91SAM9G20: Add support(DAI) for wolfson8731
Date: Wed, 17 Sep 2008 16:30:33 +0100
Message-ID: <20080917153029.GD7679@sirena.org.uk>
References: <48D0D30D.7070807@atmel.com> <20080917110530.GA7679@sirena.org.uk>
	<48D11D0E.90701@endrelia.com> <48D120E8.4060504@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C9F9024629
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Sep 2008 17:30:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48D120E8.4060504@atmel.com>
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

On Wed, Sep 17, 2008 at 05:23:20PM +0200, Sedji Gaouaou wrote:

> I agree with you as well. I wanted to use the drivers/misc/atmel-ssc in 
> the dai because it is a common arch between atmel ARM and AVR core.
> I will have a look at the at91-ssc code and at the eti_b1_wm8731.c file 
> to see what changes should be done.

If your intention is to produce a combined driver which works for both
AVR32 and AT91 (which would be excellent!) then it'd probably best to
create a new directory called atmel or something.  The existing at91 and
avr32 code could then either be merged into that directory or changed to
reference it with any processor-specific glue that's needed.

Also CCing Geoffrey Wossum who did the AVR32 code (based on the AT91
work Frank did).

> I removed resume/suspend because I didn't have the time to write it...
> I wanted to add it in a next patch, but maybe I shoul do it now.

Either was is OK.
