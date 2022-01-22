Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC25C433F5
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Jan 2022 18:44:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 716631F8C;
	Sat, 22 Jan 2022 19:44:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 716631F8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642877093;
	bh=X6SuqDo+tYPoRwTyTzq7rfjoDJogWGx5G7aUZbbFhWI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AmQL1SG6Wflil4BRMzVgyS3ZFIciIL07S2XAo9hZ8Www0MoFDZS6UZI7wT1HweFSt
	 2sD0XJYEET8IhOBq2HYMHbScqLMwhBhpPXW8kUxeSslYR0DjYYbRrrgj7r2bIOdU0L
	 OeNfZs0IDnGMWYFljHZxwcxWR9KGCuQjFQwGLuHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CECEEF80236;
	Sat, 22 Jan 2022 19:44:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CB14DF8025E; Sat, 22 Jan 2022 19:44:00 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6F7DF800A7
 for <alsa-devel@alsa-project.org>; Sat, 22 Jan 2022 19:43:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6F7DF800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="mCWI4Kb5"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DB96F60E99;
 Sat, 22 Jan 2022 18:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2834CC004E1;
 Sat, 22 Jan 2022 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642877031;
 bh=X6SuqDo+tYPoRwTyTzq7rfjoDJogWGx5G7aUZbbFhWI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mCWI4Kb5fvOlNlcrPkqDvxOIhiR5v44VcpZWFDJIUQFlpQWJD3rFZjLQpdUhmc7Qs
 XcQLJJ9xe7PpHnfk+GMcBGRCFeDTLuBw6eq18AFUxDwDoOjLFRpvusqv8wT9qRjIgq
 ngjlystwW4CDkBndmG7cyLV6GLMFo6y7TVS3x1uCfDm1Ewk6BCJofxU9Od1tToiTPp
 LxuzhTE3vVDyajTrQ6m/eE8DNsIXESP34yibw0IA3nOna/TfAaVt8j7vftcDZb5rIa
 pcyxcWWPOAyB7atwGfozmI0LhVDR2rEygxNS/FKXC6PZF/wTPpcA4zzGz7TCss41yT
 sWBix593YQHcg==
Date: Sat, 22 Jan 2022 13:43:47 -0500
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.16 50/52] ASoC: amd: acp: acp-mach: Change
 default RT1019 amp dev id
Message-ID: <YexQY68hekHawpRa@sashalap>
References: <20220117165853.1470420-1-sashal@kernel.org>
 <20220117165853.1470420-50-sashal@kernel.org>
 <YeboZaJQLVejZCRg@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YeboZaJQLVejZCRg@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, stable@vger.kernel.org,
 tiwai@suse.com, vsujithkumar.reddy@amd.com
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

On Tue, Jan 18, 2022 at 04:18:45PM +0000, Mark Brown wrote:
>On Mon, Jan 17, 2022 at 11:58:51AM -0500, Sasha Levin wrote:
>> From: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
>>
>> [ Upstream commit 7112550890d7e415188a3351ec0a140be60f6deb ]
>>
>> RT1019 components was initially registered with i2c1 and i2c2 but
>> now changed to i2c0 and i2c1 in most of our AMD platforms. Change
>> default rt1019 components to 10EC1019:00 and 10EC1019:01 which is
>> aligned with most of AMD machines.
>
>This seems like a disruptive change to be backporting into stable...

I'll drop it, thanks!

-- 
Thanks,
Sasha
