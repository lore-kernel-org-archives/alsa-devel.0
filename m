From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] asoc tlv320aic33: skip usage of PLL in
	some cases
Date: Fri, 18 Apr 2008 22:37:36 +0300
Message-ID: <bd7b27490804181237i7dfe0038hf9920ecaa4d28444@mail.gmail.com>
References: <20080417191245.GA17039@buzzloop.caiaq.de>
	<20080417192552.GC17039@buzzloop.caiaq.de>
	<bd7b27490804180059h67a481b0md6fb1a5648338513@mail.gmail.com>
	<20080418081315.GA23555@buzzloop.caiaq.de>
	<bd7b27490804180158j6607dbefyddbb48cbde51fc55@mail.gmail.com>
	<20080418093821.GA23651@buzzloop.caiaq.de>
	<bd7b27490804180347u30a3c456yed3438925d0fa4ae@mail.gmail.com>
	<20080418114113.GC23651@buzzloop.caiaq.de>
	<bd7b27490804180647n7c44da87l7a7d25080360f4f4@mail.gmail.com>
	<20080418140307.GA26197@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 9307224C36
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Apr 2008 21:37:37 +0200 (CEST)
Received: by hs-out-0708.google.com with SMTP id x43so493400hsb.0
	for <alsa-devel@alsa-project.org>; Fri, 18 Apr 2008 12:37:36 -0700 (PDT)
In-Reply-To: <20080418140307.GA26197@buzzloop.caiaq.de>
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
Cc: alsa-devel@alsa-project.org, vbarinov@ru.mvista.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 18, 2008 at 5:03 PM, Daniel Mack <daniel@caiaq.org> wrote:

> On Fri, Apr 18, 2008 at 04:47:16PM +0300, Jarkko Nikula wrote:
> > if (params_rate(params) =3D=3D aic3x->sysclk / (128 * pll_q))
>
> Hmm? Why do you think so? I'm afraid I don't get your point here.
>

I'm might be completely wrong here since I've used this codec only in
configuration where the interface rate or FSref equals to audio sampling
rate , but as far as I've interpreted the spec correctly we can have e.g.
the case where MCLK is 22.5792 MHz, FSref 44.1 kHz (i.e. PLL can be
disabled) but audio sampling rate is 11.025 kHz (=3D=3D params_rate(params)=
).

And I think here equation "Fsref =3D CLKDIV_IN / (128 =D7 Q)" Fsref refers =
to
44.1 or 48 kHz not the audio sampling rate?

But I don't want to speculate or do my own interpretation here. I'll ask
this from TI next week from my jarkko.nikula@nokia.com and can put you as a
cc as well.

Or do the driver author have any better knowledge here?


> > Probably you forgot to move bypass case in this version after writing
> the
> > AIC3X_SAMPLE_RATE_SEL_REG?
>
> No, actually not.
>


Your latest patch has:

+    if (bypass_pll)
+        return 0;
+
     /* codec sample rate select */
     data =3D aic3x_divs[i].sr_reg;
     data |=3D (data << 4);


>
> > Spec is also saying that when NDAC is 1.5, 2.5, ... 5.5, then odd values
> of
> > Q are not allowed.
>
> NDAC and NADC are both hard-coded to 0 (divider of 1) at the moment.
> Support for more flexible settings could be done in another step.
> Also, the PLL setup could be done by calculation of values rather
> that by a lookup table.


Again, I'm might be wrong but I NDAC and NADC refers to register
AIC3X_SAMPLE_RATE_SEL_REG which driver already takes into account properly.


> I'd like to see this patch applied now as base for further refinements.
> Do you agree?
>
>
I cannot prevent it to be applied, that's the driver author or maintainers
task to justify. I can only throw some discussion here if I see something to
be unclear (to me).

And don't take my comments as a nitpicking. Definitely patch like this is
worth to get in but we have to make sure that no possible bugs are
introduced. -EINVAL is much better alternative for some new configurations.


Jarkko
