From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
 volume-down and mute signals.
Date: Mon, 03 Aug 2009 19:07:05 +0200
Message-ID: <4A771939.3030001@poczta.fm>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>	<s5hocqxcgqb.wl%tiwai@suse.de>	<4A76D239.70202@poczta.fm>
	<s5hiqh5ccyr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020701030305030505080304"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id EB5B22414C
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 00:02:24 +0200 (CEST)
In-Reply-To: <s5hiqh5ccyr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020701030305030505080304
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai pisze:
> At Mon, 03 Aug 2009 14:04:09 +0200,
> Lukasz Stelmach wrote:
>> Takashi Iwai pisze:
>>> At Mon,  3 Aug 2009 12:43:21 +0200,
>>> =C5=81ukasz Stelmach wrote:
>>>> The patch introduces D-Bus support in amixer. With --dbus option giv=
en amixer
>>>> works continiously (like with the --stdin) waiting for
>>>> org.freedesktop.Hal.Device.Condition with the first argument "Button=
Pressed"
>>>> and the second being one of: "volume-up", "volume-down" and "mute".
[...]
>>>> Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
>>> Thanks for the patch.
>>>
>>> The approach is interesting, but I'm not sure whether we should put
>>> all into amixer in this way since we don't want extra library
>>> dependency.  (Note: amixer could be used in initrd.)
>>> I think it's better to split the code and make it as an individual
>>> daemon instead of additional options of amixer.
>> No worries ;) there is --with(out)--dbus option for configure to
>> disable all this code which is enough for initrd because most often
>> (AFAIK) initrd binaries are not the same that in the live system.
>=20
> Usually same binaries are used for initrd nowadays in many distros.
> So, configure option doesn't help.

Makefile rules to build two different executable files?

> And, I really prefer this as a separate daemon, so it be as small as
> possible.

I've done some testing with all the code unused in dbus scenario
ifdefed out and it was not any smaller than full a mixer with
the patch. In fact I haven't tried to hard to understand all the
string parsing and control code, however, there doesn't seem
to be much to throw out if one wants a flexible D-Bus only tool.

>  Seeing amixer as a daemon is somewhat strange...

What about --stdin option?

- --
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99sk=
a, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziejsk=
a.  (c)PP
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkp3GTkACgkQNdzY8sm9K9xvdgCgh4oQzK7hbkPIbe+pLPbz89ha
ohwAnifsxiAZ1LraJzjdFPjdtR6XWL5k
=3DfjE8
-----END PGP SIGNATURE-----


----------------------------------------------------------------------
Zostan Dziewczyna lub Chlopakiem lata!
Wygraj skuter >> http://link.interia.pl/f22a7=20

--------------020701030305030505080304
Content-Type: text/x-vcard; charset=utf-8;
 name="stlman.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stlman.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUM1PTgxdWthc3ogU3RlbG1hY2gN
Cm47cXVvdGVkLXByaW50YWJsZTpTdGVsbWFjaDs9QzU9ODF1a2Fzeg0KZW1haWw7aW50ZXJu
ZXQ6c3RsbWFuQHBvY3p0YS5mbQ0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnZlcnNpb246Mi4x
DQplbmQ6dmNhcmQNCg0K
--------------020701030305030505080304
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020701030305030505080304--
