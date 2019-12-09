Return-Path: <SRS0=FS4p=Z7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C990FC43603
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:46:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C287220726
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ocpGeSOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C287220726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ethgen.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BB12E10E;
	Mon,  9 Dec 2019 10:45:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BB12E10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575884787;
	bh=Z10oZkW8fTvoWtePHkktcaI6P0RI/M7R39I4kErs7gU=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ocpGeSOIaP0vqUJ0RwM3hgDkbjyffblj52n43T4v+vOxEkrp6GRBReNdWqK+VnQvg
	 9utw7vdUO/FtltGDGlqtpxH9sguFuBGVNUXK7qLv+FHgeXHpjNbDisQpGaMom7nsdr
	 8qaSh+4m/NLyEQnPpIbzKdxkfEetB1Zss9ohzabw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3ADF6F801F4;
	Mon,  9 Dec 2019 10:45:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C7D21F80234; Mon,  9 Dec 2019 10:45:35 +0100 (CET)
Received: from tschil.ethgen.ch (tschil.ethgen.ch [5.9.7.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AFFBF8011E
 for <alsa-devel@alsa-project.org>; Mon,  9 Dec 2019 10:45:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AFFBF8011E
Received: from [192.168.17.4] (helo=ikki.ket)
 by tschil.ethgen.ch with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <klaus@ethgen.ch>)
 id 1ieFbf-0000Kr-Mh; Mon, 09 Dec 2019 10:45:31 +0100
Received: from klaus by ikki.ket with local (Exim 4.93-RC7)
 (envelope-from <klaus@ethgen.ch>)
 id 1ieFbf-0000fH-A9; Mon, 09 Dec 2019 10:45:31 +0100
Date: Mon, 9 Dec 2019 10:45:31 +0100
From: Klaus Ethgen <Klaus@ethgen.ch>
To: Takashi Iwai <tiwai@suse.de>
Message-ID: <20191209094530.GA30989@ikki.ethgen.ch>
References: <20191202184759.GB29478@ikki.ethgen.ch>
 <s5hy2vsjbm3.wl-tiwai@suse.de>
 <20191207200643.GA10092@ikki.ethgen.ch>
 <s5h4kybciir.wl-tiwai@suse.de>
 <20191208173127.GE4433@ikki.ethgen.ch>
 <s5hmuc2asa7.wl-tiwai@suse.de>
 <20191209085716.GA12935@ikki.ethgen.ch>
 <s5h4ky9hmro.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <s5h4ky9hmro.wl-tiwai@suse.de>
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] CPU hook snd_hda_intel
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
Content-Type: multipart/mixed; boundary="===============0646189665992867305=="
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--===============0646189665992867305==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hi Takashi,

Am Mo den  9. Dez 2019 um 10:27 schrieb Takashi Iwai:
> Maybe unrelated with this particular problem, but I wonder why you
> didn't enable CONFIG_SND_HDA_CODEC_ANALOG.  You're using the generic
> codec driver and it misses a few vendor-specific fixes / workarounds.

Lack of better knowledge. I'll add it to the next kernel build. I do not
exactly know the concept of codecs.

I have to admit, that I just recently switched to alsa as I was using
OSS4 before as I had many troubles with alsa in the past. (Kernel ops,
localized libraries that didn't accept '.' as a decimal limiter,
cracking sound when moving the mouse, ...)

So a compatibility issue on gentoo with the current oss4 package forced
me to give alsa another try. And I have to say, it is matured now.
Except this particular problem it seems to be stable.

Regards
   Klaus
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAl3uF7UACgkQpnwKsYAZ
9qz7Kwv+Mf0JFQnUWXEA2UYiFdcegoIanogUFyrIncNNzQIwxFHQ1dE7LwGzJVCF
Pdv63bkPwy32blUV0rjd8gpSNlbml1Cl2cbOSdJxHffQ17rR0hBbJ1swlz9daGoe
ceqo2Y5ATptUCDjvCiR8/2AJi3KPJvJD8XEH13K0IMeEd+n5dMVUomnbxP17s8YT
blNW/1WT7rm91fj67DNa3PoyhnfE6+WoXeRg2dCNOJZJqCzUsEsLgIm3kMqpRQYF
/CBT9Dtf+ktldq+3m5bUA4P0Q0HBKEmmK2WbtpgcBd5kIjYJk10DxlgJpf8gdqWi
HeExpOWPUf3rc/1EBprSsDWUrsoOKWeR0hBwRfwDNGDFpU6nHYFH4DlYejP19A2H
HqgBIeKXYxZ44fQpdX52CxeW85Ky+SJ3vdMAqctxySsh2e4kHmlmkHCV9FoNIBzE
EIOwTnRL8hD1vMmpelOA0iYicQGpgBX0qRhHacfRPlz39iGdPTNRfARAu4w/cBQ1
OQ6PC0b2
=sosH
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

--===============0646189665992867305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0646189665992867305==--
