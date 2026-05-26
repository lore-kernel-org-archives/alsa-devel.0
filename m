Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C3EBCD5BC8
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 16:12:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDCA56024A;
	Tue, 26 May 2026 18:12:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDCA56024A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779811943;
	bh=9jEZbG5BFlDPJ26oe32JMl9RRNrcOL52l9eChmRbOW4=;
	h=Date:From:To:Cc:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=h5QHUrbiPZBimUyGkv49ZpGSUBtmjnqkrKZsM+C/Ls3Wj3wyx73zZsNNxmICMiIfl
	 U5ahKpsmfLXzAUb+n28gQHNZELaVwpwBOgI5F7KZYgJg0vgv5uyHxazPOxfpio3xZD
	 PSii2cu412nUR9dSAE6FHK91ebQpRvRDuAd9/u34=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8CE8FF805F7; Tue, 26 May 2026 18:11:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E1771F805B6;
	Tue, 26 May 2026 18:11:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9162FF80527; Tue, 26 May 2026 18:11:43 +0200 (CEST)
Received: from fhigh-b3-smtp.messagingengine.com
 (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 85A42F8001F
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2026 18:11:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85A42F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256
 header.s=fm3 header.b=oH1/dSwk;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=XWDHdhXG
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 020737A0165;
	Tue, 26 May 2026 09:08:03 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 26 May 2026 09:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1779800883; x=1779887283; bh=py
	F5uxz4RkLAT3V+tiZgOE1Rw9OuOFvu+VOssPg0Yg8=; b=oH1/dSwkbkweYlOej6
	A23CcKxxZ4KG3d5HO4tnJAhyfpJDJOiAFABzknPSCZpFALMPACMkm7baPOQQyrHz
	bDEtvL5dw4VcpAtkbm0ZvXJrW8KpJrRgFO2TiHDGVSoHRkEr10LbusuxIvt/mp1I
	aczJn+WLNi7TLhA0NdEHIvtu5ktwcA1HqaSJQ6mKETN7f7cqY6QuvOrJ3M8fATSn
	/+5l7ueHLGpDxkVcTLZj4Qk8NnUJhAA0bL3fVS1bEquosvHoQgJ2hljRqSNg442e
	vWdc0GE3wEy7hFb5A9Dzepa9vKopcF3YQ6jRcnF2qyM3fpC4b8CXZXk35PzoUKVo
	HHKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1779800883; x=1779887283; bh=pyF5uxz4RkLAT3V+tiZgOE1Rw9Ou
	OFvu+VOssPg0Yg8=; b=XWDHdhXG/aWzPiVKNd+uftQzOcM2MmbZh+h37n5kWK47
	uP8NGnEoBkVJuqG+JqTew8FpOJLvG2xW4n2AQ3M1tpe7VK2YhhkaabkwZb/LJh8B
	4+OPaFfU6BOS3vYOetPQX+j93A0foaHIOrjpQ0n6Jgu/We/Nviv0Xndf2ZZ7ye7P
	ge/4j19ml+zt05VrGm9SBh1JuditB6iScXrAqiP/dfTfSaEbpKnZ+4XJfCHFptCx
	kOO9YX9HR1vVnA6B/OBNEqOeJr7er/e7nvR00MW2u+ZgkaHLKAxhSrW8cYCaQXfn
	thgve7QHPdd5Q4oC7NeNoHCIUkOhqrceEjEGSi6gtA==
X-ME-Sender: <xms:M5sVaryXW7ISKaL2KgLr8mDgw5HmlZJMWsnVgYTVnE_YAHrCYQwbVA>
    <xme:M5sVauFWMQCv1RI3nEm-LD0EJ3nw_xaccXp64z-utgplJ0LsIOC8JT9lHco65Nw9g
    nfTSuKsaIv-RopROft7x4vWp-sIbSf8WRwwvh9VT4xSM6CNv_mR3gs>
X-ME-Proxy-Cause: 
 dmFkZTGv3LIH+WrebXZ+WGpxMmkb8KpR//2gMaqzCJfkXFPdz4j8s7gvHHm3U0gvo0fr10
    Za3cBqHHmKyN0DMYGXnx/1U5NheAarJdLJruPEj4gbSVhMi2MCgiLQvrZg1CCkmnGr0A2I
    BUUNoOw2o9tZD5pCF2ec0Fe0JIKpH6i9HA+FumhTfrkdd6QXQF6AJPlxGo0WtXNrQFsdau
    9z8Fvwa2/6g4xVXfoMhXSOFrOAWAQYj5bDk/qhbc+GNF4BWk3YG+rHPiJ8CyNKnqSXHlvS
    fdt0nggR8m54+XDAjxHI+gXRPnGXo8MKKuGla2opxuAXe7DR5c1Uewf5+X0sG/RGFPSXk1
    m6CxPI+kfTFJzJ3KRyEvSlGTnJH29+IyIM/0bRCjWJfFeG2sMtvWHSWJV60BgQgx7KXefj
    eD59lvePsq/cU1kyCkvHaTj9gnYrobQDBBcIY054Y9oyMyURjlbLZco1GZ0y9SYlKOx2EV
    9ogKvaDXNBVSLqnLzvxbSNboLwXbgE4ntUikiue8Z/KdcSmLIRijf7b9Y6200uBGUH0lef
    62hqO0a0ptK6Oqkjj8dPOdbQq2wVT2X/Ahsczjy4g2Wj2z43UamJckX52I6V3pJxjW/S5z
    yR7TNWmFSSnGfSliy3svCpGb5ODvBvojrzfoBv62G4DuzL41g0L/xf25f2yw
X-ME-Proxy: <xmx:M5sVavdFiiyQXGOf3i1KeY0w_ap3X7NbGDb5dsOnVISGkBNNRLtpVA>
    <xmx:M5sVaugjXcdrOAFvFUTKOFrcE7_JupUB1XlHNlcbx6s16Q67iweQnQ>
    <xmx:M5sVavyIQEEhOY90JTiw3lwiIUnDDCN4Co_X0-F02qx21MX74ZeI4A>
    <xmx:M5sVaiPaDCOQm_mbO9qNfQuDj9ZfTWX_ZPce6XklTBIJy_W6_nryIA>
    <xmx:M5sVatN6wCiDo9bFwJlkL995qZXoFwi3wWtTEFhq5db81bb9ZOOBJzmw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4BEA0182007A; Tue, 26 May 2026 09:08:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Tue, 26 May 2026 15:07:43 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Syed Saba Kareem" <syed.sabakareem@amd.com>,
 "Vijendar Mukunda" <Vijendar.Mukunda@amd.com>
Cc: "Mark Brown" <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org,
 "Venkata Prasad Potturu" <venkataprasad.potturu@amd.com>
Message-Id: <21a54840-a7b4-4802-9b40-2c92893e862a@app.fastmail.com>
Subject: ASoC: Build regression for snd_soc_acpi_amd_sdca_is_device_rt712_vb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-ID-Hash: QW6SQAE6INTVVLCNQ7TSMCBPKLBGOO4Y
X-Message-ID-Hash: QW6SQAE6INTVVLCNQ7TSMCBPKLBGOO4Y
X-MailFrom: arnd@arndb.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QW6SQAE6INTVVLCNQ7TSMCBPKLBGOO4Y/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

I ran into a build failure on linux-next:

CONFIG_SND_SOC_AMD_ACP=m
CONFIG_SND_SOC_AMD_ACP_COMMON=m
CONFIG_SND_SOC_AMD_ACP5x=y
CONFIG_SND_SOC_AMD_ACP6x=y
CONFIG_SND_AMD_ACP_CONFIG=y
CONFIG_SND_SOC_ACPI_AMD_MATCH=y
CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS=m

x86_64-linux-ld: sound/soc/amd/acp/amd-acp70-acpi-match.o:(.data+0xf00): undefined reference to `snd_soc_acpi_amd_sdca_is_device_rt712_vb'

I usually try to send a workaround patch when I encounter
these, but I could not come up with a good solution.

Please have a look.

     Arnd
