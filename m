Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3913C79F8C
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Sep 2026 13:34:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 11C826018B;
	Sun,  6 Sep 2026 15:34:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 11C826018B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788701697;
	bh=wc0SDDB7/GPLQafZAE/MDaXhwUgBUsZsP9JhFdtQvrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qxuPX57yQV2qY3J8fh9RVsUy4E8bRC4cU5Hk1qp6oymeX3UrZFyUSNV8IYNLNtXzR
	 qvxcgYt5j+g1Ha1ENl1bdFNMsP0YWc2EWN0wFyuDMqwXUimEvCPzW83tDk/q5NsBSN
	 n9Kgy6qU35zSiep1U8jAeIFcV1adIxzhBHUuixQM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42FB5F8061E; Sun,  6 Sep 2026 15:34:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C337F80621;
	Sun,  6 Sep 2026 15:34:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB587F804D6; Sun,  6 Sep 2026 15:34:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788701640;
	b=kG+oaUeoYDUAZMY7MSaQnFVJ8XFukk3UvS1n97n3WNRNOV1uxW1dlvfjq8ABdpAuvOmL
	 tww5DrP7MBV0jKmHUtJAP9CSJUm++yHzC4u6qVR82XFCA/hPjETvxWm2LQc2H2WZjI8V7
	 5ij1n5Mja5Zf88lq3Zy67CqNqIvMeiL3gz9J2zrkg91C2QeuFQjJadWUKrDiRwTDAv1aR
	 QxxI3aAkkp6wIWgT5n6h/SZQwz7jbN8r+nsvTuwAGyZrsiBCtl4f2NXTW65KeMGQSMZQg
	 FTg81MbcZUrhoHp4+NbSR7ZWEEkrmQErVFfbkWjDIjjmqZ6UvZQKaKHZxx5+wcugBGQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788701640;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wc0SDDB7/GPLQafZAE/MDaXhwUgBUsZsP9JhFdtQvrA=;
	b=UGgfD+3QOq/YDBhlx8hF4AE4+ur7nmWhwHeYbJ/LBGEVr2FtNZLyIzhX9LrTq6Eeg2iQ
	 tjBatrMo+0++7HwgRzpjvhkyCe4OoKF4VLiBJVev2h6WQE8w94hWfdkDa49YKPcCNlPl4
	 ua4WvWGzY19vnqp8CQX0fTOIpzSnZHITbUia/mVcV8yYeYQEYsMUVB0qqnR+SI9ER++Lm
	 As6b6Eg0v3FXYYZ9Gn/MX7zONRBgxHCMa43nSs5JUW7xZpjh0UObmpX8cu/3Cl6H0ZKNF
	 35pT/x2vQ1HI23tK/4DaG4mNoAwtd1jnh6EcvBvPz208xbyfD2ErWfo7W+pIAmlfcEw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MCbY2M09;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4FB23F800C1
	for <alsa-devel@alsa-project.org>; Sun,  6 Sep 2026 15:33:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FB23F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MCbY2M09
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9CA5E41607;
	Sun,  6 Sep 2026 13:33:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EE81F00ACF;
	Sun,  6 Sep 2026 13:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701634;
	bh=Sz25b/aL+MzWydrXVb0NZbqhEZ4m/17DNpfDdfyZCAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MCbY2M096C/0bgfvPN2cI7xeysD56DaZFCQC7tzCWobfqDbp08ACxCRQneh6aSqG2
	 +cqByogdoKcWtGO6aPBDjMOkjIAFlOzQoI8k3qvscGAS/1E9LjD+Xl7PuKKPw7wvUd
	 U5fck6rYpaklK1blUyCj0RelU2D2r5lB+ZPZTXYonCb86JEx28n8cJqvYG6hhmxit3
	 8daa9tR5euq+H2Xgr8+srlQN7sXPAvtSBk9s78xNHOOeea3uD8w8S+8NGa+CwQT/HR
	 bTVNgUFZbR1Y1oBw6JjQ7tEOe79VuqPwUHjOzQNAhT7Ygn+3NMQZQu5M3aEHcJ6YaN
	 MB/TSdGnq+RhQ==
From: Sasha Levin <sashal@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
Date: Sun,  6 Sep 2026 09:32:59 -0400
Message-ID: 
 <2026-09-05-daily-reply-0029-alsa-seq-port-lock-leak-5-15-ack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904070409.80648-1-tzungbi@kernel.org>
References: <20260904070409.80648-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NO7Z4UOTUZIJCT3JIFJPLPQBG6VWLXHS
X-Message-ID-Hash: NO7Z4UOTUZIJCT3JIFJPLPQBG6VWLXHS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NO7Z4UOTUZIJCT3JIFJPLPQBG6VWLXHS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

> Commit 46397622a3fa ("ALSA: seq: Add UMP support") mistakenly removed
> the `snd_seq_port_unlock(src_port)` call in deliver_to_subscribers().
> As a result, every time an event is delivered to a subscriber, the
> source port's `use_lock` atomic counter is increased but never

The fix itself looks right - restores exactly the unlock that
46397622a3fa dropped, nothing else touched. But there's no mainline
commit backing it (the actual upstream fix would be 177ccf811df4, which
is a MIDI 2.0 feature commit and not stable material on its own), so
this is a stable-only fix and needs a subsystem Ack before it can go in.

Jaroslav, Takashi - can either of you Ack this for 5.15.y?

-- 
Thanks,
Sasha
