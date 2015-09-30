From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] ASoC: Add support for the Allwinner A10 codec
Date: Wed, 30 Sep 2015 18:33:34 +0100
Message-ID: <20150930173334.GH15635@sirena.org.uk>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442928417.6509.12.camel@plaes.org>
 <20150928074248.GI7104@lukather>
 <560AFF14.80400@redhat.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBBF2WCYAKGQEMEHF45Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <560AFF14.80400-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Sep 29, 2015 at 11:13:56PM +0200, Hans de Goede wrote:

> On both A10 and A20 I need to enable to following for things to work:

> unmute Pre-Amplifier DAC
> unmute Pre-Amplifier Mute

> I guess this is just a question if adding some mixer defaults to
> the alsa userspace somewhere ?

Yes, you're looking for something in /usr/share/alsa/cards here (shipped
in alsa-lib).
--bO4vSxwwZtUjUWHo--
