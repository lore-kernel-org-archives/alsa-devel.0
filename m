From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
 volume-down and mute signals.
Date: Mon, 03 Aug 2009 18:59:32 +0200
Message-ID: <4A771774.8040408@poczta.fm>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>
	<s5hocqxcgqb.wl%tiwai@suse.de> <4A76D239.70202@poczta.fm>
	<s5hiqh5ccyr.wl%tiwai@suse.de>
	<20090803121747.GD5959@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000805050700070302090104"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id F154A243B5
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 01:10:59 +0200 (CEST)
In-Reply-To: <20090803121747.GD5959@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000805050700070302090104
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Brown pisze:
> On Mon, Aug 03, 2009 at 02:13:16PM +0200, Takashi Iwai wrote:
>> Lukasz Stelmach wrote:
>=20
>>> No worries ;) there is --with(out)--dbus option for configure to
>>> disable all this code which is enough for initrd because most often
>>> (AFAIK) initrd binaries are not the same that in the live system.
>=20
>> Usually same binaries are used for initrd nowadays in many distros.
>> So, configure option doesn't help.
>=20
>> And, I really prefer this as a separate daemon, so it be as small as
>> possible.  Seeing amixer as a daemon is somewhat strange...
>=20
> I tend to agree, merging it into amixer seems kind of arbatrary.  Such =
a
> daemon (and its dbus interface) may also be useful for handling things
> like scenario management so I can see it growing over time.

Scenario management? Could you please say something more what I
have not been missing for so long ;-)

- --
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99sk=
a, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziejsk=
a.  (c)PP
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkp3F3QACgkQNdzY8sm9K9wLpgCcC46pzInBHGBIHXmB8fCWqkel
QDQAmwTvtJHJuHMkqQv4GvEfKGzfUFhR
=3DJ5+H
-----END PGP SIGNATURE-----


----------------------------------------------------------------------
Zostan Dziewczyna lub Chlopakiem lata!
Wygraj skuter >> http://link.interia.pl/f22a7=20

--------------000805050700070302090104
Content-Type: text/x-vcard; charset=utf-8;
 name="stlman.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stlman.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUM1PTgxdWthc3ogU3RlbG1hY2gN
Cm47cXVvdGVkLXByaW50YWJsZTpTdGVsbWFjaDs9QzU9ODF1a2Fzeg0KZW1haWw7aW50ZXJu
ZXQ6c3RsbWFuQHBvY3p0YS5mbQ0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnZlcnNpb246Mi4x
DQplbmQ6dmNhcmQNCg0K
--------------000805050700070302090104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------000805050700070302090104--
