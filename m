Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D867FC54E94
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Jan 2023 22:05:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30841A4C;
	Tue, 24 Jan 2023 23:04:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30841A4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674597948;
	bh=ZHq8B2Hnd3lqzLjoIA1kbqbJqNYmrOFHMoVPDe/yQEo=;
	h=From:To:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=qUn/Rm7mUPmhUqEBJrcfjUyNR8PyIqcHxVq4SBkrxUAfCSp99MCABVRjLs4dKGbU9
	 51gYWIxjD3p/pop8ZJq+End8kMKSGQgB3yehxNQUbGe+fjJPHf30TCtcMtmZ5Ata02
	 K5H83s5xXVy/oeBWU2oY9HDvn5I+QnA9r8snEi3U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C31ABF8025D;
	Tue, 24 Jan 2023 23:04:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ECFB1F801D5; Tue, 24 Jan 2023 23:04:55 +0100 (CET)
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44A4DF801D5
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2023 23:04:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44A4DF801D5
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=lwn.net header.i=@lwn.net header.a=rsa-sha256
 header.s=20201203 header.b=XhVGgJiG
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ms.lwn.net (Postfix) with ESMTPSA id E2B0399C;
 Tue, 24 Jan 2023 22:04:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E2B0399C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
 t=1674597886; bh=b9wX+EPKF8LMzFlBp7moLL2r723CGwKnPFthU9QqeaM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XhVGgJiGradEM2ZdmLm0ziXiZEPA1MeFVU+3tHp6jyu+gAlPOiGWwuN5s6Hm0pR+j
 TL/q6elhIhsjnDNmkiPH5z0k9rCxg8/D72X5dQquBgT5TsbaKFOxqbp4ummxkKeAI9
 2Y5LPFErpAMePR5Pu/so6zxaZxzaFIbefuTi6HnzlFhBQCnbMz9Z067NeZSDIEcwv8
 QpGYd62dmeQ+iqHaoMub7/eCZZIsZTlWlJ2NdjkFpMzVvC25OhsDAe5FwQB/9xKqvN
 yo93VfmGm2NXuR9Sf2cVLKtVD7DhwwbvlcecbhotAT1e6YHlYL2hoTAMJpUHfjZMyf
 WLpZhnTc0AK5A==
From: Jonathan Corbet <corbet@lwn.net>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi
 Iwai <tiwai@suse.de>, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v2 8/8] Docs/sound/index: Add missing SPDX License
 Identifier
In-Reply-To: <268823a3-f453-a38b-3fd7-500306675890@linux.intel.com>
References: <20230122213650.187710-1-sj@kernel.org>
 <20230122213650.187710-9-sj@kernel.org> <875ycxr7qv.wl-tiwai@suse.de>
 <268823a3-f453-a38b-3fd7-500306675890@linux.intel.com>
Date: Tue, 24 Jan 2023 15:04:45 -0700
Message-ID: <87r0vjfv2a.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>, linux-doc@vger.kernel.org
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> writes:

> On 1/23/23 02:10, Takashi Iwai wrote:
>> On Sun, 22 Jan 2023 22:36:50 +0100,
>> SeongJae Park wrote:
>>>
>>> Add missing SPDX License Identifier for sound documentation index file.
>>>
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>> 
>> Acked-by: Takashi Iwai <tiwai@suse.de>
>
> Isn't GPL-2.0 deprecated? It should be GPL-2.0-only, no?
>
> https://spdx.org/licenses/GPL-2.0.html
>
> https://spdx.org/licenses/GPL-2.0-only.html

The kernel community hasn't really followed along with that change on
the part of the SPDX folks; as far as I know, GPL-2.0 is considered to
be just fine.  There are currently more than twice as many GPL-2.0
declarations than GPL-2.0-only.

Thanks,

jon
