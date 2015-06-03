From: Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [alsa-devel] [PATCH 5/7] ASoC: wm5100: remove bitwise operations
 involving GPIO level value
Date: Wed, 03 Jun 2015 22:13:19 +0300
Message-ID: <556F51CF.1000807@mleia.com>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>	<1433200158-6890-5-git-send-email-vz@mleia.com>	<20150602194558.GI14071@sirena.org.uk>	<556E10CD.3090301@mleia.com> <CA+7tXijtaM4tn3Mb+tbsd7JFbGjeh1yT=zTXPuCiFjqnvRjdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CA+7tXijtaM4tn3Mb+tbsd7JFbGjeh1yT=zTXPuCiFjqnvRjdvg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Trent Piepho <tpiepho@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, Takashi Iwai <tiwai@suse.de>, Linus Walleij <linus.walleij@linaro.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, linux-gpio@vger.kernel.org, Alexandre Courbot <acourbot@nvidia.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark, Trent,

thank you for review.

On 03.06.2015 13:50, Trent Piepho wrote:
> On Tue, Jun 2, 2015 at 1:23 PM, Vladimir Zapolskiy <vz@mleia.com
> <mailto:vz@mleia.com>> wrote:
> 
>     Hello Mark,
> 
>     On 02.06.2015 22:45, Mark Brown wrote:
>     > On Tue, Jun 02, 2015 at 02:09:16AM +0300, Vladimir Zapolskiy wrote:
>     >
>     >> @@ -2244,26 +2244,27 @@ static inline struct wm5100_priv
>     *gpio_to_wm5100(struct gpio_chip *chip)
>     >>  static void wm5100_gpio_set(struct gpio_chip *chip, unsigned
>     offset, int value)
>     >>  {
>     >>      struct wm5100_priv *wm5100 = gpio_to_wm5100(chip);
>     >> +    unsigned int val = 0;
>     >> +
>     >> +    if (value)
>     >> +            val = 0x1 << WM5100_GP1_LVL_SHIFT;
>     >
>     > Write this as an if/else so the reader doesn't have to wonder why
>     you've
>     > missed the handling of the false case.
>     >
> 
>     the only objection I have is that the resulting code will be two lines
>     longer. If you think this code is not clear enough (is "val" vs. "value"
>     misleading?), I'll change the rest of my patches, which contain the same
>     logic structure, please let me know.
> 
> 
> const unsigned int val = value ?  (0x1 << WM5100_GP1_LVL_SHIFT) : 0;
> 
> Two lines shorter....
> 
> Have you measured the effect of going from int to bool on code size and
> speed?  Clearly, the C code is getting longer as '!!' is transformed
> into an if-then-else to set a new scratch variable.  But the compiler
> likely converts both to a conditional branch or cmov type instruction. 
> What I wonder is if converting gpiolib to use bools instead of ints is
> better just because someone likes it more that way or if there are
> objective metrics that show improvement.
> 
> BTW, with a little C algebra:
> const unsigned int val = value ?  0x1 << WM5100_GP1_LVL_SHIFT : 0;
> const unsigned int val = (value ?  0x1 : 0) << WM5100_GP1_LVL_SHIFT;
> const unsigned int val = (!!value) << WM5100_GP1_LVL_SHIFT;  //
> definition of ! operator
> 
> And now we're back to where we started, so I don't really see why this
> is even necessary.  The semantics of the ! operator will be changed in a
> future C version?

I don't think it makes sense to discuss technical aspects of the
proposed change, as I mentioned in the discussion yesterday I see no
technical issues at this point, and my changes are described as
nonfunctional.

The _nontechnical_ problem I see (well, may be I'm just blowing it up)
is a Linux kernel code style policy problem, to my knowledge the policy
of using bitwise and arithmetic operations on bool type variables and
constants is not defined, and since the policy is not yet defined I'm
glad to take part in its discussion now.

As an example of one related policy is change of 0/1 constants to
false/true, when they are attended by bool type, see c2b49ae678b ,
5c216cc3f37 , 7eef08554ca , bool{init,return}.cocci etc.

One may say that the changes above has no value (however it might be
related to ABI treatment of _Bool/bool), personally I agree with this
accepted code policy.

Another code policy question is to which degree arithmetic and bitwise
operations on bool variables and constants are acceptable. In my
personal opinion arithmetic and bitwise operations on bool variables are
quite undesired, that's why I attempt to replace them in advance in some
sound/soc/codecs/* functions before changing the type of input variable
representing GPIO level from int to bool. I guess in your personal
opinion this proposed change has no technical sense, I respect your
opinion and do not insist on my answer to the policy.

My little deal is to let you know that there is another opinion on the
subject and send you the changes for review and ack/nak verdict.

--
With best wishes,
Vladimir
