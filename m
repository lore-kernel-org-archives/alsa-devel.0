Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19E6C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 13:05:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76B5E61457
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 13:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76B5E61457
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40C9E173A;
	Fri, 14 May 2021 15:04:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40C9E173A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620997533;
	bh=hrSgVsZqaRBcljBBqNyheSc8FOIB8bhn2v+R26pY0do=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qgNdg23xHsPujJ9BM3C00YWQjQWs/pYnfLgHGkE0jclZOA7TDUULBzUXx+j5wRr4b
	 6rZDRfwrQ62ZdTc9bisdgZTWIzVrVm7LmccMT2QU1pn8OcBga6G4rmLtC289FGpAC2
	 qfZQb92a67lf9gZEsEtQB7q6ky6I7gwk7fQxOjtA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0C2BF8012A;
	Fri, 14 May 2021 15:04:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F2090F80240; Fri, 14 May 2021 15:04:40 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F08DF8013A
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 15:04:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F08DF8013A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="C9E8ZPN0"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00ADE613B5;
 Fri, 14 May 2021 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620997469;
 bh=hrSgVsZqaRBcljBBqNyheSc8FOIB8bhn2v+R26pY0do=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C9E8ZPN0XCkJyfjkn+NTGxiHrRCs+QgHfH3Nhgd4S8+LFU14eN5D6MdzufXrK4Ozu
 QPi5zdYOVim4TNd7zGJirTf8aDyp10SzV8j5RvAutfl+s/4Afml2bPn1I5ndVghBXu
 XV1avhSVcY6uLcEMdmD3DtTa+Vl9R18sb+3frWu7YF3kGITx5vwdVLxHylRDK1yNZI
 vbFEZ6IeI/2z/SQCO59xKJxwJUHnnnsuLyOX21xjKJBpi6XWRphLOuG4exYqLsBe9J
 eUtBwcuRLWzm+tXPakNwJnisb209yL165zqFxnFuC0dRDqA1ys810A0x0O6c9vPpu7
 hqmvq4JPEiXNQ==
Date: Fri, 14 May 2021 09:04:27 -0400
From: Sasha Levin <sashal@kernel.org>
To: David Ward <david.ward@gatech.edu>
Subject: Re: [PATCH AUTOSEL 5.12 090/116] ASoC: rt286: Generalize support for
 ALC3263 codec
Message-ID: <YJ51W9tR95hjW0vN@sashalap>
References: <20210505163125.3460440-1-sashal@kernel.org>
 <20210505163125.3460440-90-sashal@kernel.org>
 <55cb81cd-4eb9-049a-abf6-d4628ac8cb34@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <55cb81cd-4eb9-049a-abf6-d4628ac8cb34@gatech.edu>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

On Fri, May 07, 2021 at 12:34:29AM -0400, David Ward wrote:
>On 5/5/21 12:30 PM, Sasha Levin wrote:
>>From: David Ward <david.ward@gatech.edu>
>>
>>[ Upstream commit aa2f9c12821e6a4ba1df4fb34a3dbc6a2a1ee7fe ]
>>
>>The ALC3263 codec on the XPS 13 9343 is also found on the Latitude 13 7350
>>and Venue 11 Pro 7140. They require the same handling for the combo jack to
>>work with a headset: GPIO pin 6 must be set.
>>
>>The HDA driver always sets this pin on the ALC3263, which it distinguishes
>>by the codec vendor/device ID 0x10ec0288 and PCI subsystem vendor ID 0x1028
>>(Dell). The ASoC driver does not use PCI, so adapt this check to use DMI to
>>determine if Dell is the system vendor.
>
>For this patch to be useful, commit cd8499d5c03b ("ASoC: rt286: Make 
>RT286_SET_GPIO_* readable and writable") from the same series is 
>needed as well, which fixed the regmap config.
>
>(The same comment is true for all stable branches.)

I'll take it too, thanks!

-- 
Thanks,
Sasha
