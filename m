From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: Re: [PATCH 1/4] AC97 wm9713 support
Date: Thu, 10 Mar 2005 14:13:12 +0000
Message-ID: <1110463992.19036.106.camel@cearnarfon>
References: <1109341397.30473.671.camel@cearnarfon>
	 <s5hbr9rwwst.wl@alsa2.suse.de>  <s5hacpbws14.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <s5hacpbws14.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-10 at 13:26, Takashi Iwai wrote:

>=20
> The attached is the changed patch:
>=20
> - only snd_ac97_*_enum_double(), no single callbacks
> - change the definition of AC97_* macro:
>   AC97_ENUM_DOUBLE() and AC97_ENUM_SINGLE() defines the enum struct
>   for double and single channels.
>   AC97_ENUM() defines the control struct.
>   (IMO, this is more straightforward.)
> - WM-specific flags are set in the patch.  Only AC97_DEFAULT_POWER_OFF
>   is set in ac97_codec.c, which has to be known before the patch.
> - fix compilation warnings.
>=20
>=20
> Liam, could you check whether it's OK?
>=20

Works perfectly=C2=B7

Thanks

Liam



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
