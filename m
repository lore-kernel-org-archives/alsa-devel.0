From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
Date: Tue, 15 Mar 2016 10:58:02 +0000
Message-ID: <20160315105802.GN2566@sirena.org.uk>
References: <20151221123148.1ab6480b@dayas>
 <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather>
 <20151228040649.475a742f@dayas>
 <20160106220908.GE9631@lukather>
 <20160109164832.515d69b0@dayas>
 <20160312085222.226d89bf@scratchpost.org>
 <20160314104939.GL8418@lukather>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sy9WyBOsCRoUO165"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBBGWT63QKGQEC32W7CY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160314104939.GL8418@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--sy9WyBOsCRoUO165
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Mar 14, 2016 at 11:49:39AM +0100, Maxime Ripard wrote:
> On Sat, Mar 12, 2016 at 08:52:22AM +0100, Danny Milosavljevic wrote:

> > > The other direction (making two controls which both do the same and update 
> > > each other's value) doesn't seem to be easily available. 

> > > Should I write a _put handler that does it manually?

> > > (Or should that be handled by alsa-lib mixer modules instead?)

> > > Is it possible to merge the "Left Mixer" control and respective 
> > > "Right Mixer" control into one selem in alsamixer?

> > > Because alsamixer actually has support for one-sided muting.

> Mark, do you know how to do it?

> IIRC, in order to have shared controls, you just needed to share the
> controls structure.

I'm having a really hard time telling what "it" is here.
--sy9WyBOsCRoUO165--
