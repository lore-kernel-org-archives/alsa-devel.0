Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7943C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Dec 2021 15:10:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DE2525FD;
	Wed,  8 Dec 2021 16:09:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DE2525FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638976200;
	bh=92NCpiZaI1RutQBZ1qFx0ileeYSXRIbCuKINZ0tlDT4=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ld/0d76bulZkmc7cNwaDkOKLOEDHd/u66C2hWnGQ66ez9e6HCvYuPLcUrkpI+qWuC
	 TmeIreJsd0frRvsa7zscrxchxZuj/C7QEl4I9KjqJoJb0zHakIT+qzI2pW7+gKijm3
	 bP14uc48whGqcZ4FgeK4Krq3XSsi9NlqEy88CZmo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC29CF80217;
	Wed,  8 Dec 2021 16:09:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DD587F804CC; Wed,  8 Dec 2021 16:09:07 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6D41F80103
 for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2021 16:09:03 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id DFA9CA003F;
 Wed,  8 Dec 2021 16:09:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz DFA9CA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1638976141; bh=nrtvyjpGAxDRmxeQgYzsd/gcWTwotzi5zeywwKqe7Yg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BniNisZLZpQYz1Gqzb0O/zDefSsgedUJmJrJF7Tf6E8YO1P+HfrEydGwrvxlxmMIA
 Z153/c4bWkz06Lc0zVDpUFRpUx/Vb+fzNUycyTwPyJjQE1ji2mBLraBk1Vqsrid/7o
 aJ9zeXfwtO9tNxYvES9WAyYhRf+j26qsf/s5+e/A=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  8 Dec 2021 16:08:54 +0100 (CET)
Message-ID: <f29f94f3-ee74-a5a6-746c-9213905bb607@perex.cz>
Date: Wed, 8 Dec 2021 16:08:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] kselftest: alsa: Use private alsa-lib configuration in
 mixer test
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
References: <20211208095209.1772296-1-perex@perex.cz>
 <76f28e78-0e9d-45ce-96a3-5c36f880ea6b@www.fastmail.com>
 <YbC9yxBeYdcQ9j9d@sirena.org.uk>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <YbC9yxBeYdcQ9j9d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>, Shuah Khan <shuah@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-kselftest@vger.kernel.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 08. 12. 21 15:14, Mark Brown wrote:
> On Wed, Dec 08, 2021 at 10:55:41PM +0900, Takashi Sakamoto wrote:
> 
>> I'm not positively for the patch since it can take developers puzzled due to
>> the symbol dependency newly introduced in unreleased version of alsa-lib.
> 
> Shouldn't the version check and local definition avoid that issue - if
> the version of alsa-lib doesn't have snd_config_load_string() then we'll
> use a locally defined version of snd_config_load_string() and not depend
> on the alsa-lib symbol?

The 1.2.6 library is released. The goal was to allow to run code with the 
older libraries until the new version is more spread. It's just one #if in the 
source code and a 1:1 code copy. The kselftest packagers should define the 
proper package dependencies for the downgrade possibility - it's distribution 
specific thing.

Anyway, the dynamic linker will print the correct error when the user tries to 
run the test program compiled using the new library on the system with the 
older library.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
