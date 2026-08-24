Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B6C5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:38:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0B28A60276;
	Mon, 24 Aug 2026 13:38:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0B28A60276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787571500;
	bh=Nm2O2PQjOO3YZNdsxk7UTJH7sbGliAUfsjR3x4+l2fs=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=VfW1uAXXEkRqJxCe6ROh24At3WefqRpoOVHfn84RZRtN8f0MUEtGAhzXM1nTDgmH1
	 bg1gjlPsqkU7dbOLxYTMDAMmlsILaXMEP4jL1uspO2BqJ3Tp5QbLa1xBXLObKNCOtd
	 uq/+6dNRoAUMrtkrepEfDrHGoDmIuUfs5ceIhDRg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D16E4F805FD; Mon, 24 Aug 2026 13:37:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DE10F805F7;
	Mon, 24 Aug 2026 13:37:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8A936F805A8; Mon, 24 Aug 2026 13:37:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=77.48.224.245
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787571454;
	b=J96YpEHmfyL1H8C1gVsoe4G1OrMKkwX5zkwUWr59g7zoefqwzNzqZ4BHYFAMoqNZtAYb
	 lxBEPHHplSjXd8Yd9ad+7PnkGOUJ0Tz8BF9KlMgfPRz4OJ6VkALpr2X+4g8T27/CTjIPO
	 9f5EjQqASN5CXWDqe2gx2JnEZ1DYAqv/Aea0GMK8iO358IKOI8m7JqzYn+ADMu5MuQ+Rr
	 Us0xM2temzUWlM0/4acuWts+cRSbLxHXyAJ6P+esqZdukOdnyK9G4lJER0J03/1nhNLuN
	 X1TTzd2oGo/KS7OeN2AOjO9oQC0b8FNEDeITYgCONf1PVbyN+FoUO1HTdvCrYWULdZA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787571454;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=Nm2O2PQjOO3YZNdsxk7UTJH7sbGliAUfsjR3x4+l2fs=;
	b=H0mALEeo1I7MTm4bBwfC8OGw0Di3akXEQFnOFEQQ/SBQKGM4aGR4WvYp5SvDXMCDb4Ks
	 t17d7Q39+BXEKby1xRZ3jWAQvea2KNwIoQuBgd2STSHmVIm7jE3rK3q0LXPB+fFo8ql79
	 SDfl/Odb7Hrtj8ZhEjZ3vh1g10DX9iPL5mvqBAuL1IZ6ObfCtGFf5rRjHeCudBbS2V/P3
	 bj2qFfXmR0Sb18E2jVm70wY3rAN+pPKh/y8N6IWF65NmU9LjRV9ZHnZPp/sTVjgfd9bkS
	 x+MufFaFGcwEG7fyi3pSnXT4F0sCM6Fz7xcxJBB/Kr1pxH6SdSGsATnCbqfT7Ezc26g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=77.48.224.245
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9DF19F8007E
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 13:37:33 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4DCC340FFC;
	Mon, 24 Aug 2026 13:37:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4DCC340FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
	t=1787571452; bh=CrhxrPDaVWoRqfq9AnuAZ2jHRkoOEilsL4pqKih5q8Q=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PqUP0PHcVTF7JSm+C5ipPpGpvdtQ2seb4v0jIUHGKeJ2d/NDtWSW3xPBCF8SwTCoQ
	 SMo+NsJM8pt0uukB22JM3CFLts94uI1MS25tZeZY6nTNZJJ1+XE8W6p7vGiAkZdlxm
	 ibPFQDu7PnZQswfQMOW6y3zQSKdWVpjfetsoHjss=
Received: from [192.168.100.98] (unknown [192.168.100.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	(Authenticated sender: perex)
	by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
	Mon, 24 Aug 2026 13:37:30 +0200 (CEST)
Message-ID: <dc49d18f-4bc4-4d3a-9405-a43cad044e6c@perex.cz>
Date: Mon, 24 Aug 2026 13:37:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UCM: two devices that exclude a third but not each other
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 alsa-devel@alsa-project.org
References: 
 <CABXGCsPVLke4_j-FfGqTMN4tG88G5ckf13_xxKRe=j_w+sWTvQ@mail.gmail.com>
From: Jaroslav Kysela <perex@perex.cz>
Content-Language: en-US
Autocrypt: addr=perex@perex.cz; keydata=
 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
In-Reply-To: 
 <CABXGCsPVLke4_j-FfGqTMN4tG88G5ckf13_xxKRe=j_w+sWTvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-ID-Hash: ERGPBC3XMTFOD4LFYC6224OPGA3APQUG
X-Message-ID-Hash: ERGPBC3XMTFOD4LFYC6224OPGA3APQUG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ERGPBC3XMTFOD4LFYC6224OPGA3APQUG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 8/23/26 22:11, Mikhail Gavrilov wrote:

> Both list types are group relations, then, and a partial relation
> cannot be written. A profile has to choose: two mono inputs or one
> stereo pair. I have chosen the two mono inputs and said so in the file,
> but I would rather describe the card than choose for its owner.
> 
> Is there a way to express this that I have missed? If there is not,
> would a pairwise form be worth considering -- a list taken as written,
> without the closure -- alongside the grouping one, so that existing
> profiles keep their meaning? 
You can define multiple verbs one with stereo input and second with two mono 
inputs (mics) - the most easy way is to use Variant blocks to not duplicate 
configurations.

But it may make sense to describe this partial dependency directly with new 
list in the device configuration block (proposal). I am not sure if it will 
work for the current pipewire code - could you check to comment 
verb_dev_list_check() function in alsa-lib and test ?

Also note that your device naming does not follow UCM spec - see usecase.h 
header file [1]. E.g. generic inputs should be named as line. Labels on the 
card should be in comments (for GUI).

				Jaroslav

[1] https://www.alsa-project.org/alsa-doc/alsa-lib/use-case_8h_source.html

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat
