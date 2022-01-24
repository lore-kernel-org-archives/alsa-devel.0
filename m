Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91EFC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Jan 2022 16:30:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8523F2876;
	Mon, 24 Jan 2022 17:30:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8523F2876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643041855;
	bh=wiowfXnUrKIxt6oxyIA44n2yj8iXHC5ly9yp5cW24lI=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hbopRCxZXQXGPvE43DzsJEGXYszUUX4qeFd2Gr/VSiInHujn72zZHzh5zRn1nQyIh
	 RUIi+r/1CDXG+yh+yBRVUU2vgEIlglbhqDLLjqifsrGF8Y4UwwdZtU5M9j3SExiXsk
	 r1+JQw+rdGgJ4kC+W+32oSBog4rPwSV2BOc6ARvk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 104BAF80163;
	Mon, 24 Jan 2022 17:30:05 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89FE8F8027C; Mon, 24 Jan 2022 17:30:01 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CADA5F800E9
 for <alsa-devel@alsa-project.org>; Mon, 24 Jan 2022 17:29:54 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id EDC4EA0040;
 Mon, 24 Jan 2022 17:29:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz EDC4EA0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1643041794; bh=HTUzWnwspR/C+AN7lsB7wLgz6zBpEJmY/ri1dQyN+5Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pO02frmrh6+lsS+w9a5lUks7D8XmNP5EnjFikjvWxNR/iJK8kRpsKO5TDF0F644ZR
 Ogw29Bzcd20CDDduocPUF4XbNTAkBQOJPhcmjbMr+/te25/Ox6kBh9ClrGu/5zpxn+
 5dhbjymepBiCzHGp4uj4NjaLxavxn2Nsc4wBf4/I=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 24 Jan 2022 17:29:50 +0100 (CET)
Message-ID: <9eecf478-b705-7273-7553-24bafaec5404@perex.cz>
Date: Mon, 24 Jan 2022 17:29:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/3] ASoC: Add bounds checking for written values
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
References: <20220124153253.3548853-1-broonie@kernel.org>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20220124153253.3548853-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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

On 24. 01. 22 16:32, Mark Brown wrote:
> This series adds verification that values written to registers are in
> bounds for controls since the core doesn't validate for us.

As discussed, those conditions should be optional to eventually catch the 
wrong applications. I don't see any benefit to report the range error back 
when there is value masking code already. The users will note when the 
unwanted values are written to the hardware, or not?

			Thanks,
				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
