From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: hw_params and approximate values
Date: Wed, 27 Aug 2003 19:45:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <oprukrmaexq1sf88@mail.broadpark.no>
References: <Pine.LNX.4.44.0308221506090.26512-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0308221506090.26512-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 22 Aug 2003 15:11:08 +0200 (CEST), Jaroslav Kysela <perex@suse.cz=
>=20
wrote:

> On Thu, 21 Aug 2003, Arve Knudsen wrote:
>
>> Hi
>>
>> I'm not sure if I quite understand the alsa-lib docs regarding the
>> snd_pcm_hw_params API; in addition to an approximate integer value, on=
e
>> might specify a direction. Is the direction parameter a way to instruc=
t
>> ALSA to look for a floating point value in either direction? If that's=
=20
>> the
>> case, couldn't this be handled with floats directly?
>
> The direction means:
>
> 0 =3D use exactly equal number
> -1 =3D use the most close previous number
> 1 =3D use the most close next number
>
> You may also get most close value using the *_near() function. In this
> case, the direction selection is left on the library or driver code.
>
> Regarding floats, we cannot use floats in a simple way in kernel so it'=
s
> better to avoid this requirement.

By most close, do you mean the nearest supported integer value, or=20
floating point value? The terminology is a little unclear to me, but the=20
existance of a set_integer method leads me to believe the latter is=20
correct. I was meaning to use set_rate_near() to find me a suitable=20
default samplerate, but if it returns an approximate (floating point)=20
value, I would like to be able to report the exact value. The code is=20
meant to hide implementation details across platforms, so I cannot expose=
=20
ALSA-specifics such as sub-unit direction.

Thanks

Arve Knudsen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
