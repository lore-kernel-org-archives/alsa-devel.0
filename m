From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL
	in	some cases
Date: Sat, 19 Apr 2008 02:50:53 +0200
Message-ID: <20080419005053.GB29770@buzzloop.caiaq.de>
References: <20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
	<bd7b27490804180347u30a3c456yed3438925d0fa4ae@mail.gmail.com>
	<20080418114113.GC23651@buzzloop.caiaq.de>
	<bd7b27490804180647n7c44da87l7a7d25080360f4f4@mail.gmail.com>
	<20080418140307.GA26197@buzzloop.caiaq.de>
	<bd7b27490804181237i7dfe0038hf9920ecaa4d28444@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D40FE24C74
	for <alsa-devel@alsa-project.org>;
	Sat, 19 Apr 2008 02:51:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <bd7b27490804181237i7dfe0038hf9920ecaa4d28444@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, vbarinov@ru.mvista.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 10:37:36PM +0300, Jarkko Nikula wrote:
> I'm might be completely wrong here since I've used this codec only in
> configuration where the interface rate or FSref equals to audio sampling
> rate , but as far as I've interpreted the spec correctly we can have e.g.
> the case where MCLK is 22.5792 MHz, FSref 44.1 kHz (i.e. PLL can be
> disabled) but audio sampling rate is 11.025 kHz (== params_rate(params)).

Of course. Fsref is a setting for the filter to tell it which internal
base-frequency it is operating on. But the setup of the sampling
frequency has different meaning. Also, the clocking diagram (page 27 in
the aic33 manual) doesn't even show that entity, or did I miss anything
after staring at this for some days? ;)

> But I don't want to speculate or do my own interpretation here. I'll ask
> this from TI next week from my jarkko.nikula@nokia.com and can put you as a
> cc as well.

Ok, thanks :)

> Your latest patch has:
> 
> +    if (bypass_pll)
> +        return 0;
> +

Yes, since all other setup can be skipped in case the PLL is bypassed.
Did you miss the question here? ;)

> Again, I'm might be wrong but I NDAC and NADC refers to register
> AIC3X_SAMPLE_RATE_SEL_REG which driver already takes into account properly.

Only in case the PLL is enabled. I agree that there could be some more
setup around all the possible settings in this clock generation, but I'd
my approach as a good first start.

> And don't take my comments as a nitpicking. Definitely patch like this is
> worth to get in but we have to make sure that no possible bugs are
> introduced. -EINVAL is much better alternative for some new configurations.

No, I don't take it as nitpicking :) I agree that a driver for such a
complex chip has to be modified with care to have any regression. But I
don't see such as far, so I'd take this patch as a step towards a better
solution. Unless someone comes up claiming that it's breaking anything.

Thanks and best rgeards,
Daniel
