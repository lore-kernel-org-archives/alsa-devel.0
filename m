Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2081AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Dec 2021 08:06:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46EB5238B;
	Tue,  7 Dec 2021 09:06:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46EB5238B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638864410;
	bh=KG457nwU5+qWy5ezICVo2atjVfc8cD4lPwcIlnZzUbk=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mW6FoIRMIW+WIYwR8DE25UBa38jea2HXeCUpsXMAwvNhLb6uxqxaPmK8yBcT5NMcu
	 fLCK1YGSOOsBwpDFP67s5VUDTZEZf4LIvGoVzNzYGlbbCHZtudglwvf9K3AJroIwPB
	 9PNT2Ej4rFUE97u/fGvo11a59dMOUisZh/st54Xk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1FC6F80259;
	Tue,  7 Dec 2021 09:05:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0E19F8028D; Tue,  7 Dec 2021 09:05:56 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A945F80253
 for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2021 09:05:49 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 26E37A0040;
 Tue,  7 Dec 2021 09:05:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 26E37A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1638864349; bh=1orcYpfi/OgeJ4wNPA5bcXbBCkkoQFBO4OLDelq5IzI=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=bxlAi9XA9DALDvGb6GMD6pgGDFtfNDa9MPWA6sAc3rroPYm6m3bowDSY4yzc/GbOY
 INuAxefzWFZWd0d2/jyc6z4gGyLTIJAl3rr/AeXakLZQ3blH0R7IaTOb1Vgn8c1pXL
 b621BVcIL38JyaMquawLuOF4ft7qDnFuT7HUGYkE=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Tue,  7 Dec 2021 09:05:44 +0100 (CET)
Message-ID: <77e39efd-e49d-cea1-1822-0e2262a766c9@perex.cz>
Date: Tue, 7 Dec 2021 09:05:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] kselftest: alsa: Add simplistic test for ALSA mixer
 controls kselftest
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Shuah Khan <shuah@kernel.org>, alsa-devel@alsa-project.org,
 linux-kselftest@vger.kernel.org
References: <20211206160305.194011-1-broonie@kernel.org>
 <Ya7TAHdMe9i41bsC@workstation>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <Ya7TAHdMe9i41bsC@workstation>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 07. 12. 21 4:20, Takashi Sakamoto wrote:
> As another topic, the runtime of alsa-lib application largely differs
> between process user due to the result of parsing text files for
> configuration space. I can easily imagine that developers unfamiliar to
> alsa-lib carelessly adds invalid or inadequate configurations to files
> under target path of alsa-lib configuration space, and they are puzzled
> since they are unaware of the fact that the kselftest is affected by
> userspace stuffs for the runtime.
The alsa-lib configuration can be restricted. I would suggest to use 
snd_ctl_open_lconf() function with a simple configuration which defines only 
ctl.hw device. In this case, the global configuration is not used, so the user 
errors are eliminated. Another way is to use the environment variable for the 
global alsa-lib configuration - ALSA_CONFIG_DIR.

I will try prepare a patch for snd_ctl_open_lconf().

					Jaroslav

BTW: Thank you Mark for this test.

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
