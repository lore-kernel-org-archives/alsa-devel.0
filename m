From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
Date: Mon, 21 Mar 2016 14:24:39 +0000
Message-ID: <20160321142438.GU2566@sirena.org.uk>
References: <20151221123148.1ab6480b@dayas>
 <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather>
 <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather>
 <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
 <20160315105802.GN2566@sirena.org.uk>
 <20160319171336.6e16eb5a@scratchpost.org>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2+Swrz5l75R1PXkU"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBRUIYC3QKGQEGRIQY7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160319171336.6e16eb5a-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--2+Swrz5l75R1PXkU
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sat, Mar 19, 2016 at 05:13:36PM +0100, Danny Milosavljevic wrote:
> Hi Mark,

> my question is whether it's possible to group together the left and right channel into one selem, and also if it's possible to reuse volumes then. For example:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.  This is particularly important for large
walls of text like this.

> Is it possible to group them together like this? How?

This is something you'd need to change in alsamixer and the control
naming standards.  None of this stuff is really supposed to be directly
edited by normal users, they should mostly be using a UCM configuration,
so at the minute this is essentially bikeshedding.

> Is it possible to somehow distinguish those in alsamixer? Do we want to?

I think you're looking for something that exports routing to userspace.
Doing that would also help with reducing the faff with naming rules.
Currently nobody is working on that but I think people would be very
happy if someone were to work on it.
--2+Swrz5l75R1PXkU--
