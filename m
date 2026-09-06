Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5739FC79F85
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Sep 2026 13:34:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE488601E9;
	Sun,  6 Sep 2026 15:34:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE488601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788701677;
	bh=H83rx5hytpJI2Da2J9AevV3ZZBneVMo6bHeDJNStW6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=b1PAxiaczGK187+B5FDY0EG82alA1pJJHhGZhXdBH4j7/sjqpL+xRgizsxaseYN9q
	 NuRdLW6NIkpy380ZQjZoDg2BUZtqWvZ1FmHRpJHdHSLGdstiK1UJgHfC98uARzBEI8
	 AzCTr+G9zaoYwifKJVGA1XpnNvw7ARmJS7ae/Gio=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4418CF805F9; Sun,  6 Sep 2026 15:34:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C0979F805F4;
	Sun,  6 Sep 2026 15:34:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B181DF804D6; Sun,  6 Sep 2026 15:33:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788701637;
	b=ek49cUU3BkbkC6B1wcAGYgfFQrZWw834xIIVzktK4vKftOordj/5vjIXqm7IGwPppg/D
	 IEQFrFuyD6tcWWGrH0frM64+NTtytelcVZEpyTmXnDzj1yWpWfaJp8XHgfIC/8Hz8q6IQ
	 xG6/CEzQ13CUWDij6SIcI1E3ifmJSQ/SSCGdxga42QBU+yZBSOBKvQOroO5JzOUa12vb/
	 GrqtW1ruB3EjGIvrSRAQmO+34MMOL5PK+rsERVhhGv/q+zzv8U6wKuNYNq9ApldUJjXYZ
	 czqJOP4ZGrhCEn/3t/6P+QazBP+xX67zgdM5zmeYkA7l916AAXgO1m+2jseyP5OQ8+g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788701637;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H83rx5hytpJI2Da2J9AevV3ZZBneVMo6bHeDJNStW6c=;
	b=WafEvS2ly7A7Gr4z42qe5SI5TH9z2SJLz2m7TcAfa+0jZwMvpgJhe9xVallVOuAUo2gk
	 A+ot+fO8pyGD6PA8qS9QhstKaWzIci1av5UyXRph1lbIbp+ndSZyFV8AuLuHXj/YhLu35
	 5Q9WaW40ltBGAXSejotZZWxoYZE0H3uoXDuBSJN9xQ2pgu4YJoU2AlThJDi0XajmiphHQ
	 Pd4braK6eJFMlqjiaCBmGMbDBZOwqny5Ey/lWrZhCwwUWjLYCvu14YTA/1H00ufEm2UVC
	 3WETiy1s8Ezmko6lsuOIr98D+Nmjbbec2FsCOCB5SXqlWoZD/7WN8vAjbwWCTRIaKkA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S+yUrOlv;
	arc=none smtp.remote-ip=172.105.4.254
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1C4BF800C1
	for <alsa-devel@alsa-project.org>; Sun,  6 Sep 2026 15:33:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1C4BF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=S+yUrOlv
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C23B0601FB;
	Sun,  6 Sep 2026 13:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5A41F00A3E;
	Sun,  6 Sep 2026 13:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701633;
	bh=/BNOQEleZQJDe3O6/g/RTocg+dUgQcOI7vorARbnV6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+yUrOlvd1k4HLEMtGygfnC1z6Vm9q59K5lJSQzqM/a97aoylNHkN21CHtiyCIE3j
	 gyP0SNqfMvceobJwJ2kSKuAZjYOWWMC4AxAag430yAxokMefk7aNAmKLqP3KRW4lit
	 lx8fir63XJiQiEPUlBANzSbtHM5g5ntca7YI5Tg5MGxHbS6u7VEUj7WrI/EV1oScfV
	 QePdZRGd+n0bdmsdQYGySFz4IVcIb+fJY2Xc7ANxV+ZYYnN+lfjHcH57S7IXD+h9Ua
	 RqAFYThslfUvv8XILXiskuiDe1mSPuqnF/jU8suYnS0UmYJWkvdq17gzwDA7QXQ9xF
	 6k21MPPe/wDNw==
From: Sasha Levin <sashal@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
Date: Sun,  6 Sep 2026 09:32:58 -0400
Message-ID: 
 <2026-09-05-daily-reply-0028-alsa-seq-port-lock-leak-6-1-ack@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904070349.80497-1-tzungbi@kernel.org>
References: <20260904070349.80497-1-tzungbi@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NYRGWAYU5IO3FC6S6KKB2I2JTXH24SCD
X-Message-ID-Hash: NYRGWAYU5IO3FC6S6KKB2I2JTXH24SCD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NYRGWAYU5IO3FC6S6KKB2I2JTXH24SCD/>
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

Jaroslav, Takashi - can either of you Ack this for 6.1.y?

-- 
Thanks,
Sasha
