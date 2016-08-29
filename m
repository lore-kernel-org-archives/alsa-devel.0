From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: fireworks/firewire-tascam:
 accessing to user space outside spinlock
Date: Tue, 30 Aug 2016 07:02:56 +0900
Message-ID: <57C4B110.3070109@sakamocchi.jp>
References: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
 <57C47194.40201@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1602747461863136896=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id A1215260506
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 00:03:10 +0200 (CEST)
In-Reply-To: <57C47194.40201@oracle.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vaishali Thakkar <vaishali.thakkar@oracle.com>, clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1602747461863136896==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="XnrLLSFXrXtSbdAaVBKBkXXLonaePVR6V"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XnrLLSFXrXtSbdAaVBKBkXXLonaePVR6V
Content-Type: multipart/mixed; boundary="LiGkfcmQFn6X4iT57taiddrvLaAuNMOpB"
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Vaishali Thakkar <vaishali.thakkar@oracle.com>, clemens@ladisch.de,
 tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
Message-ID: <57C4B110.3070109@sakamocchi.jp>
Subject: Re: [PATCH 0/2] ALSA: fireworks/firewire-tascam: accessing to user
 space outside spinlock
References: <1472244609-31830-1-git-send-email-o-takashi@sakamocchi.jp>
 <57C47194.40201@oracle.com>
In-Reply-To: <57C47194.40201@oracle.com>

--LiGkfcmQFn6X4iT57taiddrvLaAuNMOpB
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Aug 30 2016 02:32, Vaishali Thakkar wrote:
>=20
>=20
> On Saturday 27 August 2016 02:20 AM, Takashi Sakamoto wrote:
>> Hi,
>>
>> In ALSA fireworks driver and firewire-tascam driver, current implement=
ation
>> for hwdep interface have issues for page fault handling. For example,
>> when using single core processor, after executing lock_page() in page =
fault
>> handler and call task scheduler, then the context never run again, bec=
ause
>> any interrupts are disabled by these drivers and the context can't cat=
ch
>> waiting event. This patchset fixes the issues.
>>
>> The issues were reported by Vaishali Thakkar, with a help of coccinell=
e.
>> Thanks a lot for his care to these minor drivers.
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/11188=
7.html
>=20
> Hi,
>=20
> Just a minor correction here. 'his -> her' :)

I apologize sincerely for my discourtesy...

>> Takashi Sakamoto (2):
>>   ALSA: fireworks: accessing to user space outside spinlock
>>   ALSA: firewire-tascam: accessing to user space outside spinlock
>>
>>  sound/firewire/fireworks/fireworks_hwdep.c | 20 ++++++++++++++-----
>>  sound/firewire/tascam/tascam-hwdep.c       | 32 ++++++++++-----------=
---------
>>  2 files changed, 25 insertions(+), 27 deletions(-)

This weekend, alsa-project.org is out of service, so I cannot post
revised version. As of this morning, it seems to start services so I'll
post them soon.


Thanks :)

Takashi Sakamoto


--LiGkfcmQFn6X4iT57taiddrvLaAuNMOpB--

--XnrLLSFXrXtSbdAaVBKBkXXLonaePVR6V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxLEXAAoJELWlhsfWb9NB4nQP/308L0P7qYzjadlv7dMtlLnk
xlZ3u9TMEsST7btymgL4sSFH+La6YsD+0TvJ14ns1mI7rnkgagP3jCJJxxjSVqQe
vo4Epo3snMjkG8U/7ZUVNTWXFPeP/cRMbAmA6VfWoP0GomHrcpACeIPQluLUEUfD
496uvqalm2fUt4Fw6nRlZpi69D+TEnscfF0S4npCLLczQ1YDZV/HDfn0PalRDt+1
KR+3ba5YXTM7ReR8qtLhDu9GY2KXc41rqXfbQkk7TiXIgfNYPtBCR95J5NIrkad2
iwdbKwH9kqHcisYsxPQc082Cx1Wg1eS3aurZZHcIuEq+h1UuzqFWpzTGAg6+CzKw
OSdTv0w+YF+2CcdPIAw8vwlo3Gu/5LhQlMAEJL9xPHrU0LUEhtpZJP6ulARiWIl5
WKN9sMIEDiMTeulBNUP1x4YlPxNAYO7r7kUIumocZ2EG0FjLeOQmtMDK6Vl+R6GT
a3AckAyD8xX/u6g2dkjiNm6Mt32naIP4fOluDLuU8OL7Nb3Gu++v6yqwm3pa0kQU
GMCHdTY+ynDHTGH2+F2wHmfijRoEalL4WcbPxPtwVng73HDmZnL50UxqBma2yJth
jY+qLznRX0/ZtG9KO9bVaWZsKvN7cl+B6p1iuZnRGVj5CXpBRQvTh3J5Ewn4/2dr
P1jeknkIEnER9YqS9HEr
=aTUa
-----END PGP SIGNATURE-----

--XnrLLSFXrXtSbdAaVBKBkXXLonaePVR6V--

--===============1602747461863136896==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1602747461863136896==--
