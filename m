From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: [PATCH v9 2/2] Add mixer controls: Line-In, FM-In,
 Mic 2, Capture Source, Differential Line-In.
Date: Tue, 30 Aug 2016 20:10:25 +0200
Message-ID: <20160830201025.506b30ae@scratchpost.org>
References: <20160829180321.11695-1-dannym@scratchpost.org>
	<20160829180321.11695-3-dannym@scratchpost.org>
	<CAEKpxBn9AbxHQE03BVtR4NuF-KzqE_0-+nLGqcSyNrc=nbQgow@mail.gmail.com>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBGEYS67AKGQEWZBCDJY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAEKpxBn9AbxHQE03BVtR4NuF-KzqE_0-+nLGqcSyNrc=nbQgow-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi CK,

On Tue, 30 Aug 2016 08:49:40 +0200
Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 29 August 2016 at 20:03, Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
> I think this should be delivered in a series of patches like what I've
> attempted to do here
> https://github.com/codekipper/linux-sunxi/commits/sunxi-wip?page=2

Feel free to do it. But I've gotten questions from users why they have to
apply my patch manually again and again, so let's get this done one way
or another.

> I haven't worked with my A20 for a while which is why I haven't
> delivered these changes, however summer is coming to an end and should
> be able to retest and deliver soon.

Good :)

Please check whether you use the same routes and registers in your
version - my patch has been in use by multiple people for months
so I'm quite positive that it works, whatever cosmetic issues there may be.

Especially pay attention to Line Playback Volume - it has two possible values.

0 means -1.5 dB and 1 means 0 dB. Many userspace tools seem to be confused
about it not being a boolean and alsa-lib also did stupid stuff with it
depending on the name. So make sure that it does work.

Also if someone tests my patch, please also test this.

(It has been notoriously difficult to reproduce this problem reliably
 in the past with different people's setups)

> I can see that there is a difference like you've mentioned between the
> A10 and A20 with the MIC pre-amps so approve of the use of a common
> array.

Yeah, it's necessary.

> Something also looks wrong with the whitespacing for sun4i_codec_codec.

Depends on your tab width - the committed version used Tab characters in
order to line up the equals signs. So it was really just luck how it looked.

That means that depending on the tab width it did either line up or not
(it didn't line up for me).

Now it's using spaces around the equal sign and so it shows up
the same for everyone - lined up. I fixed this because I touched the line
anyway.
