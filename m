From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL in
	some cases
Date: Fri, 18 Apr 2008 16:47:16 +0300
Message-ID: <bd7b27490804180647n7c44da87l7a7d25080360f4f4@mail.gmail.com>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
	<bd7b27490804180347u30a3c456yed3438925d0fa4ae@mail.gmail.com>
	<20080418114113.GC23651@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by alsa0.perex.cz (Postfix) with ESMTP id DCFC524B9E
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 15:47:23 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so150970ana.80
	for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2008 06:47:16 -0700 (PDT)
In-Reply-To: <20080418114113.GC23651@buzzloop.caiaq.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 2:41 PM, Daniel Mack <daniel@caiaq.org> wrote:

>
> Ok, I agree. I changed that to find an appropriate value for Q
> programmatically. Have a look at the attached patch, please. I hope i
> finally got it now ;)


That sounds a good idea. Then more cases will be covered.

What I noticed that instead of params_rate, I think we should compare here
the FSref of 44.1 and 48 kHz (how about dual-rate mode?) when defining can
the PLL be bypassed

if (params_rate(params) == aic3x->sysclk / (128 * pll_q))

---

Probably you forgot to move bypass case in this version after writing the
AIC3X_SAMPLE_RATE_SEL_REG?

Spec is also saying that when NDAC is 1.5, 2.5, ... 5.5, then odd values of
Q are not allowed.

Not the easiest chip... probably worth to ask from TI what's the case e.g.
when FSref is 2*48 kHz and ADC/DAC rate is 64 kHz (NDAC is 1.5).

And of course, over-designing the driver is not the purpose and probably
some special cases can be now covered just with -EINVAL and let the user who
needs them to send a patch :-)


Jarkko
