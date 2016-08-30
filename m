From: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 2/2] Add mixer controls: Line-In, FM-In,
 Mic 2, Capture Source, Differential Line-In.
Date: Tue, 30 Aug 2016 08:49:40 +0200
Message-ID: <CAEKpxBn9AbxHQE03BVtR4NuF-KzqE_0-+nLGqcSyNrc=nbQgow@mail.gmail.com>
References: <20160829180321.11695-1-dannym@scratchpost.org> <20160829180321.11695-3-dannym@scratchpost.org>
Reply-To: codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCHNXO4F7MHBBCOZSS7AKGQEWBVMGDQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160829180321.11695-3-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 29 August 2016 at 20:03, Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
>
> Note: Mic1 Capture Volume is in a different register on A20 than on A10.
> Note: Mic2 Capture Volume is in a different register on A20 than on A10.
> ---
>  sound/soc/sunxi/sun4i-codec.c | 256 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 236 insertions(+), 20 deletions(-)
Hi Danny,
I think this should be delivered in a series of patches like what I've
attempted to do here
https://github.com/codekipper/linux-sunxi/commits/sunxi-wip?page=2
I haven't worked with my A20 for a while which is why I haven't
delivered these changes, however summer is coming to an end and should
be able to retest and deliver soon.
I can see that there is a difference like you've mentioned between the
A10 and A20 with the MIC pre-amps so approve of the use of a common
array.
Something also looks wrong with the whitespacing for sun4i_codec_codec.
BR,
CK
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
> For more options, visit https://groups.google.com/d/optout.
