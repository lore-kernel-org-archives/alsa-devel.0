From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 06/34] don't use __devexit_p to wrap hal2_remove
Date: Fri, 2 Oct 2009 11:20:25 +0200
Message-ID: <20091002092025.GB4442@pengutronix.de>
References: <20091001082607.GA2181@pengutronix.de> <1254385718-14254-6-git-send-email-u.kleine-koenig@pengutronix.de> <s5hy6nvik7o.wl%tiwai@suse.de> <20091001085355.GD2181@pengutronix.de> <s5hzl8agocf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757389AbZJBJUb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hzl8agocf.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello,

On Fri, Oct 02, 2009 at 11:02:56AM +0200, Takashi Iwai wrote:
> At Thu, 1 Oct 2009 10:53:55 +0200,
> Uwe Kleine-K=F6nig wrote:
> >=20
> > On Thu, Oct 01, 2009 at 10:36:59AM +0200, Takashi Iwai wrote:
> > > At Thu,  1 Oct 2009 10:28:10 +0200,
> > > Uwe Kleine-K=F6nig wrote:
> > > >=20
> > > > The function hal2_remove is defined using __exit, so don't use =
__devexit_p
> > > > but __exit_p to wrap it.
> > >=20
> > > I think it's the other way round.  We should replace __exit with =
__devexit.
> > > Ditto for sound/mips/sgio2audio.c.
> > Actually both ways are possible.  I choosed the alternative that do=
esn't
> > add bloat to the kernel.  The cost is that the device isn't hotplug=
able,
> > but you can still unload the module to unbind the driver.
>=20
> Hm, is it really safe to set remove=3DNULL although the driver needs
> some work at unbinding?  It looks like that unbind is allowed no
> matter whether remove is NULL or not.  So, it would jus keeps stray
> resources, and it might conflict at the next bind.
I just tried that and you're right.  IMHO that's a bug.  Greg?

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
