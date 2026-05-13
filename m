Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E6CD4851
	for <alsa-devel@archiver.kernel.org>; Wed, 13 May 2026 11:50:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DF30601E0;
	Wed, 13 May 2026 13:50:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DF30601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778673020;
	bh=L+WNyyPimEuejnEt9e4ymClyQTw33Z6SfA3YJT7VkmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=URrTmMUVtF2WLWu3B31DuxhSzkFN+AgIJrG189QvfMX681+iy4KGpFF8yIs/4GSNG
	 1odQ40SdX3cTp+PJTFjD8DEuaeOoBb3G/d82koTWenEcXzwOEIBpMZ5PC+UpAbhAdN
	 tOFcJSI1aTRXJJ4CyWRLyocwlCskHaDVU2ZEI9z4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8585EF805EC; Wed, 13 May 2026 13:49:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EFA3F805E7;
	Wed, 13 May 2026 13:49:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29CDBF8049C; Wed, 13 May 2026 13:49:40 +0200 (CEST)
Received: from fhigh-b2-smtp.messagingengine.com
 (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 31B98F80100
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2026 13:49:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31B98F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=sakamocchi.jp header.i=@sakamocchi.jp
 header.a=rsa-sha256 header.s=fm3 header.b=DPH7sSyR;
	dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm3 header.b=HWCdPH2V
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 519E97A0187;
	Wed, 13 May 2026 07:49:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 13 May 2026 07:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1778672976; x=
	1778759376; bh=Ktbz3P96yXKRdsRD19ZZyzv1VKvzX9WEgiegms4WkXQ=; b=D
	PH7sSyRjnTKfKuMhQLtA+0JrwiD15/na/xtJTqOaOTqqCgBZtLFWzZZYU+y5jL7t
	B/h4AfZ1sZsLg5iPgOpa3teTMVc6+h3z2CIndg7Oal4U8N3/3PpcU/BBnORCSk08
	r/LUftE3OjROQ1i83N/WqlVMleAcu7CNyiFF/EjioU2EQC3EeWx8CVmwTUXNjehi
	UtizrbVvqaT20qp2t45v0dbNBcws5yG+cSXESxE908VKwjPJ5Y8nYgd4UQBpGR18
	MGPvguzK9vLRfbnpJyWpSKXDt3JwfUMxEnHFTG4qZcQxsEwLkpyxfRYZm+oiH8uW
	hS7HbrZfbeA8CryzX1AZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778672976; x=1778759376; bh=Ktbz3P96yXKRdsRD19ZZyzv1VKvzX9WEgie
	gms4WkXQ=; b=HWCdPH2VVCxnhW6jUpIYkgpK46aQ//n51baO5Gwk64DWgQPbfwV
	SeqGaYCujpYqp9JcaNtBUuGZwqxT+1kYFAU+PI84iStx2G/ptHDGJJklNGfBARQg
	5ECmB4i+9f4/P9gEY/e5oAyDpgZO75HU7n0CySq2K/4QI/3rctQGQV6YXQG1NdNl
	d483usVCpJMIpJBN1CW3L5B6hh9bx82zPVHxv9xt2rZ3aDp5YB5E3N6mGvM+KLny
	NIQaTUW0lJ/VISXqZWwFlkpyFC1iOQCf5MmtN2Udq8ys5ZVEPfvfkI5lVRGMqkzk
	u7BDsBmubmW9uJE8b/4Vn0r9gLyBCc/lpHg==
X-ME-Sender: <xms:UGUEahhjlT5yQMR-ZHlAtJU3-i1T6dTRfAkNcWMcfATXihRCWTBCcA>
    <xme:UGUEaiWubcim8AkgjbsD28oXLVXhPIGev9r98gHe4fO2UZFt2QzZ_aYCybS1wXrg8
    zib2ed3oR_5oYM3akXoXn5Oybryw_8zuu3uq5dcOJt1c_7eZRpEbgY1>
X-ME-Received: 
 <xmr:UGUEaj1tQ5BSKJPoGYI6YBj59YRrpkv-0nPLGFv1gkF7iDjvxAsJYpKFRF44g4r2gobryp3kzFUoMPSCGxZczhMcORn26A>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegheekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeevieelhfduke
    ffheekffduudevvdefudelleefgeeileejheejuedvgefhteevvdenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghr
    tghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhimhhonhesmh
    hunhhgvgifvghllhdrohhrghdprhgtphhtthhopegrlhhsrgdquggvvhgvlhesrghlshgr
    qdhprhhojhgvtghtrdhorhhg
X-ME-Proxy: <xmx:UGUEaoHwqXMVNpojePuaiugL48Q6dMPpAWXV_lkctDGGLKv3vdaY5w>
    <xmx:UGUEahhDpLbGPqVxIJ9_8rgZg61c7cFZn8Kd5DxupN9HrPyzMoW-Mw>
    <xmx:UGUEaj9qMiqf6M02H1zl8jg1JdA7Ri23RGeMRVLseql8_p6jGtBWpw>
    <xmx:UGUEaopUxsBcCydZZIVJRSgNBkZVoFiJWeNCI2WuFX3UuP97Cf6ESw>
    <xmx:UGUEaohuKiunfqX20_NXRbyylgfFsp7HP1S12iz9CClRpkZ1geuo4YWC>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 07:49:35 -0400 (EDT)
Date: Wed, 13 May 2026 20:49:33 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: simon@mungewell.org
Cc: alsa-devel@alsa-project.org
Subject: Re: snd-firewire-ctl-services: Digidesign Digi-002R - missing
 control for 'Optical mode'
Message-ID: <20260513114933.GB352970@sakamocchi.jp>
Mail-Followup-To: simon@mungewell.org, alsa-devel@alsa-project.org
References: <f33030cd26a3f65960481e437788a125@mungewell.org>
 <20260512021958.GA187077@sakamocchi.jp>
 <5703b1e2ef177e9efb204e53efd4a030@mungewell.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5703b1e2ef177e9efb204e53efd4a030@mungewell.org>
Message-ID-Hash: O6UIRXHRDBNU633H5O3ZFBEGIBHPZCWQ
X-Message-ID-Hash: O6UIRXHRDBNU633H5O3ZFBEGIBHPZCWQ
X-MailFrom: o-takashi@sakamocchi.jp
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O6UIRXHRDBNU633H5O3ZFBEGIBHPZCWQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, May 12, 2026 at 12:28:19AM -0400, simon@mungewell.org wrote:
> On 2026-05-11 22:19, Takashi Sakamoto wrote:
> 
> > In my understanding, when the Digi 002 detects S/PDIF signals at the
> > optical input port, it automatically uses those signals for the packet
> > and ignores the S/PDIF signals in the coaxial input port. In contrast,
> > the Digi 003 allows the system software to select either the optical or
> > coaxial input as the source of S/PDIF signals when both are available.
> > 
> > However, I may have misunderstood the hardware behavior. Please let me
> > know if you observe any behavior that differs from my understanding
> > above.
> 
> Thank you for a prompt response.
> 
> I had based my understanding from a 'fuzzy' picture in the manual for the
> Digi-002R. The screenshot appears to show a radial that the user can select,
> to either send ADAT or S/PDIF data via the optical port(s).
> 
> I was able to install the DigiDesign driver onto a Windows 7 machine, but I
> don't have Pro-Tools and the driver does not install a 'setup application'.
> Windows itself offers a 'properties' dialog, which lets me select between
> 2/8 channels and 16/24bit operation.
 
I don't have that either, so I never try it directly with the bundled
software...

> I have use 'bus hound' to record the coms to the device when the properties
> dialog is opened (with previously set different values). There are some
> slight changes in the data, maybe this makes sense to someone. I can attempt
> to record more, given some guidance on what is useful...
> 
> Yours,
> Simon.

Thanks for your effort to capturing packets. As a quick glance, they are
for the isochronous communication in IEEE 1394 bus. While, the
asynchronous transaction would be used to change the mode of optical
interface. The destination address would be 0x'ffff'e000'011c. There are
more offset addresses whose effects haven't been cleared yet[1].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git/tree/sound/firewire/digi00x/digi00x.h?h=v7.0#n63


Regards

Takashi Sakamoto
