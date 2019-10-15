Return-Path: <SRS0=gwzj=YI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5EBECE588
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:14:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE18A21835
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Oct 2019 18:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dsarbsBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE18A21835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C4AF282B;
	Tue, 15 Oct 2019 20:13:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C4AF282B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571163277;
	bh=TxzmVrHeEJyZlmyWxI5MWHYuyi8y1ZkVu3dgLacGB/w=;
	h=Date:From:To:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dsarbsBj/SuIyeErCQd6/wz/6dHHW/n7xDbn3BVb4U0p/MRhUFj/gShdrusllJdv4
	 U7X0DJkp1GJjikGQYFof5xJmCfeQ/ktXkw4tj9tMvpe1f6zAn7kwczNva7W7xmAC/a
	 J2VswZSYpnQLabT5KY42+afn6Jj6aqPJvClBl/E0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 35FE4F804A9;
	Tue, 15 Oct 2019 20:13:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E282BF804AA; Tue, 15 Oct 2019 20:13:45 +0200 (CEST)
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 211E5F800F4
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2019 20:13:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 211E5F800F4
Received: from ladybug (unknown [37.165.241.96])
 (Authenticated sender: subscript)
 by smtp4-g21.free.fr (Postfix) with ESMTPSA id 9079A19F58A
 for <alsa-devel@alsa-project.org>; Tue, 15 Oct 2019 20:13:40 +0200 (CEST)
Date: Tue, 15 Oct 2019 20:13:35 +0200
From: wwp <subscript@free.fr>
To: alsa-devel@alsa-project.org
Message-ID: <20191015201335.0927bc87@ladybug>
In-Reply-To: <20191014134028.GA11018@b4.vu>
References: <20191013102030.50d7c8d0@ladybug>
	<20191014134028.GA11018@b4.vu>
X-Mailer: Claws Mail 3.17.4git48 (GTK+ 2.24.31; x86_64-unknown-linux-gnu)
User-Agent: DOH
X-Face: 9x'hO=<A?%6*-4(@CJIAZa76:2U]#n7hu##-c.@?as>puy,
 x7GILB]CjB5[R"/@e8LHs#mq
 :>z.ziF; S^1k#Q&M7o"]ff+U|,o2]03`:m[B3N_TSP-p(:x[Y1s/|"AP+~kJ(>>>B7cC]URQW}Cf5R
 [.$i$]W/Cms{l]itD;=B&F6fPm1GF4
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEX9x7aws4vD
 2ekyQlOrRVP//////f9jDrkCAAACMElEQVQ4jVWUy5KjMAxFzYTKGhEXezvVXg8x
 NesQXP0BU4XX2B3r/z9hJPHKeNHV0UEPX11QMx+kE+e5FPmvcEgdAAtH0MAHKFEI
 8iOtcYVzBcSIS6WUZCXs6AmcFT9GCXoI4ckgdy1wTEDBd+BzpZzkrHFzWXtE1AKG
 0GFube4OsCYE31OKBtuVbapYDxxvFNV637zjiVcglZ4y8g+l5fZ/wAkEvAVbUMDW
 +9KDgK7FDcSa45P/vQCA97o9mm9TqcqH5+TTa9cqLmHtnrxvqLk7wNZENZexIvAh
 +0UuEiaA2vef+1jCs+b2QzP5x5kREa6s4zQQY4A7SK5DHkBT/GW6IoD+xOyMw9s0
 Bu/9HzzBjDaNbpk0xWkofSxqjtbc/Xa+8caO2VbbOZJbzgD9HY9FJRFvPb3V3TEu
 qQrWUg7wtPkAWedMpkHrkETHc+d5tMnFghFn790HSNayl8hemSqRgw4A4MhslPND
 ldCUHfyl5hZaxwkkQ4eniGh4UHenDkjqnIBW1xraNzkut3iCsgvyiJaSyg4wmh0Y
 rrgCEoyaUqVdE//YAdUFl4/46gZV5Bq/UMTtbzD5fhsXMZD/xol1xdTAC7ep8A2g
 lLr5FtkVSl9XUMi4o1IVvRMMKgVP7k2mjjVn6GuR179q9Fj4ygojF4JvWTEN0qhw
 FcNhrBulR6nL7++o/NfqxJiCHtaGfKdL2L1LCjYS5dL0kTi+JXxzLPJDwMfXB7cG
 LDP/EvAPpzg/DzW8HhEAAAAASUVORK5CYII=
MIME-Version: 1.0
Subject: Re: [alsa-devel] Focusrite Scarlett 18i8 3rd Gen audio interface
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
Content-Type: multipart/mixed; boundary="===============6253069103655629749=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

--===============6253069103655629749==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/+jJ.BRpP9_5Zs8EMv_fdzmg"; protocol="application/pgp-signature"

--Sig_/+jJ.BRpP9_5Zs8EMv_fdzmg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Geoffrey,


On Tue, 15 Oct 2019 00:10:28 +1030 "Geoffrey D. Bennett" <g@b4.vu> wrote:

> Hi wwp,
>=20
> On Sun, Oct 13, 2019 at 10:20:30AM +0200, wwp wrote:
> > Hello,
> >=20
> > I've recently bought a Focusrite Scarlett 18i8 3rd Gen audio interface,
> > great device, but in CentOS 7, with either the available 3.x or 4.x
> > kernels, the device just appears in the available Alsa devices, but no
> > mixer is available, the device direct hardware monitor output is also
> > not working (it is, by default, and works well in Windows, but I
> > presume that w/ no mixer support in Alsa, it's expected that nothing
> > works). I'm able to bound I/O ports in QJackCtl but nothing goes out of
> > the device. =20
>=20
> Is any of the class-compliant functionality (play/record) working at
> all in CentOS 7? I would expect that out of the box you should be able
> to get standard ALSA/PulseAudio apps working for I/O.

I tried, nothing, maybe not tried right or enough.


> > Of course, adding the 0x1235:8214 USB ID to the quirks just doesn't
> > work. I presume there's more work like the patch submitted here (I saw
> > the archives) in the "[PATCH RFC V2] ALSA: usb-audio: Scarlett Gen 2
> > mixer interface" mail thread? =20
>=20
> Yes, there would definitely be more work to do along those lines. If
> we're lucky, the protocol is basically the same as 2nd gen and just
> extended for the additional features in the 3rd gen. FWIW, I haven't
> heard of anyone starting that work.
>=20
> > Do you it is worth trying applying that 2nd Gen patch to one of the v4
> > kernel available for CentOS 7, adding the 3rd Gen quirks and see how it
> > behaves? Or is there already progress on supporting the 3rd Gen one too=
? =20
>=20
> I doubt that it would do much useful beyond letting you know if it
> accepts the same initialisation sequence as the 2nd gen devices. If
> you want to send me (off-list) a wireshark USB capture from 1) the
> Windows driver initialising your device and 2) you adjusting settings
> in Focusrite Control, I can have a look at it and let you know if it
> looks similar to the 2nd gen devices.

I tried -> broken pipe. IOW, it doesn't work, not as simple as doing as
if the 3rd gen was a 2nd gen.


Regards,

--=20
wwp
https://useplaintext.email/

--Sig_/+jJ.BRpP9_5Zs8EMv_fdzmg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJdpgxTAAoJEEnFZ+hWA4VJ4eIQAKiXyfPVysW0CMHUQc68BAvM
Ri1amuNAYu7r+/teq0y/aRukNSZzQNyiFRDB+a8YblyyPrREEMilSqZ1Er3Tos7n
wSAxCAE7zMBvompF4p7uh9/MxDxF3Oaaqr52xT2SLKLuA0wWq255AwxGMbI8r5gf
EZrLSNplXQoWcQEqbHpIanNX+z1mYiu3hgGxv6RAT9y/KVSrv6w4UPc/2OuR7cEF
BUSho7+LXOnT9lKOzSY6QtjzVWsV6E84iGWLbnH1UAKtvPwTZE+nHH0F5dyh6JBw
mqtYmRHkFtLRIe/OS/YaYkZw/ihjSexbtD1RIFEi4SyIpbGiiPmWCSBoT6y/UqU2
sCVS3ZxSh1QKSizGsisQl6OTdlpvlIfdiTpQtoJXD7k0P601MFbz/zKxsu8izR1b
yngWiDLwHSKvLjkkv/S1jb/uvnUIYJXPQPZ5XNn4StRyk3dUCLaTeA/yUYa2aEny
6ndS2DnVlND2zsgRPCN2b2SPt7BH63pSf549VTt6Ac3GEFhz3pDcTjmP+IYcO5de
jYvpyaQLUidb7IGm7fUvkt64ly2yn/UjNT/+HJET8GP1QldG8eQU6Z9s0h2xO9jh
jPcKpMqYyWoe7yJZMOzwIgZHQGMR1wkLQXCkzBhQ5zNaMzgnhYVY9AIxiDLJucfe
VZg07KpldKuASR44wEvQ
=7j/9
-----END PGP SIGNATURE-----

--Sig_/+jJ.BRpP9_5Zs8EMv_fdzmg--

--===============6253069103655629749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6253069103655629749==--
