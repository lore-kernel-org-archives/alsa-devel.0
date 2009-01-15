From: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/1] ALSA: ASoC: DaVinci: Fix SFFSDR init
	bug.
Date: Thu, 15 Jan 2009 15:41:08 -0600
Message-ID: <1232055668.3367.186.camel@linux-1lbu.site>
References: <20090108121613.1ef53112.hugo@hugovil.com>
	<1232051992-31817-1-git-send-email-hugo@hugovil.com>
	<20090115205748.GJ12768@sirena.org.uk>
	<20090115160257.f35c440d.hugo@hugovil.com>
	<20090115210908.GK12768@sirena.org.uk>
	<20090115161700.4d671c05.hugo@hugovil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090115161700.4d671c05.hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Hugo Villeneuve <hugo-rg2e/+w5TaNBDgjK7y7TUQ@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-01-15 at 16:17 -0500, Hugo Villeneuve wrote:
> On Thu, 15 Jan 2009 21:09:12 +0000
> Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> wrote:
>=20
> > On Thu, Jan 15, 2009 at 04:02:57PM -0500, Hugo Villeneuve wrote:
> > > On Thu, 15 Jan 2009 20:57:53 +0000
> > > Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> wrote:
> >=20
> > > > This should be replaced with the appropriate machine_is_() call
> > > > for the system.
> >=20
> > > It is the appropriate call, but at compile time it always return
> > > false.
> >=20
> > Sounds like that should be fixed instead, then?
>=20
> If someone wants to fix it, fine. I tried but couldn=C2=B4t find what i=
s
> wrong. Maybe the person who added that piece of code (not me) should
> fix it...

Just to verify the obvious, the u-boot is supplying the correct machine
type to the kernel right?

>=20
> Ciao, Hugo.
>=20
> ---------------
> Hugo Villeneuve
> www.hugovil.com
> ---------------
>=20
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
