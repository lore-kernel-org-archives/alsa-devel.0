Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20061CD6E5D
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Jun 2026 18:22:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F35F46022C;
	Tue,  2 Jun 2026 20:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F35F46022C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780424548;
	bh=MVvTyIxkIW8kafkuyeT5yHAst+40KPSzQdu4O/gvC9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=pjRRaTT6/qL2A98lnlptIOGOvjpfuz1ZraWga6YLQuPgzRm145MP1WaMBOEyrYDb+
	 PqH9PEGSbB1o/T732lEwkFbt3t7QKjnRImA3wVDfhVxTaXswibNeUOIIdY0q0Z+gOr
	 C0vRXFa6Er1vWIl6GhOPBGiMIYN00orY9eF+Xtfw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0D2C1F805F4; Tue,  2 Jun 2026 20:21:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 81A9EF805F8;
	Tue,  2 Jun 2026 20:21:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65508F80553; Tue,  2 Jun 2026 20:21:49 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 70C27F8016E
	for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2026 20:21:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70C27F8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gqZJnlZv
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 32D184349E;
	Tue,  2 Jun 2026 18:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462CB1F00893;
	Tue,  2 Jun 2026 18:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780424503;
	bh=MVvTyIxkIW8kafkuyeT5yHAst+40KPSzQdu4O/gvC9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gqZJnlZv3bckkg9Dt92RNiAfLTrHP3vWDQ2z8n8uMzGWhVzcaOrCgFKgeldrisGyl
	 H+BGMAnNdB56CSpfdrB89jw8W2kyBE1/nmSK/6rTUUuX6IYaW0YTus0Ph2juxASq1d
	 7nKkTodDvc8woZAM17rA7InkP0WZ+agGVL9N1OAFfK8Rw10qW0sVijwUILh4y8A0E3
	 mS4mNFuvtJrnzAjiLH9QEnTMfoHwhwvMo/imuzmzcqv8BjcOT6JXtpsT3d0p9Yh8O5
	 pV5YZUi5RtIcMMfrg7iPYfd84KeGFgH5Bu/+M6v5ydJCb4FD4dONntx9K+6otGVPjc
	 jm4Z03LFXbNMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Vasiliy Kovalev <kovalev@altlinux.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH v2 5.10.y] ALSA: usb-audio: fix null pointer dereference
 on pointer cs_desc
Date: Tue,  2 Jun 2026 14:21:21 -0400
Message-ID: <20260602180900.alsa-cs-desc-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260531152950.191924-1-kovalev@altlinux.org>
References: <20260531152950.191924-1-kovalev@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FF6VBRJQP4WKTB42OVDGEUTC3WFSKURH
X-Message-ID-Hash: FF6VBRJQP4WKTB42OVDGEUTC3WFSKURH
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FF6VBRJQP4WKTB42OVDGEUTC3WFSKURH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, May 31, 2026 at 06:29:50PM +0300, Vasiliy Kovalev wrote:
> [PATCH v2 5.10.y] ALSA: usb-audio: fix null pointer dereference on pointer cs_desc

Now applied to 5.10.y.

Thanks,
Sasha
