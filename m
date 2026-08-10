Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9BFC5AD55
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Aug 2026 23:58:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56BC160203;
	Tue, 11 Aug 2026 01:58:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56BC160203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786406324;
	bh=8m8zR/hrcP9bRXfE/BVR+A21+Z69W9PqeXZzWIwQJ9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZtxkZwYg+J9P0qNp2KBHGNWAnDuGnpTumHvIsh/pDhv6OMm3tSaJB6zBNqeyxgd1I
	 BIxYkSDAKVPgsaaCrAxe9B8u1bjQ0O4+ixVEFtKtDK9Rz+ABBH3PQ3ojbEeVJ/s4YX
	 b5z1+WVkTdQujwvNlnvTUVTlEyKwq6GXx5bQ1ncs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9FBDAF805F9; Tue, 11 Aug 2026 01:58:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5441AF80600;
	Tue, 11 Aug 2026 01:58:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AA892F804E5; Tue, 11 Aug 2026 01:57:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1786406277;
	b=IDmcCWvdOfXsNWJGSQ5Tydw5UqRgeUIp/5fprfvJWvqxQ+jiyTyeLmweHS9e3dy5lGZa
	 nfsYiWl4o3cN3HN76xANcmLjVLFVaXSWKgwPnNHYFJPb30GC/aLQa2sSKbciAJ63di5Fm
	 yuJ2LIQVQ6OEyzRrP/gJjPfFa+/QZg0Sdcd5fZLb+GFzV0W3zG3O1a9rFubnp68yaaHFB
	 nlwB3NxcJeiAd04He1mDweGaIe1owVm/IvCaUbtjlfGlZUmPIZfudRHIJCvsrYRc7ihZx
	 CRHk8sXY3WERX62QlP6jQPYnxMM2fYv64DyNxrMxUuvqrcQ6aeS0ZGg1EmpRCgR8ZkA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786406277;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8m8zR/hrcP9bRXfE/BVR+A21+Z69W9PqeXZzWIwQJ9M=;
	b=E4NFHqTqCRYI6HoKf2eE93MOBS2YZWk6t1dVTfweSufoPtbDVxjBCg28B8yrEPEgSedp
	 CJj8mnckeKBEjDagk2p81wcFgi37P8GNp12tNZ1FH6mwTv5xYlAy98265L0KM+sn11yut
	 78TRMdyf2GNd2333sfRfxJtZPzgALCd0TtRd7R+rzjogaH2cZ8nFQaIVCO24m1WXH1cM8
	 7pY5fyDL7nUIeesjfXiuUJ+vT1DBL0VfXvKAmIVMcxULyVSbZIDWWNP5M1awngZnhKdz1
	 oaH89uB2h9665PKAHHHmzB9dUNhDt3yZj2Spv8ezNoezEtZE/jCpbVcZKvYeiDJWwRA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b="ZmMrn/Pt";
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 18569F8010B
	for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2026 01:57:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18569F8010B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZmMrn/Pt
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 93A166001D;
	Mon, 10 Aug 2026 23:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB791F00A3A;
	Mon, 10 Aug 2026 23:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406272;
	bh=TuHnFnKe0k74CCFUMasplilnjb2cxxwgWt2EqAwnNaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZmMrn/PtPvxDBS6rihRadMgn8VCsVAx+pdtQ/bUPFhoUJbJRNzVIz9FjpL02CPU6X
	 gY135ux75dR6qNHkqsgC2fNUEnC4cYldk6Oj51OUS3584uSHuItAuB+L23L6cebJ0w
	 6KsGPAp3rUav1WbCXvp4c5ACAejROAhMvc1Xx6zr41H5a895a73oJdOYAUBOSkSWeQ
	 wKBROeFrBtFcj3tr/I+8qyG8RMQs5X7o7PwxJ2sQU2/2Pk7FKZ2dfV8QD1uRuZEVMB
	 I0fUc1HGSTMEOqOyVq2JnTAo/C83mMwz6EMDfUri+whAhu9oll0WpYbx0MTfAALXUI
	 uksLIrNcO5FWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 5.10.y v1] ALSA: usb-audio: Evaluate packsize caps at the
 right place
Date: Mon, 10 Aug 2026 19:57:41 -0400
Message-ID: <20260810234738.0002-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809074320.1407-1-pzqqt88198@gmail.com>
References: <20260809074320.1407-1-pzqqt88198@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XM546PLS65YAVXVDXAR5TUEP5C7BUM5D
X-Message-ID-Hash: XM546PLS65YAVXVDXAR5TUEP5C7BUM5D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XM546PLS65YAVXVDXAR5TUEP5C7BUM5D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> @@ -953,6 +953,13 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
> +	subs->data_endpoint->packsize[0] = min(
> +		subs->data_endpoint->packsize[0],
> +		subs->data_endpoint->maxframesize);

Moving the cap into snd_usb_pcm_prepare() is the right call for 5.10 - that
tree never computes ep->maxframesize inside snd_usb_endpoint_set_params(), so
there is nowhere in that function to move it to - but nothing in the changelog
says that. Please send a v2 that spells the relocation out in the commit
message, since the diff no longer matches upstream.

Two other things before I can take it:

- The Signed-off-by needs your real name; a handle does not satisfy the DCO.
- An ack from Takashi on the 5.10 placement, he's already on Cc.

-- 
Thanks,
Sasha
