Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3858C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Nov 2022 15:42:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F5E7172D;
	Fri, 25 Nov 2022 16:41:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F5E7172D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669390934;
	bh=6Yu0YQmAHRnGC9RYkVrI8AVNlKr1ZJYuIDpzeeue09w=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EqGSsOYBqiFzgf+bBhwh3XrzpRvdqbOV3rioddAzm8m1vUXRkuF/VyAMsj1gIjGmx
	 XgZULIN7zyGKdqxwmqhE+Cgx3U/AEbmEeOmTR2gsBpHGMOu4JOzySmTVYTRpXWxAPm
	 uacW+kEQZjxmwBmv8sKThkeHvFxoPqywVHrZAsA0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC6B0F80171;
	Fri, 25 Nov 2022 16:41:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 61101F80236; Fri, 25 Nov 2022 16:41:22 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 45F53F800F4
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2022 16:41:16 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id B0582A003F;
 Fri, 25 Nov 2022 16:41:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz B0582A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1669390875; bh=Vr+slmbJDu/gySeRjOckDYc8ItlXrV4V89WNVv09bjs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=F5IqYe0VmL2Pg+f+GdhesoYTXi0TVOfCpIMeFQA0edEK+XxuDkzrGVAZkmBpRJypF
 8e6Fl2XibL6jtddwrsUducBLe8NUHcM+lpRVBHXBa7T8myc6Q6cbfrUeFdd/YxPMvn
 xsUmddY1W7/Zk1IoCQHEsWDK6JpWZ3+kjSP9Ld2o=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 25 Nov 2022 16:41:10 +0100 (CET)
Message-ID: <77485fea-8aa9-9c95-8d6a-7a35994d0a84@perex.cz>
Date: Fri, 25 Nov 2022 16:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] kselftest/alsa: Add a .gitignore for the newly added PCM
 test
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Shuah Khan <shuah@kernel.org>
References: <20221125153654.1037868-1-broonie@kernel.org>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20221125153654.1037868-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
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

On 25. 11. 22 16:36, Mark Brown wrote:
> The newly added PCM test produces a binary which is not ignored by git
> when built in tree, fix that.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks,

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

> ---
>   tools/testing/selftests/alsa/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/alsa/.gitignore b/tools/testing/selftests/alsa/.gitignore
> index 3bb7c41266a8..2b0d11797f25 100644
> --- a/tools/testing/selftests/alsa/.gitignore
> +++ b/tools/testing/selftests/alsa/.gitignore
> @@ -1 +1,2 @@
>   mixer-test
> +pcm-test


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
