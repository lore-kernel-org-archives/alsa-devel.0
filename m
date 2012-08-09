From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] ALSA: hda - Defer probe when loading patch
	firmware
Date: Thu, 9 Aug 2012 10:07:13 +0200
Message-ID: <20120809080713.GC24808@avionic-0098.mockup.avionic-design.de>
References: <1344494723-6827-1-git-send-email-thierry.reding@avionic-design.de>
 <s5hhascft86.wl%tiwai@suse.de>
 <20120809070813.GA6979@avionic-0098.mockup.avionic-design.de>
 <s5hd330frn1.wl%tiwai@suse.de>
 <20120809073642.GA24695@avionic-0098.mockup.avionic-design.de>
 <s5h7gt8fr47.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7432620049052141534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 89189266147
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 09:37:30 +0200 (CEST)
In-Reply-To: <s5h7gt8fr47.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org


--===============7432620049052141534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2012 at 09:42:48AM +0200, Takashi Iwai wrote:
> At Thu, 9 Aug 2012 09:36:42 +0200,
> Thierry Reding wrote:
> >=20
> > On Thu, Aug 09, 2012 at 09:31:30AM +0200, Takashi Iwai wrote:
> > > At Thu, 9 Aug 2012 09:08:13 +0200,
> > > Thierry Reding wrote:
> > > >=20
> > > > On Thu, Aug 09, 2012 at 08:57:13AM +0200, Takashi Iwai wrote:
> > > > > At Thu,  9 Aug 2012 08:45:23 +0200,
> > > > > Thierry Reding wrote:
> > > > > >=20
> > > > > > Recent changes to the firmware loading helpers cause drivers to=
 stall
> > > > > > when firmware is loaded during the module_init() call. The snd-=
hda-intel
> > > > > > module requests firmware if the patch=3D parameter is used to l=
oad a patch
> > > > > > file. This patch works around the problem by deferring the prob=
e in such
> > > > > > cases, which will cause the module to load successfully and the=
 driver
> > > > > > binding to the device outside the module_init() call.
> > > > >=20
> > > > > Is the "recent" change meant 3.6 kernel, or in linux-next?
> > > > >=20
> > > > > In anyway, I don't understand why such a change was allowed.  Most
> > > > > drivers do call request_firmware() at the device probing time.
> > > > > If this really has to be resolved in the driver side, it must be =
a bug
> > > > > in the firmware loader core code.
> > > >=20
> > > > A good explanation of the problem and subsequent discussion can be =
found
> > > > here:
> > > >=20
> > > > 	http://article.gmane.org/gmane.linux.drivers.video-input-infrastru=
cture/49975
> > >=20
> > > Yeah, but it doesn't justify this ugly module option.
> > > It's a simple bug.  Papering over it with this option doesn't fix
> > > anything.
> >=20
> > It's not an option, all it does is defer probing if and only if the
> > patch parameter was specified to make sure the firmware load won't
> > stall. I realize that this may not be an optimal solution, but at least
> > it fixes the problem with no fallout.
>=20
> Ah sorry, I misread the patch.
>=20
> Then it shouldn't be checked at that point.  Since 3.5 kernel, the
> probing code was already split for vga_switcheroo support.

Yes, I saw that. But unless you actually use vga_switcheroo, the second
stage, azx_probe_continue(), will still be called from azx_probe() and
therefore ultimately from module_init().

Before coming up with this patch I actually did play around a bit with
using the asynchronous firmware load functions but it turned out to be
rather difficult to do so I opted for the easy way. The biggest problem
I faced was that since patch loading needs to be done very early on, a
lot of the initialization would need to be done after .probe() and many
things could still fail, so cleaning up after errors would become
increasingly difficult.

> The point you added is the second stage.

I don't understand this sentence.

Thierry

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQI2+xAAoJEN0jrNd/PrOhG0wQAK7trGSUmaPTd5R5TcSi7Vf0
khWVDAFYenheo3ZUqb4mdPZMA8VoaL0o/DZ+tRi7rj8lxYGR3XO53WmXp5RMWx0b
+UHr33K1sJvtJWypfuejt2qqxhWlU9dqEGdcV2ZAhM9ImEkWftEAjG9BK8ooJi0Q
GCGe4ijYFkybaSmI9QJ6ktVVt99f+cMy9j9+lJN3PuixcVpt6HEV1msgKAP4gg78
x6vduw4/D9r68kQxi3VKQY9eMRr2B+x3m/7ZDddT9MmHG1DMjYr0Uv0VGQjAYlJ9
xP+ynkzDyd6LeirQ1lTbCRjuSK7Wqfd6SCqWff2mFDOfS262rbO4ZpLCxyXlYGqn
ZE2bzyyFHQApWkpBJmcw5lhZt1/4GsbGt9WnW4BLot2pmOk61eHv+It2AGLln8iq
SlFXoVK2NrjDiFmgU9atzjz9iAzM1knjCq2RH+uqVyETukgPPrl8i3VgYMRc4DLt
ntPPgPl3W7Mcd1VcvaZDhppnrlKd8Pb1ObKHNlsGK7Qjwk0WeeWlE+ODqf9kX4xT
+bvsffUpX72vhvJeQ36OWTER4YFH3xOzbUcy4wItfJ6/sSaFNxD0f9QfOUdZdBW/
qD5OkQAdZcS8xqqrg/qP/51ULaPn4FB8vTmpAYtCkFt3nxssnlDWyTfpNykxHZzF
gMpVtwzBPI6Bz8SBjObe
=T8J3
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

--===============7432620049052141534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7432620049052141534==--
