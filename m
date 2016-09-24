From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] ASoC: rk3399_gru_sound: fix recording pop at first
 attempt
Date: Sat, 24 Sep 2016 19:10:42 +0100
Message-ID: <20160924181042.7odqqbae2sixdeyx@sirena.org.uk>
References: <1474552206-31742-1-git-send-email-zhengxing@rock-chips.com>
 <20160923212737.GA17658@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2831427539561862994=="
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20160923212737.GA17658@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, cychiang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dianders-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, hychao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============2831427539561862994==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="74ywsfvevlsgndw7"
Content-Disposition: inline


--74ywsfvevlsgndw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2016 at 04:27:37PM -0500, Rob Herring wrote:
> On Thu, Sep 22, 2016 at 09:50:06PM +0800, Xing Zheng wrote:
> > From: Wonjoon Lee <woojoo.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

> > Pop happens when mclk applied but dmic's own boot-time

> This statement doesn't make sense.

It is very clear if you're familiar with the problem domain - because a
DMIC is digital it's got an on/off state which means that when it
transitions from off and not outputting anything to outputting something
you get a sudden DC transition which manifests as a pop in the audio
output.

> > Specify dmic delay times in dt to make sure
> > clocks are ready earlier than dmic working

> I don't think this really belongs in DT. Seems like better control of=20
> the init order is needed. Or why not just a fixed delay in the driver?

The changelog says this is due to the DMICs having a startup time of
their own so needing a delay after they've started.  That's going to be
a system dependent thing since it'll depend on the specific component
selected and DMICs are easily interchangable.

--74ywsfvevlsgndw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX5sGhAAoJECTWi3JdVIfQb3EH/03yJ0kjMHCIoNGPcdCfEnNc
WgzImLpEQpNfLf5iN7h+n0N0z1RGsgPiss8hj33TYRqqBXsgvJvRx2X5g0DtuVwn
TKxGmnQTqiwCZCk5RdT3sNu+PgYxIX8L3Vg/03+2rYfbc5Ua+77MeKM4mcxOGl9+
Qt7WhxZo/oMjVoyh5V+GjZScDvdFPQsvQabJ417MkOwfm506OlsuQ/VhJWA1TocG
8PAvloEpR/ZWifYByE0pFSM6ZRlJB85ftTyV8Qxy4opCNg+QS/ik/QlKmZAx9eXw
nDQmhMYjaYYF6Dmz6nzztGOgViM3SQ9tPXIWbeI8lnD4T1UoAKi1p9ucgqutvBI=
=oOfW
-----END PGP SIGNATURE-----

--74ywsfvevlsgndw7--


--===============2831427539561862994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============2831427539561862994==--
