From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL in
	some cases
Date: Fri, 18 Apr 2008 13:47:33 +0300
Message-ID: <bd7b27490804180347u30a3c456yed3438925d0fa4ae@mail.gmail.com>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 958E8245E0
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 12:47:41 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so136312ana.80
	for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2008 03:47:33 -0700 (PDT)
In-Reply-To: <20080418093821.GA23651@buzzloop.caiaq.de>
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

On Fri, Apr 18, 2008 at 12:38 PM, Daniel Mack <daniel@caiaq.org> wrote:

> On Fri, Apr 18, 2008 at 11:58:49AM +0300, Jarkko Nikula wrote:
> > Ok, now I see. Probably you should refer it as, at least in comment,
> 128*Q
> > instead of 256 eventhough the driver is not currently touching the Q
> value
> > in AIC3X_PLL_PROGA_REG.
>
> Well, the constraint for that condition is that MCLK = 256*WCLK, and the
> reason why that works for the chip without PLL is that Q=2. I stated
> that a little better in the attached patch.
>

I would rather refer there just "Fsref = CLKDIV_IN / (128*Q)" as the
condition where PLL can be disabled (or is mandatory where it must be
disabled?).

Referring to data sheet page 27 is not good as it's correct only for certain
version of AIC33 spec and driver supports other AIC3x chips as well :-)


> > >
> > Are you sure this is a general case?
>
> Well, the reset default is 0 (as stated on page 44) and set_hw_params()
> is the only location where this value is written. So if it's never
> written with a different value, it should always be set to its default,
> no?
>
>
I mean even if the I2S interface Fs meets the MCLK/256 condition, the audio
sample rate may be lower and it may be still required to set ADC and DAC
rates.


Jarkko
