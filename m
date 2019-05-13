From: Lars Wendler <polynomial-c@gentoo.org>
Subject: Re: alsa-lib-1.1.6.tar.bz2: some files are missing in
 the tarball
Date: Mon, 13 May 2019 11:13:58 +0200
Message-ID: <20190513111358.73510257@abudhabi.paradoxon.rec>
References: <20180409151616.6c8338a7@abudhabi.paradoxon.rec>
 <s5hh8og8v3a.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8655437897794955633=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28FE4F8072A
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 11:14:09 +0200 (CEST)
In-Reply-To: <s5hh8og8v3a.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, alsa-bugs@gentoo.org
List-Id: alsa-devel@alsa-project.org

--===============8655437897794955633==
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_//6nlpVArOKG0JClRI8AXegq"; protocol="application/pgp-signature"

--Sig_//6nlpVArOKG0JClRI8AXegq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Apr 2018 14:31:21 +0200 Takashi Iwai wrote:

>On Mon, 09 Apr 2018 15:16:16 +0200,
>Lars Wendler wrote:
>>=20
>> Hello list,
>>=20
>> please have a look at this Gentoo bug report [1] where a user
>> reported that he cannot compile alsa-lib-1.1.6 with --enable-alisp
>> configure option. The error message is:
>>=20
>>   make[3]: *** No rule to make target 'SI7018/sndoc-mixer.alisp',
>>   needed by 'all-am'. Stop.
>>=20
>> This happens because the directory src/conf/cards/SI7018 is missing
>> as well as the following files:
>>=20
>> src/conf/cards/aliases.alisp
>> src/conf/smixer.conf
>> src/conf/sndo-mixer.alisp
>>=20
>> First I thought those files were removed intentionally but checking
>> the alsa-lib git tree I can see all files still being available. So
>> at Gentoo we fixed this by re-adding the files through a patch [2].
>>=20
>> Any chance this was an accidental oversight?
>
>It's because the contents of EXTRA_DIST also depends on the configure
>option, and the tarball was created without enabling the feature, I
>suppose.  Maybe we should fix EXTRA_DIST to list all files
>unconditionally.
>
>
>thanks,
>
>Takashi

This is still an issue with latest 1.1.9 release tarball. Did you
forget about this or do you still look for a good solution?

Lars

--=20
Lars Wendler
Gentoo package maintainer
GPG: 21CC CF02 4586 0A07 ED93  9F68 498F E765 960E 9B39

--Sig_//6nlpVArOKG0JClRI8AXegq
Content-Type: application/pgp-signature
Content-Description: Digitale Signatur von OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEWCOBmo8i7LhvVmNAVx3S0DQ8YDkFAlzZNVYACgkQVx3S0DQ8
YDm7fQ//cWtopnpLut0UMwHMuGsiPGv7QzHPotLkXt0svZ2c6U1TmcsrzaU2PXEv
l0prj6Hueae9j39q0B3muoNjyWHOdzfwTHk0llnqlSP4hR2S5T5mvnjEuDy5znuv
AEk2uNIlIWIiQnoTJi4p8k9QxuU6TiP7z1i2A/5BLErR841f4FZZvfPABnW19aoN
5cHggRibp9pUzBDIdIqGCkqATD+/93TjQpqAwbZWlnsRU317Y2ji/G5a5oc//4Yf
epW97HKIicRRIz9NYeC9hBScediUv5DOasSuZtxbNnBBa2Bhpe3UFOR/u3wCeh8a
W0aHYu9ev9KqyHv1bWFIzx9AKQEltkfdqTRY2MGL67CNeUceBdpsIfYddHijpO2Y
+Pbl5/RVdm1uqhnH/+tGujtRw/yfd9mbAk37reLZ4Rb1wPB8DSqy25Kfe8//W7DW
GgkI6BV0zh8QWMgadrcYPOwL9ZU5tokyBmlbrwsymtMmZpafuqR/RpB8mUJcS/hb
Om+BY0XPyuK+gC+e573Sq8E8UqaRhRq8GzyrrwktZyF61oZmAWi+q64HxWR9G21I
YozF/SQyqQygpTjK77kkjY6vnXgV86Il34If4HcwWXKyYVnqLMcznn1z+8TXrSEM
roaZ8dLbJebrDPg+4mLpV257ZBgXb5iyz3MinsmBT9lS33JtrgM=
=WA0c
-----END PGP SIGNATURE-----

--Sig_//6nlpVArOKG0JClRI8AXegq--

--===============8655437897794955633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8655437897794955633==--
