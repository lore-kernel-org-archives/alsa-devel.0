Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8508ACA90AF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 18:05:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED52920673
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 18:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="QQ6Y6D3z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNpXKNUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED52920673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4E85116D7;
	Tue, 12 May 2020 20:04:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4E85116D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589306741;
	bh=yc6CNqoYkvluvBeb9WQbgl44Xk4YuO/iW2Z1m/hzklE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QQ6Y6D3zRIP0LqIGASVkvHLOo4C2PZDwmLjacWiiUf8d+v+pZpoI4oXA/mafs3hy3
	 Oxu3D/gOF+5Z/JarsuMJ0mXwfarUN1V+mf5x+l47LxJamAZ6+vnTBRSKJnIoYuYJK1
	 lxHtAiEGkax15piokg8LdrfVYIcTZtiIQP0lf8qM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4BECF80158;
	Tue, 12 May 2020 20:04:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7DA4BF8015A; Tue, 12 May 2020 20:04:48 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2ED9F80112
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 20:04:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2ED9F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="tNpXKNUE"
Received: from embeddedor (unknown [189.207.59.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F5F120673;
 Tue, 12 May 2020 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589306684;
 bh=yc6CNqoYkvluvBeb9WQbgl44Xk4YuO/iW2Z1m/hzklE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tNpXKNUEIE5dTnGo7j/WYOPw9ts4Hy4qorJF73kuDy5KaME/ONw/6KEAKx6T5GI96
 Tru/3jCFPgUUstfBELSRe1dKKjcpXXZ/QXX/YINyeNntLAevi8kAit6ZbmDmJebN5r
 pPODNn38dzmbRXbjGrUsrPbWiNu5j1U6kenTEueU=
Date: Tue, 12 May 2020 13:09:18 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] ASoC: Intel: Skylake: Replace zero-length array
 with flexible-array
Message-ID: <20200512180918.GF4897@embeddedor>
References: <20200511174647.GA17318@embeddedor>
 <158930188455.55827.14390851374340231617.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158930188455.55827.14390851374340231617.b4-ty@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Jie Yang <yang.jie@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>
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

On Tue, May 12, 2020 at 05:44:50PM +0100, Mark Brown wrote:
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.8
> 

Thanks, Mark.

--
Gustavo
