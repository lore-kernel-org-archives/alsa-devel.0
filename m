From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 06/34] don't use __devexit_p to wrap hal2_remove
Date: Thu, 1 Oct 2009 10:53:55 +0200
Message-ID: <20091001085355.GD2181@pengutronix.de>
References: <20091001082607.GA2181@pengutronix.de> <1254385718-14254-6-git-send-email-u.kleine-koenig@pengutronix.de> <s5hy6nvik7o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755134AbZJAIx4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hy6nvik7o.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@linux-foundation.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 10:36:59AM +0200, Takashi Iwai wrote:
> At Thu,  1 Oct 2009 10:28:10 +0200,
> Uwe Kleine-K=F6nig wrote:
> >=20
> > The function hal2_remove is defined using __exit, so don't use __de=
vexit_p
> > but __exit_p to wrap it.
>=20
> I think it's the other way round.  We should replace __exit with __de=
vexit.
> Ditto for sound/mips/sgio2audio.c.
Actually both ways are possible.  I choosed the alternative that doesn'=
t
add bloat to the kernel.  The cost is that the device isn't hotplugable=
,
but you can still unload the module to unbind the driver.

I don't care much, but prefer slightly my approach as changing the patc=
h
is work for me :-)

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
