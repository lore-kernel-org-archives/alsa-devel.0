Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68535C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:49:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D94862065D
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 13:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kDfd2woA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2cNJj3xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D94862065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7566F15F2;
	Wed, 22 Jul 2020 15:48:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7566F15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595425788;
	bh=UVmbuLKopkN2E3NVwRVE/SS4uLAvidcAX3P5wvIaRiU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kDfd2woAzAcu4JGMk7jM/CfhWFETCm2RDez7g5zxFSyLU1ZgD2zNTvHThBI6MsUmU
	 di1iDKUD1ApTcp4JJwK1ZdBBiWOZKnXeKKtU6jI77V01cg4Qgtjx1NHjT5+ZgPSPJ3
	 tJlesFnWGXydGJ5/2vAyD57zrckv2Ou+ZBk8itlI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C833AF8014C;
	Wed, 22 Jul 2020 15:48:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94351F8014C; Wed, 22 Jul 2020 15:48:56 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A4170F80141
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 15:48:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4170F80141
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="2cNJj3xX"
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DF17A2065D;
 Wed, 22 Jul 2020 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595425729;
 bh=UVmbuLKopkN2E3NVwRVE/SS4uLAvidcAX3P5wvIaRiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2cNJj3xXCHuNZIQ2dmW2I79gpY8nouuA60DzCwNP1JoRpuOLnGoXD6yfs3bKqff6x
 +jaT+OAZgrFzi5aPdaMHVbOSW8vxIh2VlKWgjnqGKibGgnKjLAhPslR4loWk92icm8
 whUh6QG6tqb76QCyS4SaIqQ6vGqIDHoZONQwTbUE=
Date: Wed, 22 Jul 2020 09:48:47 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: Re: [PATCH AUTOSEL 4.4 7/9] ALSA: hda/hdmi: fix failures at PCM open
 on Intel ICL and later
Message-ID: <20200722134847.GC406581@sasha-vm>
References: <20200714144024.4036118-1-sashal@kernel.org>
 <20200714144024.4036118-7-sashal@kernel.org>
 <alpine.DEB.2.22.394.2007151332320.3186@eliteleevi.tm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2007151332320.3186@eliteleevi.tm.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

On Wed, Jul 15, 2020 at 01:52:05PM +0300, Kai Vehmanen wrote:
>Hi Sasha,
>
>On Tue, 14 Jul 2020, Sasha Levin wrote:
>
>> From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
>>
>> [ Upstream commit 56275036d8185f92eceac7479d48b858ee3dab84 ]
>>
>> When HDMI PCM devices are opened in a specific order, with at least one
>> HDMI/DP receiver connected, ALSA PCM open fails to -EBUSY on the
>> connected monitor, on recent Intel platforms (ICL/JSL and newer). While
>
>we don't have Ice Lake hardware support in the HDA HDMI codec driver in
>any 4.x stable trees (only in 5.1+), so this patch will not help on those
>and can be dropped.

Will do, thank you.

-- 
Thanks,
Sasha
