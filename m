Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143BECD5BD5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 14:07:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92B1760276;
	Wed, 27 May 2026 16:06:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92B1760276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779890819;
	bh=XJPwr4ZFy97xrih3wKlZA7216jbHSnL5igC7/2KkltU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qi/oy6RArFnP0jB/RS0K9np73q6rxrGq0L2rq0oNKdHiuzdYVYlvry/19mDbXRLxx
	 ARRLIFUtSaX9pHeJF+JJq2X16QmLFVQnIejFHWhMQJSJIuXq+7y9mqnqztJTV3p/si
	 nRf4jVrNfuJUmi1vX7KxFstSkU1zzcirU3IDA/tI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8B613F805F0; Wed, 27 May 2026 16:06:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 32A8AF805F0;
	Wed, 27 May 2026 16:06:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF5C5F804FF; Wed, 27 May 2026 16:06:18 +0200 (CEST)
Received: from fhigh-a3-smtp.messagingengine.com
 (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A02B7F80087
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 16:06:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A02B7F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256
 header.s=fm3 header.b=W3NtJ390;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=Kl+W3ETU
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 51121140014F;
	Wed, 27 May 2026 10:06:10 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 10:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779890770;
	 x=1779977170; bh=cOUAXa1+vlptGEpsXEvGCoEKNRYtmdXqwNLpAo6IPlc=; b=
	W3NtJ390FrnARDfK9yM5JD0uNZxliiZT5+304LqPyoP9EWN/eGafNe680XLOLwM6
	SLba7YQgDoo3LX+bRVn95ItyGd057ZTCQ+UAqnHmIR5Riq9Bbm1t9AaJSxBrU3MM
	n638NmAMMvaEC5rm42Iqd6hBDjx3rfDitpB4XRot6fQJ5RsGq0tGtFqMMg3Qa/vN
	R9ybz61Q4yQweZHil5crwccz2Snr5fPcqhr30BkRsiD9NQnQpouZaxhfT7az0+Xa
	+8tmpko+XIuiyEobdhPRZdM9kKHZe8x+2Apj2aU5H/I9a4cYbCncoOtjBFWKnY0t
	5XYlke6QATNtoTzllbNzOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779890770; x=
	1779977170; bh=cOUAXa1+vlptGEpsXEvGCoEKNRYtmdXqwNLpAo6IPlc=; b=K
	l+W3ETUZjyC17Bufw4bFbyrRPvOnUIIn9mamgMLkU2gi97bHplI6FUSFqKpgH/np
	Iku5SjWt9vdFpi/vOB7+XgGsjCNvESohxK952UGybBe7KoG/laGT/JOJZfDlSqwP
	lVEMtRyhDkui2lmKiD/vgY8FT6u2JwTwtsqCbrpFehHB7eBQikjwy4h5qnfqQQ2w
	C+VrqJViNAJX9DcJ+u2QvivBsFU6AsmgquX4LdFINNt6bL9asBG56PRB63xnwe9m
	EUl0V5QboNC8kk5tzEE8x0JxKTopOPGzsdlhzMrwdhA9/A/WDib1lXmlG+ecyWJP
	zin5YVe8Xu0UDU+eTysMw==
X-ME-Sender: <xms:UfoWauc8tzqsiI1nAyWBMfUVDn7GTQKholMI0r5mctmNRzLbQf_UPw>
    <xme:UfoWajBMP_PL_HrqCwZakBERa0wI5BLTVTuUP9wEtt8QOm0SGtPRzPlvHPOEURX4T
    6PUd8mJ05YjDZINxazIZlyg-DwJ1uiS-n7UoRNUbz0aHQntbUZdmiA>
X-ME-Proxy-Cause: 
 dmFkZTFg/ntQhuNYlt688Yrf9CAmF7YkzSCYqVw6r+eWzspt8zjO7gCuWEC5T6I4clBcKj
    EATjbDLHpc4tOWMmOsGqWxgYAjVCR4vNGnfdvdtCV3O3ERZZ69aDK0CXmvGcIcQ6S4FB4K
    IA3FFs8BnGUw2brmtI4XEC9bqJKTLTqvyaKkgJ77psK1xhuoKMPQ785+ThTDCN328KYBhT
    P5aI3UScMn0iAfOQfsFPJ37JPdLJyPdPh5+mTL+XX5EZUSBkK6OYb/KKYsWTIgiY9NEc7D
    PNyDWsMcW3xNScQOdKSLGCY/SbtVR+tkEyXQIjTYGd/JrBP7AB0arM2x6WCDqgw+/NIDFq
    WG36Iv+u7kcndWruHcFhMziZUZiGjL8J7KIAwImLx+Dv34ZAwtlLJMDZ27sLPl2yRUeLRB
    W1Dmk893zu1fQjsmMmvbzzee6L6xwGQjXWt25nd/CeePasOdkS+o07Q0uUEIQt0eUQZcZk
    NSuBsTw1paiaOcyjWLU3dlEILb4N0svUHwQzkzFk6x9oj7Qh89kenooZT0HfTkCCkcYecB
    Ik9SpLRRzTzt3stGzvl9ZsKL4UznfG1Y/ffGSufIFHEz8hTujsOraYu5ygCBEkz3Q1d+CD
    iqW9kFh0GCMjt6t00n0InFlLpCzxRMIyaRlDJQY4BudNCUynannQEB/8hGtA
X-ME-Proxy: <xmx:UfoWah_p97FHgkuIrzrQPP8JPcxlN78U4wmC5bkaySvI9g5wMsbmLA>
    <xmx:UfoWatITZv7yqUnC9Emt0igYvpfRvyXDhvXbT8YBP-rnPOFG9JK75Q>
    <xmx:UfoWasYkW53wdKg7SFf81EAZAnrrS6Y4dN_3skIGFkn8iJfPGBXSwA>
    <xmx:UfoWavIPK2YH1oE8LNvoY3CGhGv-T8uIvxQvT0V34qUOlxfhuznOjA>
    <xmx:UvoWagJDUYYS1SsGniDPALW3PbtV5tZ0vq6LX9TKi8Xt_5596T42BbMu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D6A61182007A; Wed, 27 May 2026 10:06:09 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: AUoS8tHvkyh3
Date: Wed, 27 May 2026 16:05:37 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Syed Saba Kareem" <syed.sabakareem@amd.com>
Cc: "Mark Brown" <broonie@kernel.org>, alsa-devel@alsa-project.org
Message-Id: <6d055b0b-ece3-4cd0-88a3-5466246a3151@app.fastmail.com>
In-Reply-To: <e7dafc83-c3f1-40fc-8419-96e2332a1ad0@amd.com>
References: <21a54840-a7b4-4802-9b40-2c92893e862a@app.fastmail.com>
 <b2b4c830-6f94-4fb7-b5ab-71a6889dd96d@amd.com>
 <e7dafc83-c3f1-40fc-8419-96e2332a1ad0@amd.com>
Subject: Re: ASoC: Build regression for
 snd_soc_acpi_amd_sdca_is_device_rt712_vb
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-ID-Hash: INPPQLE6HU6NZITETCQUNHNNG7EW63IB
X-Message-ID-Hash: INPPQLE6HU6NZITETCQUNHNNG7EW63IB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/INPPQLE6HU6NZITETCQUNHNNG7EW63IB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Wed, May 27, 2026, at 15:56, Syed Saba Kareem wrote:
> On 5/26/26 18:59, Syed Saba Kareem wrote:
>> 
> I have sent the fix for above reported issue 
> https://lore.kernel.org/alsa-devel/20260527133208.3074614-1-syed.sabakareem@amd.com/T/#u
> My apologies i missed the reported by tag as it is asking closing tag 
> also.
> Should i send a v2 version please let me know.

Sorry, but that is not a correct fix, you just replace the
link error with a silent runtime failure, which is worse.

Please have another look at fixing the issue properly and
send a better fix.

       Arnd
