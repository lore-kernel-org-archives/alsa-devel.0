From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: Re: [PATCH 4/8] Input: twl6040-vibra: Check the selected path for vibra
Date: Fri, 16 Sep 2011 14:11:26 +0300
Message-ID: <329048288.4sixMZXl4l@barack>
References: <1316091561-30899-1-git-send-email-peter.ujfalusi@ti.com> <1316091561-30899-5-git-send-email-peter.ujfalusi@ti.com> <1316165201.3229.7.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1316165201.3229.7.camel@odin>
Sender: linux-input-owner@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: Samuel Ortiz <samuel.ortiz@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Misael Lopez Cruz <misael.lopez@ti.com>, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Friday 16 September 2011 10:26:41 Liam Girdwood wrote:
> > +	/* Do not allow effect, while the routing is set to use audio */
> > +	ret =3D twl6040_get_vibralr_status(info->twl6040);
> > +	if (ret & TWL6040_VIBSEL) {
> > +		dev_info(&input->dev, "Vibra is configured for audio\n");
> > +		return -EPERM;
> > +	}
>=20
> Sorry, missed this earlier.
>=20
> Probably best to return -EBUSY here otherwise it may look like a devi=
ce
> permissions problem to some users.

I'll change it.

Thanks,
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
