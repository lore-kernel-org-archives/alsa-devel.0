Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C24C33CAA
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:11:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 545EB2253D
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 11:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bASUZ9qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 545EB2253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0A86166C;
	Tue, 21 Jan 2020 12:10:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0A86166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579605087;
	bh=qIsohG13v40iegI1Ll/FZWaTtKEOxLDBqfkvGYXywl0=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bASUZ9qANYcUm3NRWIJEFsSdLTxH8p2h+2E0ffecAYHT6PCTAJDrDY2ZdlKKsV5CI
	 7VQoINgwGAO854WuEbJGh8ZE7TFcQs+mDLGuOwklOnbmKGhSmMyr2grxIh2kYjVxqZ
	 GiKqhEfdxYTeqQdAZZCHcS6qp+jwHG5E2RfeAYhs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 364E1F8015B;
	Tue, 21 Jan 2020 12:10:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5357FF801D9; Tue, 21 Jan 2020 12:10:36 +0100 (CET)
Received: from mx1.emlix.com (mx1.emlix.com [188.40.240.192])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89C2BF8012F
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 12:10:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89C2BF8012F
Received: from mailer.emlix.com (unknown [81.20.119.6])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.emlix.com (Postfix) with ESMTPS id 1F4B65FA52
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 12:10:31 +0100 (CET)
From: Rolf Eike Beer <eb@emlix.com>
To: alsa-devel@alsa-project.org
Date: Tue, 21 Jan 2020 12:10:26 +0100
Message-ID: <7024938.GRfFhfinkP@devpool35>
Organization: emlix GmbH
MIME-Version: 1.0
Subject: [alsa-devel] Format string warnings on 32 bit platforms
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1278381783425532514=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

--===============1278381783425532514==
Content-Type: multipart/signed; boundary="nextPart18588060.U8oj414JBG"; micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart18588060.U8oj414JBG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

The first ones can be fixed by either casting to "unsigned long long" and=20
using that specifier or using the proper format specifiers from inttypes.h

Greetings,

Eike

container.c: In function 'container_context_pre_process':
container.c:359:33: warning: format '%lu' expects argument of type 'long un=
signed int', but argument 3 has type 'uint64_t' {aka 'long long unsigned in=
t'} [-Wformat=3D]
  359 |    fprintf(stderr, "  frames: %lu\n",
      |                               ~~^
      |                                 |
      |                                 long unsigned int
      |                               %llu
  360 |     *frame_count);
      |     ~~~~~~~~~~~~                =20
      |     |
      |     uint64_t {aka long long unsigned int}
container.c:362:37: warning: format '%lu' expects argument of type 'long un=
signed int', but argument 3 has type 'uint64_t' {aka 'long long unsigned in=
t'} [-Wformat=3D]
  362 |    fprintf(stderr, "  max frames: %lu\n",
      |                                   ~~^
      |                                     |
      |                                     long unsigned int
      |                                   %llu
  363 |     *frame_count);
      |     ~~~~~~~~~~~~                    =20
      |     |
      |     uint64_t {aka long long unsigned int}
container.c: In function 'container_context_post_process':
container.c:430:39: warning: format '%lu' expects argument of type 'long un=
signed int', but argument 3 has type 'uint64_t' {aka 'long long unsigned in=
t'} [-Wformat=3D]
  430 |   fprintf(stderr, "  Handled bytes: %lu\n",
      |                                     ~~^
      |                                       |
      |                                       long unsigned int
      |                                     %llu
  431 |    cntr->handled_byte_count);
      |    ~~~~~~~~~~~~~~~~~~~~~~~~           =20
      |        |
      |        uint64_t {aka long long unsigned int}
subcmd-transfer.c: In function 'context_process_frames':
subcmd-transfer.c:392:20: warning: format '%lu' expects argument of type 'l=
ong unsigned int', but argument 4 has type 'uint64_t' {aka 'long long unsig=
ned int'} [-Wformat=3D]
  392 |    "%s: Expected %lu frames, Actual %lu frames\n",
      |                  ~~^
      |                    |
      |                    long unsigned int
      |                  %llu
  393 |    snd_pcm_stream_name(direction), expected_frame_count,
      |                                    ~~~~~~~~~~~~~~~~~~~~
      |                                    |
      |                                    uint64_t {aka long long unsigned=
 int}
subcmd-transfer.c:392:39: warning: format '%lu' expects argument of type 'l=
ong unsigned int', but argument 5 has type 'uint64_t' {aka 'long long unsig=
ned int'} [-Wformat=3D]
  392 |    "%s: Expected %lu frames, Actual %lu frames\n",
      |                                     ~~^
      |                                       |
      |                                       long unsigned int
      |                                     %llu
  393 |    snd_pcm_stream_name(direction), expected_frame_count,
  394 |    *actual_frame_count);
      |    ~~~~~~~~~~~~~~~~~~~                =20
      |    |
      |    uint64_t {aka long long unsigned int}
alsa.c: In function 'set_snd_pcm_params':
=2E./include/gettext.h:13:25: warning: format '%zd' expects argument of typ=
e 'signed size_t', but argument 3 has type 'snd_pcm_uframes_t' {aka 'long u=
nsigned int'} [-Wformat=3D]
   13 | # define gettext(msgid) (msgid)
      |                         ^~~~~~~
=2E./include/gettext.h:18:18: note: in expansion of macro 'gettext'
   18 | #define _(msgid) gettext (msgid)
      |                  ^~~~~~~
alsa.c:256:21: note: in expansion of macro '_'
  256 |   fprintf(bat->err, _("period size: %zd %s: %s(%d)\n"),
      |                     ^
=2E./include/gettext.h:13:25: warning: format '%zd' expects argument of typ=
e 'signed size_t', but argument 3 has type 'snd_pcm_uframes_t' {aka 'long u=
nsigned int'} [-Wformat=3D]
   13 | # define gettext(msgid) (msgid)
      |                         ^~~~~~~
=2E./include/gettext.h:18:18: note: in expansion of macro 'gettext'
   18 | #define _(msgid) gettext (msgid)
      |                  ^~~~~~~
alsa.c:265:21: note: in expansion of macro '_'
  265 |   fprintf(bat->err, _("buffer size: %zd %s: %s(%d)\n"),
      |                     ^
=2E./include/gettext.h:13:25: warning: format '%zd' expects argument of typ=
e 'signed size_t', but argument 3 has type 'snd_pcm_uframes_t' {aka 'long u=
nsigned int'} [-Wformat=3D]
   13 | # define gettext(msgid) (msgid)
      |                         ^~~~~~~
=2E./include/gettext.h:18:18: note: in expansion of macro 'gettext'
   18 | #define _(msgid) gettext (msgid)
      |                  ^~~~~~~
alsa.c:273:21: note: in expansion of macro '_'
  273 |   fprintf(bat->err, _("equal to buffer size (%zd)\n"),
      |                     ^

=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

Besuchen Sie uns auf der Embedded World 2020 in N=C3=BCrnberg!
=2D> Halle 4, Stand 368

--nextPart18588060.U8oj414JBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCXibcIgAKCRCr5FH7Xu2t
/OZ3BACktJH/0jV4bdjqzM6VpBXv/UTn2fFLjQ2phldZLg+Tq/BS7iqPfS61XAMO
h5MZtM9R4BHYm5mukGGPyf32H+7ghKlAF8M5mEfrkaYjrLZjO1TMU8qhObIDXqOp
jEsBEvbP1lE2WeksG8xiqeND9s5Qi8OZwkfJjU6QOqNSc29hTA==
=3DO6
-----END PGP SIGNATURE-----

--nextPart18588060.U8oj414JBG--




--===============1278381783425532514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1278381783425532514==--



