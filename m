Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A10606A32A
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=O6agcXGX;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U54R1lZQ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5291F601F3;
	Mon,  9 Nov 2026 16:54:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5291F601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794239690;
	bh=0gGKVcR45gUqEzgkuTsybkN7hC+ywnclcOb2QQxyQko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=O6agcXGXJTWE/mZHZ3gTQC5Wa/k0kVqHnrZ2QUHkxF0h2LKfUkcrtpzQvLS3+at2d
	 rxcLJSyNfkgh4SZn6pMsngP69pIhGC02+/IOu5isg05u7/5LkzcZvUxTLKb78/+0B/
	 a12a1/JBIBw8zGR5JwI84qyjK69tuaH19XskQl5U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74D84F80604; Mon,  9 Nov 2026 16:54:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AB791F805FF;
	Mon,  9 Nov 2026 16:54:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC391F805C7; Mon,  9 Nov 2026 16:54:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794239649;
	b=Lobf8+vTn+UzC+5DU3F8vRlhoH0lYuKy1yAOcHlMNPnatOFUpeIsgLYqhotso26VWz0Q
	 1k3OrD7Tj8ogVckhzeWASIIX0LVrBXpPSv+7fY6KxilCArpTZDMqj7UZGVaCT7KTfVhhs
	 kdqNk0S05sccmPBY0LyJcGGFDG7BhRUyOG/B0cdHPPRRwdN/TrjFEB3QmKnRGXhSm3Pw5
	 hbNeMJjYFIxgU51R9dnjpYD3/4p9cipZWIh1h/m7/y+b2PafewceTBIg1jKFqVltGt8oc
	 TxJzq/Hg0TUv+oHz+4xLDFSraB5yh+Rr/F5uLQPQyNQf37YQAKRoXT2OjhCpqGoIhng==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794239649;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0gGKVcR45gUqEzgkuTsybkN7hC+ywnclcOb2QQxyQko=;
	b=mH2ubC7PYzH5rDLfk+iqYD8OizEOBO7b2D7CpLp8DerqtQVlx4SiLAAVDFGrHNA4jY26
	 AIMD+i1kox97TBeM4QARXAu7Oy3qSimheOuzLyoJOJwTWb8nX0gVGVVEHXWIc1vwkjOsx
	 gfh4JyvhMnm4KMEUIDM1/D447sT66sEyEtMeZ2clv7sIUi15YfuuluUVUy8lj1OB4aCYI
	 L62TzheD1o86LD0rV1tO0Yg5aPu8eKEaQFPejsBU5kzcAVMzfm73lXNAwL7fKFW2daHCA
	 zonst6O85R7bShAJgshrPZ2pzxG7RGonBMCgyJM+r6tDEQEI4rWsghSpN3ed0sJHWmg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=U54R1lZQ;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7E539F80124
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2026 16:54:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E539F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=U54R1lZQ
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id CAEBC63408;
	Mon,  9 Nov 2026 15:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D011F008A5;
	Mon,  9 Nov 2026 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239644;
	bh=BdOqqC5U+uZcc06IUzEeh0VywQwMVK3RAKt+MwEmFdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U54R1lZQeHNPbfINKaao2TRdBsSTs2dYJMAGRuQqOlbCYuBZ/q+bWcPT1sggigqBL
	 BZYa7UpptPAEKv4P3KEdjV+rriUJoMDKZuki5lgwACoV68++2OPG10qc1UNj0SZgyi
	 tVsXP/7rIZPXdMYF6guhUqkaWwn35YsmrUqFfTa3EaAPXJ0XDqqiEx2k2gn0WYTvFb
	 fLFtJNau+vJGQsxwtO7rEftIA86Io/3u7diEguaG+w0gE+0QpxR6GT54sHYGlpeSSO
	 qTI9OKzNUcRm3aONY6U5NP6ok+XIoXfjgRMofWN6EaUINe3Nkleo/mCyPImYkDvI0w
	 hjXNeVKCEIcxw==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [STABLE v6.1-v5.15] ALSA: usb-audio: Don't try to submit URBs
 after disconnection
Date: Mon,  9 Nov 2026 10:53:19 -0500
Message-ID: <2026-11-09-1-daily-reply-0037-alsa-urb-disconnect@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109090346.2098226-1-lee@kernel.org>
References: <20261109090346.2098226-1-lee@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VL43YNHF7IIFYTMGNWYMWPONFKKO2KZV
X-Message-ID-Hash: VL43YNHF7IIFYTMGNWYMWPONFKKO2KZV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VL43YNHF7IIFYTMGNWYMWPONFKKO2KZV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

> ALSA: usb-audio: Don't try to submit URBs after disconnection

Queued for 6.1 and 5.15, thanks.

-- 
Thanks,
Sasha
