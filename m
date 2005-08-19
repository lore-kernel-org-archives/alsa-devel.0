From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: Alsa mix in HW
Date: Fri, 19 Aug 2005 18:30:37 +0200
Message-ID: <21ed1c370508190930411554ab@mail.gmail.com>
References: <42EBAE72.9090608@e4a.it> <430330CF.3090006@netvigator.com>
	 <1124296946.3591.10.camel@mindpipe> <s5hmzngv5kv.wl%tiwai@suse.de>
	 <1124345111.16411.1.camel@localhost.localdomain>
	 <43054957.1000407@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.203])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 103B322E
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 18:30:44 +0200 (MEST)
Received: by zproxy.gmail.com with SMTP id m22so400215nzf
        for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 09:30:38 -0700 (PDT)
In-Reply-To: <43054957.1000407@netvigator.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

> Refer to Section 3.4 Attenuation by Distance.
>=20
> Samples usually use the entire dynamic range of the chosen
> format/encoding, independent of their real world intensity.
> ...
> The Application will then have to adjust source gain accordingly to
> account for relative differences.
>=20
> Source gain is attenuated by distance.
>=20
>=20
> Do you know how to provide attenuation when using the hardware mixer of
> au88x0 ?  ( -48dB to +6dB )
>=20
> #define MIX_DEFIGAIN 0x08
> #define MIX_DEFOGAIN 0x08       /* 0x8->6dB  (6dB =3D x4) 16 to 18 bit
> conversion? */
=20
As AFAIK, many time ago, while translating the assembler jungle into
C, I found a function that looked like translating gain factors into
dB. The relation was a factor difference of 8 being equivalent to 6
dB. So in theory, on the aureal vortex we can change the gain of each
hardware channel knowing the relative gain in dB. Absolute gain can
never be known for sure.

The 16 hardware HRTF pipes have additional gains as part of the
processing pipelines, but they are used mainly for Interaural Level
Differences. Well, fiddling with the equalizer and Crosstalk canceller
the gain can be changed too, so there are plenty of posibilities to
change final mix gains.
=20
> #define VORTEX_MIX_INVOL_B 0x20000      /* Input volume current */
> #define VORTEX_MIX_VOL_B 0x20800        /* Output Volume current */
> #define VORTEX_MIX_INVOL_A 0x21000      /* Input Volume target */
> #define VORTEX_MIX_VOL_A 0x21800        /* Output Volume target */

There are current and target settings for almost all hardware
parameters, which are intended to do automatic sliding / fading of
values. But the original drivers never did made use of this feature. I
guess because its just hard to do that, because OpenAL or whatever lib
would require to describe events of the future. In the end its easier
and less complex to just update the hardware context multiple times.
Looks like a neat idea that was thrown away afterwards.

Best Regards
Manuel


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
