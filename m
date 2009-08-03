From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
 volume-down and mute signals.
Date: Mon, 03 Aug 2009 19:29:17 +0200
Message-ID: <4A771E6D.9020108@poczta.fm>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>
	<s5hocqxcgqb.wl%tiwai@suse.de> <4A76D239.70202@poczta.fm>
	<s5hiqh5ccyr.wl%tiwai@suse.de>
	<20090803162900.GB7298@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030604070505000000030607"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 665542434B
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 00:19:05 +0200 (CEST)
In-Reply-To: <20090803162900.GB7298@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Lukasz Stelmach <stlman@poczta.fm>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030604070505000000030607
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Lennart Poettering pisze:
> On Mon, 03.08.09 14:13, Takashi Iwai (tiwai@suse.de) wrote:
>=20
>>>>> The patch introduces D-Bus support in amixer. With --dbus option gi=
ven amixer
>>>>> works continiously (like with the --stdin) waiting for
>>>>> org.freedesktop.Hal.Device.Condition with the first argument "Butto=
nPressed"
>>>>> and the second being one of: "volume-up", "volume-down" and "mute".=
 These
>>>>> are emmited by the HAL input helper.=20
[...]
> Also, HAL is obsoleted by udev these days. Adding new HAL support to
> software at this point in time is certainly a bad idea. On Fedora 12
> we have now considerably dumbed down HAL. It is only shipped as compat
> kludge for user applications. And with other distros this isn't much di=
ffrent:
>=20
> https://wiki.ubuntu.com/Halsectomy

I must have been living under a stone. OK I see this is rather strong
point. In fact it seems reasonable to do that stuff in udev, though,
I liked HAL D-Bus interfaces.

> Finally, stuff like this really belongs in the user sessions so that
> OSD feedback and so on can be shown.

I knew I've forgotten something. XOSD!

> In fact most desktops do include a tool for this anyway.

I don't use any of the bloated desktop environments and I couldn't
find a tool that does the job. Can you name one and I promise
I won't trouble any one here with my ideas. If you don't... I won't
be bothering you too much either ;-)

- --
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99sk=
a, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziejsk=
a.  (c)PP
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkp3Hm0ACgkQNdzY8sm9K9ySCwCeJy4oxvK3ACoe7/ABNTm/rl3O
jbYAnAjluQcKpa1UC5toLgzF2jnLt4qL
=3DIl+R
-----END PGP SIGNATURE-----


----------------------------------------------------------------------
Zostan Dziewczyna lub Chlopakiem lata!
Wygraj skuter >> http://link.interia.pl/f22a7=20

--------------030604070505000000030607
Content-Type: text/x-vcard; charset=utf-8;
 name="stlman.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stlman.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUM1PTgxdWthc3ogU3RlbG1hY2gN
Cm47cXVvdGVkLXByaW50YWJsZTpTdGVsbWFjaDs9QzU9ODF1a2Fzeg0KZW1haWw7aW50ZXJu
ZXQ6c3RsbWFuQHBvY3p0YS5mbQ0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnZlcnNpb246Mi4x
DQplbmQ6dmNhcmQNCg0K
--------------030604070505000000030607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030604070505000000030607--
