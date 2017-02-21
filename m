From: Breno Leitao <leitao@debian.org>
Subject: Re: powerpc64 workaround
Date: Tue, 21 Feb 2017 15:52:52 -0300
Message-ID: <20170221185251.GA9664@gmail.com>
References: <20170220193234.GA10305@gmail.com> <s5hino4pnrw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3147329199547879121=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f181.google.com (mail-qt0-f181.google.com
 [209.85.216.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 2282F266A65
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 19:52:58 +0100 (CET)
Received: by mail-qt0-f181.google.com with SMTP id n21so51800564qta.1
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 10:52:58 -0800 (PST)
In-Reply-To: <s5hino4pnrw.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3147329199547879121==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, Feb 20, 2017 at 10:15:15PM +0100, Takashi Iwai wrote:
> > Currently it seems to be causing some issues on ppc64le (ABI v2) when
> > building this package, and we are reverting it downstream in order to
> > avoid FTBFS on alsa-libs:=20
> >=20
> > https://github.com/alpinelinux/aports/pull/911
> >=20
> > https://github.com/buildroot/buildroot/blob/master/package/alsa-lib/000=
5-remove-powerpc64-workaround.patch
> >=20
> > Anyway, do you think it is still important?
>=20
> Care to submit the patch to alsa-devel ML instead of link?
> Then I can merge the fix.

Cool. I will send it soon. Thank you!

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJYrIyDAAoJEDWjk5/8eHdtGjUQAIQVe53ygiZ3S/1SQPH3qv9y
3QngquYnoERoaijPRndo3VXMLGQpyYZ/xfsdnhIK6yKpmOXeZqtGzMFJfbCr/YnP
Xj1FIOAm86c16zBLk2NZVIsyhjrGOgtVrdy77tjfOywOPCFdHcQjtYLPvCpYu9GH
dSbnqwEE/y7CHJLVgcEwV8zC6pQQnu+GotfzRNAxsypLlpO5ag+kHhqQFepz9ZyB
YNn8gbVkWh2DVxKNUlp9fHNPPncM78+F2hbbBT2ZVeoUWC0ynoxIEhnSZG3aFNrP
aOcwcOlobys8VlIvrLvWZX/nLEwNrDFX47YTIfA6Z96VmRNnrcT2nF+C2RfhmBZQ
5PMUhwulDuFRQ94iSw2lKYPd8Lx8q0LRPy9KpxiPuUJE/YbWB51pzoJP8dLvnGT7
CAeDaX2gT9BU+iFmkrCDLI7t6fql5XC25HThMHxJMt6Sl5GgFWabNj4uqds0O7VJ
8+Nu03XJmiquRLuhPdggS1Wb+WQ5xKFKdHsmcqk5GEhnxKqbHxkmlGYbPEN6AWOy
05qkxqVMlPmA8HGS//lQxrv5vIEuodSjTKtxyYetEn1RZ59NUj4CaUsmI80NI4jY
yUBVtWf5OJAhQ8Fg6f5J+yU2lei5RWjtEX+H7OVnWDd4Ek/pDfFoVJam8sV1mz36
153V+F10wZrf5zdyRcF9
=TmV3
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

--===============3147329199547879121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3147329199547879121==--
