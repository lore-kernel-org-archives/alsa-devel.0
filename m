Return-Path: <SRS0=OsOn=2J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D41C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:25:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCD6020674
	for <alsa-devel@archiver.kernel.org>; Thu, 19 Dec 2019 20:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HOPsxK8d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlZXCHKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCD6020674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E618284F;
	Thu, 19 Dec 2019 21:24:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E618284F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576787131;
	bh=NTVEWlOW+NOk+4CxO/gBqVpQQO4rE3woAsG1nGbQTZc=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HOPsxK8dXI8HK9BAQipRuOJBNUKdaSMqlng6KdQdAkHzL6WTBz2HoWz0t1jDAcecK
	 cLTV7r196EuravSRjjyx7npZMqh8zGb0Fqubt6xfk+Ho4dJsDx+3z4nArScLFvyRoR
	 iOp/IZzGRuyINA2GRJ38Le04ZeNGlPyOTDfJg/WA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B327F80218;
	Thu, 19 Dec 2019 21:24:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3C0FF80234; Thu, 19 Dec 2019 21:24:38 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A456F80059
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2019 21:24:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A456F80059
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="TlZXCHKV"
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A3297227BF;
 Thu, 19 Dec 2019 19:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576784779;
 bh=xUSTFd7GGdvk10sf3+om8mg9EYMJvjpiQnqD0QauP2I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TlZXCHKVySipIwV8OQTf4eP3VeA0QPzE+s9nJVK5IUitaVn0l2mcL7AWC2Xvaxbju
 l4K26akuLHBCiPdJZXw9IjzSH3PlfKq+EHYNazCz9xmkuM90nZO4pSvrwtESuW0ggT
 4/G6f+qMiFE1v3SEzi1TZcwsUyDIJy4Cpr3wiQ5Q=
Date: Thu, 19 Dec 2019 14:46:18 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Message-ID: <20191219194618.GQ17708@sasha-vm>
References: <20191210210735.9077-1-sashal@kernel.org>
 <20191210210735.9077-158-sashal@kernel.org>
 <20191211110005.GC3870@sirena.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191211110005.GC3870@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH AUTOSEL 5.4 197/350] ASoC: SOF: imx: fix
 reverse CONFIG_SND_SOC_SOF_OF dependency
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Wed, Dec 11, 2019 at 11:00:05AM +0000, Mark Brown wrote:
>On Tue, Dec 10, 2019 at 04:05:02PM -0500, Sasha Levin wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> [ Upstream commit f9ad75468453b019b92c5296e6a04bf7c37f49e4 ]
>>
>> updated solution to the problem reported with randconfig:
>>
>> CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
>> turn referenced by the sof-of-dev driver. This creates a reverse
>> dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
>> is built-in but CONFIG_SND_SOC_SOF_IMX=m:
>
>Are you sure this doesn't depend on any other Kconfig changes?

Nope, but it didn't fail my build tests.

-- 
Thanks,
Sasha
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
