Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3852CDE000
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:41:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58EBD601EF;
	Thu, 25 Jun 2026 14:41:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58EBD601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782391288;
	bh=Fg4zLlVmXBqOTUbbss+KCEWbpgX7kv25EIqZLHKV2cc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=r0TWyEVot5FnS+LC+3DV/saz3nmnFSKHqJ8RuCPnAxbuL8fwszUxZ4vg1VBSc21Fj
	 6QS+HKAI9QYlDjEG+b58J5bjjkCDJXrLpQMyA7o5mpCg/DWGlFh7LeNISMkbuUsN3E
	 YDJ08wQcIx3jTmvFz0LgCvcLvqtK99BMzQdUqjBo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CD8FFF805FE; Thu, 25 Jun 2026 14:40:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 45746F805FE;
	Thu, 25 Jun 2026 14:40:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54500F80510; Thu, 25 Jun 2026 14:40:46 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1782391245;
	b=PPZsRIUWB27wF1QAIW2VwLvwyACHSHtOQYw+DuBebAadK5Nx0EVkJ+2cf2tYOA2BNXFK
	 SX53i+y2Qj5ToVp8KYxn6wHeVXa+ArZjT0pdoXnaLD2IvjlcANYLp54KupXIE/My4wYSc
	 Ox2/OndgTif3MrR/HTMEVf9un9s+IdsiIiqWRh5kN1A5IKmlX1o4EZKdvCJSOQ3isxbqc
	 rmh1Tv6wjHEPYw5BwM4q9K+fjkdedGqcNJosauCe2gW9sMiYi1IkCaOV1rQW0Q5ZGrMjb
	 b6MwnebgRsKp/fqOqj32SdiX9aHjUZG0gwYTnERy8H9Bx+V5myahYtXn3nCQo72J4ww==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782391245;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=Fg4zLlVmXBqOTUbbss+KCEWbpgX7kv25EIqZLHKV2cc=;
	b=ers2fKJo8XJPZvhoUZSjMFOclo9JDdIw2c1gjhr+tXsI+yf+mHoyFgeMhSD20OKvyncj
	 0/ogOhYsr4GMHq2yz7FA/IaTgxmXLY7owk8CkRokzNFPFahU0hqOC431LR96kymGEKk3Z
	 600OAniKcW5dyMkOyol4v0FVVDYi2JN2/2PJ8+K7mY8UKZ1JaVhrzY6H/RYx3zSuN/yXS
	 behir7sU0d1TtFYDiMM5g43p+m5LXKL35qAAoGlPWgfehJTei9by9uxgBP32+CjRjxvFq
	 IA0jBBTIJT/1yJ4xp1c4hPnJ/42J9RoYhIvzxPUJ8jKJXNIAAFCzIeio9ophtG5mPlw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7F01DF8010B
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2026 14:40:44 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 449663E13D;
	Thu, 25 Jun 2026 14:40:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 449663E13D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1782391243; bh=d+kB3dJMn9oJgCZeihcvD/dE7VY5YXZiDzYgRmxG4oo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SvQBQB+vEJZkxyo3rgxp3CkXq8XCAjziDGkp0xzeilk6r5Xuj7v6WsBra72f8hLkq
	 hhq+beGQ1OYVwhCXwDyuFu2x8VpUa0DTmMTDmdvgDkvwJKehCyOh/Wn3e73WlFZ+Zj
	 cqdnpIN9KF7qMdZ7x2Uludcj5QSw4oAwP8MQ5z1I=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Thu, 25 Jun 2026 14:40:37 +0200 (CEST)
Message-ID: <123fc447-bc60-48a3-a2a1-46ee9041e6ea@perex.cz>
Date: Thu, 25 Jun 2026 14:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v4 2/2] ALSA: control: add ioctl to retrieve full
 card components
To: Maciej Strozek <mstrozek@opensource.cirrus.com>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, patches@opensource.cirrus.com
References: <20260625120741.3404473-1-mstrozek@opensource.cirrus.com>
 <20260625120741.3404473-2-mstrozek@opensource.cirrus.com>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: <20260625120741.3404473-2-mstrozek@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: BCJ7PCW5MGHEXQSYD2ZHKC4ESQPRFF5K
X-Message-ID-Hash: BCJ7PCW5MGHEXQSYD2ZHKC4ESQPRFF5K
X-MailFrom: perex@perex.cz
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BCJ7PCW5MGHEXQSYD2ZHKC4ESQPRFF5K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/25/26 14:07, Maciej Strozek wrote:

...

> +struct snd_ctl_card_bytes {
> +	unsigned int type;		/* SND_CTL_CARD_BTYPE_* */
> +	unsigned int data_allocated;	/* size of @data buffer in bytes */
> +	unsigned int data_len;		/* in/out: actual data length in bytes */
> +	unsigned char *data;		/* user buffer */

I know that I suggested to add code to the compat layer. But it seems that new 
UAPIs are using just '__u64 data' here with padding to 8 bytes (I would add 
new reserved field and perhaps we may use force `__u32' type for all other 
fields). The code in kernel sound translate the u64 data to pointer using 
u64_to_user_ptr() function.

So like:

struct snd_ctl_card_bytes {
       __u32 type;
       __u32 data_allocated;
       __u32 data_len;
       __u32 reserved;   /* explicit pad */
       __u64 data;       /* pointer as __u64 */
};

> +static int snd_ctl_card_bytes(struct snd_card *card,
> +			      struct snd_ctl_card_bytes *info,
> +			      unsigned int __user *data_len_out)
> +{
> +	unsigned int data_len;
> +
> +	switch (info->type) {
> +	case SND_CTL_CARD_BTYPE_COMPONENTS:
> +		scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
> +			data_len = strlen(card->components) + 1;

The field card->components may be NULL here, also fix other uses like in 
snd_ctl_card_info().

		Thank you,
			Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat
