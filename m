Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82DDDC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 12:15:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D541E60E74
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 12:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D541E60E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=manjaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 38A9D168C;
	Tue, 12 Oct 2021 14:14:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 38A9D168C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634040929;
	bh=C+kvBiNWsUSQueuA/x9MryurR4q5tLU2LdA/ksqVa3A=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KbHA3mFKYrw3qQYyaUdFt3zK8yOeUit1Li27/11+DyxN3XrZyaTI3ZJZIaPAGRjXl
	 mtpqCN9SAZhlyRIMBRyBmaUxDX6nt7CvP4DRAgIXqxpofcMYqiidwUDu3VDqk2+RES
	 6DyI424pyOy1fClSsLX4xMZ955+kN8JQ4D5dwq6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A679F804E7;
	Tue, 12 Oct 2021 14:13:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 86437F80212; Tue, 12 Oct 2021 10:35:34 +0200 (CEST)
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B31A4F800C0
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 10:35:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B31A4F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org
 header.b="v8ej2KJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
 t=1634027720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=af2xZZ1mg+5DDC7AiaNVgJXfOaKooDCSOTvy2dV4nMY=;
 b=v8ej2KJ3TmnYH8PTKTMgP9RdPBF7Zv9i0gJx26jX8mpvvnucyvdYjN8Vn0ryD1wqTCdEUJ
 8vPi4h584MUIFGk1j/ROC3pH5IPSVj/siqMaBDs2CUguKZsqLOsTtnV/+LtljA8cXlQw5s
 THl+Vgt2Da3zDSNn3HFrD8H4b8DhEE1cDujO/nMQ7P8KD/6yYSzHl9jxSPZlt5N5QTOAwV
 lCx8d30L9yc0tIRHcYIu1LJvBdxbZJxROvVcU5NOOHrhVrXLhew7BvpZUm+gO0Mw6v4z5k
 Ufvvby3H/auu2c0I/hbglv7HTrHTFMv2Bh24E4AUIjbhXCWtBggA/iBnFbGC/Q==
Message-ID: <d01e45b0-fdfe-80e8-67e0-e6ca79e8ca73@manjaro.org>
Date: Tue, 12 Oct 2021 10:35:19 +0200
MIME-Version: 1.0
Subject: Re: Add ALSA UCM support for Pinebook Pro's audio
Content-Language: da-DK
To: Jian-Hong Pan <jhp@endlessos.org>, Jaroslav Kysela <perex@perex.cz>
References: <CAPpJ_ee4+Aer5z2qWr9xECoJOZTn80GKXxdTzzj08ADdXm5Uow@mail.gmail.com>
From: Dan Johansen <strit@manjaro.org>
Organization: Manjaro ARM
In-Reply-To: <CAPpJ_ee4+Aer5z2qWr9xECoJOZTn80GKXxdTzzj08ADdXm5Uow@mail.gmail.com>
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=strit@manjaro.org smtp.mailfrom=strit@manjaro.org
X-Mailman-Approved-At: Tue, 12 Oct 2021 14:13:19 +0200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, linux@endlessos.org
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

Thanks for doing this.

I am so glad someone is making an effort to get it upstream! Our 
(Manjaro ARM) solution is a pretty hacky way of doing it.

Den 12.10.2021 kl. 08.08 skrev Jian-Hong Pan:
> Hi,
>
> I prepared the pull request "ucm2: Add UCM support for rockchip_es8316 
> on Pinebook Pro" [1] to enable Pinebook Pro's audio generically.
> Also, the corresponding validator pull request "ucm-validator: Upload 
> rockchip_es8316's dummy json and alsa-info" [2].
>
> The original information comes from Manjaro ARM's 
> pinebookpro-post-install's asound.state [3] and pinebookpro-audio's 
> audio_jack_plugged_in.sh [4].
>
> To make it available on most distros, I transfer the asound.state and 
> the shell script into ALSA UCM conf.
>
> It will be appreciated if someone can review the pull requests and 
> give some feedback.
>
> [1]: https://github.com/alsa-project/alsa-ucm-conf/pull/112
> [2]: https://github.com/alsa-project/alsa-tests/pull/22
> [3]: 
> https://gitlab.manjaro.org/manjaro-arm/packages/community/pinebookpro-post-install/-/blob/4b4206c57b21044bf9c00848bd1f8b6f710d19eb/asound.state
> [4]: 
> https://gitlab.manjaro.org/manjaro-arm/packages/community/pinebookpro-audio/-/blob/1f567db09495acc3beb5405c9ef85c3c07b86785/audio_jack_plugged_in.sh
>
> Jian-Hong Pan
-- 
Kind regards
*Dan Johansen*
Project lead of the *Manjaro ARM* project
Manjaro-ARM <https://manjaro.org>
