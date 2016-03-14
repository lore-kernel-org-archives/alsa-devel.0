From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
Date: Mon, 14 Mar 2016 11:49:39 +0100
Message-ID: <20160314104939.GL8418@lukather>
References: <20151221123148.1ab6480b@dayas>
 <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather>
 <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather>
 <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k8YaXj956qNxBs/V"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBRNOTK3QKGQETVAIVEY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160312085222.226d89bf-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--k8YaXj956qNxBs/V
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Mar 12, 2016 at 08:52:22AM +0100, Danny Milosavljevic wrote:
> Hi,
> 
> does anyone know the answer to the questions below?
> 
> > The other direction (making two controls which both do the same and update 
> > each other's value) doesn't seem to be easily available. 
> 
> > Should I write a _put handler that does it manually?
> 
> > (Or should that be handled by alsa-lib mixer modules instead?)
> 
> > Is it possible to merge the "Left Mixer" control and respective 
> > "Right Mixer" control into one selem in alsamixer?
> > 
> > Because alsamixer actually has support for one-sided muting.

Mark, do you know how to do it?

IIRC, in order to have shared controls, you just needed to share the
controls structure.

> If that's unknown, I can post v9 without doing the grouping-together
> of mixer controls and we can use it like that - I don't want the
> patch to stall indefinitely on mere usability issues...

Unfortunately, that is exposed to the user-space. Once it's in, you
cannot change it / fix it anymore.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--k8YaXj956qNxBs/V--
