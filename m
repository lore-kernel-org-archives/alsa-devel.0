From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
 volume-down and mute signals.
Date: Mon, 03 Aug 2009 14:04:09 +0200
Message-ID: <4A76D239.70202@poczta.fm>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>
	<s5hocqxcgqb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080305020404070606020701"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239])
	by alsa0.perex.cz (Postfix) with ESMTP id DA4F710382E
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Aug 2009 14:04:13 +0200 (CEST)
In-Reply-To: <s5hocqxcgqb.wl%tiwai@suse.de>
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
--------------080305020404070606020701
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Takashi Iwai pisze:
> At Mon,  3 Aug 2009 12:43:21 +0200,
> =C5=81ukasz Stelmach wrote:
>>
>> The patch introduces D-Bus support in amixer. With --dbus option given=
 amixer
>> works continiously (like with the --stdin) waiting for
>> org.freedesktop.Hal.Device.Condition with the first argument "ButtonPr=
essed"
>> and the second being one of: "volume-up", "volume-down" and "mute". Th=
ese
>> are emmited by the HAL input helper. A single amixer process can contr=
oll
>> one mixer item. There are options to choose a specific item to control=
l,
>> an input device to listen and a single adjustment step size.
>>
>> Signed-off-by: =C5=81ukasz Stelmach <stlman@poczta.fm>
>=20
> Thanks for the patch.
>=20
> The approach is interesting, but I'm not sure whether we should put
> all into amixer in this way since we don't want extra library
> dependency.  (Note: amixer could be used in initrd.)
> I think it's better to split the code and make it as an individual
> daemon instead of additional options of amixer.

No worries ;) there is --with(out)--dbus option for configure to
disable all this code which is enough for initrd because most often
(AFAIK) initrd binaries are not the same that in the live system.

--=20
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99sk=
a, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziejsk=
a.  (c)PP


----------------------------------------------------------------------
Zostan Dziewczyna lub Chlopakiem lata!
Wygraj skuter >> http://link.interia.pl/f22a7=20

--------------080305020404070606020701
Content-Type: text/x-vcard; charset=utf-8;
 name="stlman.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stlman.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUM1PTgxdWthc3ogU3RlbG1hY2gN
Cm47cXVvdGVkLXByaW50YWJsZTpTdGVsbWFjaDs9QzU9ODF1a2Fzeg0KZW1haWw7aW50ZXJu
ZXQ6c3RsbWFuQHBvY3p0YS5mbQ0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnZlcnNpb246Mi4x
DQplbmQ6dmNhcmQNCg0K
--------------080305020404070606020701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080305020404070606020701--
