Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F76C982DE
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:29:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 20778601F9;
	Mon, 21 Sep 2026 11:28:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 20778601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789982948;
	bh=BlO8YcIAdLIGXqChhgVqSTvIsclf7Ez8KriTr4yfPo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ID0aP7XorjNA1YQKQeI4/6k/aEtgqO5w6CQm+oFNIOn4IaQDNSbk8aOSpklInWASY
	 03v7npwD4Tk5TCTU40i2GoTBC3rFKVNUmuICaSsj87H4n1XECUUTm77DQ/97jiVtas
	 wyrqhwhdCThW4RLT2BmXkC0TeIoV4ym8owD6vf+o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B08CAF805FD; Mon, 21 Sep 2026 11:28:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC4EEF80601;
	Mon, 21 Sep 2026 11:28:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D1E3CF804F3; Mon, 21 Sep 2026 11:28:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789982907;
	b=KrTtIZdoUXpJp7ETuS/EE324Robs+L02grlSLOsY7dwMS5R6IHK4Pip43H9jNp71dwXY
	 3N93gX2er7CinI2VR8kq0FKJong3RF1qVN1ad4wDyvgdexaZDoK13WeLkPo8hZcGuf/4b
	 RzmRQHtQPUpcsu3sPAl4ur46yaezFS2D+NszZD0PdD+viSKCRhT7Lv15tWDLXTSDAduxj
	 DJdIh1lKiPR1dhMre5sOI6SIklos+to+Y+CiLRQ+yFm4/zd992Wuac5mTJJ8lk/B7SCnL
	 rGdoNLfe6cq2RMj3krqPSoCm4VS1WdGtNg5EnKZmnU3OIRngIzyXCAF8paxZFib6zBQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789982907;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=BlO8YcIAdLIGXqChhgVqSTvIsclf7Ez8KriTr4yfPo4=;
	b=OtVhydDruGxxMAbFAqAA16yxnUWEwRApWrDOolrDhzdJiqHMSiTgWhmlIXH+9IVIxhe9
	 Fd3Cfe7SJWlpUT7by04JKVAhJttL0YVG/9VlVRe9r6jQFSDtA3pQBiSNaXj9vtaUYiXP3
	 F9Sx0NaKBr2Dyhb5FvI1o8QC+0ifymhiQQvbuMqGjz2+9CwiDrB+oF6mF8BbE3staW/2T
	 P3sGm5KpDcZ9KmRhhaljwSfL1NRC9c391I7JU/rYq83NV9bt929HA/8qNhWxiQ57GqSlk
	 lOtYA7zAiDXEnYQOE4JjV4XUQGa5o11Yvof3B0y+yr5FVZMGAEcQ5K4ow4ZCtMMskzg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DDvl+ge2;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 99DE4F801F7
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 11:28:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99DE4F801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=DDvl+ge2
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 458B843472;
	Mon, 21 Sep 2026 09:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B731F000FF;
	Mon, 21 Sep 2026 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982903;
	bh=Xkoji6zTVBEB22n/TDJ3LMI+tSUvIAOWk7kusizeXCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DDvl+ge2tsNfsLi4bmj87KXWxJsb3xBG3klQYu6S1TLOKMS9zwVBy4gg2JWvVbmPg
	 tcSjkU2YKqFzrkyScxe2kIRZRyNdZ3QP5W7tzbexr2jh/+/XfsSUXdfCoDGgV1B3Ka
	 h0EvmjiLX9u1tVuWn8dp0YoZgX8uIP4px3xsYg+XWeJZNRj508KQEM97eXUEYty1Dc
	 xMGzrivmjatQkrdPeK0/qHDzlmNKvHCmp9Tzo2mtVoIKnSWzlSmLxknsh/doJWWRzV
	 fXkRz4gQnZJgsObRR6XxSf0l5qs3qKOVN3m+w1uJ+tYr52UFf3RU5gyMNAsyH2Gnv9
	 XkYloDzLxLG6w==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id BEE3E1AC52F5; Mon, 21 Sep 2026 10:27:47 +0100 (BST)
Date: Mon, 21 Sep 2026 11:27:47 +0200
From: Mark Brown <broonie@kernel.org>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Yi, Ken" <k-yi@ti.com>, "Lo, Henry" <henry.lo@ti.com>,
	"Chen, Robin" <robinchen@ti.com>,
	"Holalu Yogendra, Niranjan" <niranjan.hy@ti.com>,
	"pin-hao.huang@hp.com" <pin-hao.huang@hp.com>,
	"Syed.SabaKareem@amd.com" <Syed.SabaKareem@amd.com>
Subject: Re: [EXTERNAL] Re: [PATCH v5] ASoC: tas2783-sdw: add firmware
 download status check
Message-ID: <arD4k6hCZyqycYYW@sirena.co.uk>
References: <20260921064053.932-1-baojun.xu@ti.com>
 <arDujlvvKixE6ifp@sirena.co.uk>
 <1c8da29a1fac4435a59783ab9fe7f68b@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bJCWGDMDCoajVTO9"
Content-Disposition: inline
In-Reply-To: <1c8da29a1fac4435a59783ab9fe7f68b@ti.com>
X-Cookie: Too clever is dumb.
Message-ID-Hash: 3RI36KBYB5YEQAHUAPMFWR4HTJJ7WBAU
X-Message-ID-Hash: 3RI36KBYB5YEQAHUAPMFWR4HTJJ7WBAU
X-MailFrom: broonie@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3RI36KBYB5YEQAHUAPMFWR4HTJJ7WBAU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


--bJCWGDMDCoajVTO9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 21, 2026 at 09:22:23AM +0000, Xu, Baojun wrote:

> > > +     /* Check if the AMP is in reset status. */
> > > +     if (val == 0x20) {
> > > +             tas_dev->fw_dl_success = false;

> > I'm still not seeing where fw_dl_success gets set to true if the
> > download was skipped.

> If download was skipped, it should be true.

As I said on the previous version can you guarantee that the driver is
being probed with the device having been reset?  What happens if
something earlier in the boot process left it running, or the driver was
removed and reprobed?  The logic only works currently if the driver did
the download that it's skipping.

--bJCWGDMDCoajVTO9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqw+JIACgkQJNaLcl1U
h9BJEAf/eeDwmjV/FSyl6fIe7qlINfYCE9CEaHUbl12MXZlEzgyMZAHy0DHbA1VH
UtqTp0Vs8mOwXPcib1/xqVocHIvSgnr38zSGBR6ZWiXTlgqPpJ/3txPBvl3DELlw
JDZrV9yQEvlDu/1hS1A0ecdFkjdqnrHOVRypk7ISFg9t94TlxJFmNxMXu0f86Tls
XtulpOyuLMEPlDNw0E0BTLkW0AlCi+qc/+1dPguUHiGeM0jTedi9cXLvSls2SU6P
QjYKegIzU9vRAGH2xm9ywL8emZNPFMiWD9uvWhOFO5jfEeKqOu7TJHw8ydyHHoyU
sH4foP1eFeHvfgYPw1SX3WbmcBWIoQ==
=fpaH
-----END PGP SIGNATURE-----

--bJCWGDMDCoajVTO9--
