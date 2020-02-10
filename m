Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81915C352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:23:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0EC20733
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 17:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bIkLkK9Z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=serbinski.com header.i=@serbinski.com header.b="I+oJYFey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0EC20733
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=serbinski.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6250A15F8;
	Mon, 10 Feb 2020 18:22:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6250A15F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581355407;
	bh=TtTlLpO6EPIs7X8oXug23ZE8t0RyfCDbz4JXt/UiK/4=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bIkLkK9ZNkQ3nwRmmW9cCJ/WnH3tKbgYUDa1Pfl0Ox4xexLPp49nxBpybgFdgsMa1
	 fEJp5PgL05nV0KL9O4P27hMHDv/DnuEMMkwSfEqWZeWeBKLywel2rkF43JHZRz5aTK
	 tjQleXeLdy/QIm31wQk0y/NeiUoctnBid7z5VbPc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03277F8014F;
	Mon, 10 Feb 2020 18:22:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31357F80157; Mon, 10 Feb 2020 18:22:35 +0100 (CET)
Received: from mail.serbinski.com (mail.serbinski.com [162.218.126.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A8527F800FD
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 18:22:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A8527F800FD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=serbinski.com header.i=@serbinski.com
 header.b="I+oJYFey"
Received: from localhost (unknown [127.0.0.1])
 by mail.serbinski.com (Postfix) with ESMTP id 52FC3D006F9;
 Mon, 10 Feb 2020 17:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at serbinski.com
Received: from mail.serbinski.com ([127.0.0.1])
 by localhost (mail.serbinski.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5mv8vr5Wc_5; Mon, 10 Feb 2020 12:22:26 -0500 (EST)
Received: from mail.serbinski.com (localhost [127.0.0.1])
 by mail.serbinski.com (Postfix) with ESMTP id C52E1D00693;
 Mon, 10 Feb 2020 12:22:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.serbinski.com C52E1D00693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serbinski.com;
 s=default; t=1581355345;
 bh=LBzPdGEvwXi/b0wHoq1y99U4fh/apqlgThb7ByyzJUQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=I+oJYFeyvVH0rl8fhLnZoA46MBMSXaNBbQgsWJHz/BIT7MyH5m+W8OKmZe/ZdtgY5
 oW8fB5nV3+qJK4zTqKNQ1zJB2SMGVPrO/1EkP3gX0dJxhuJM05szGSU1hJuq+m92O1
 ija4PhNMz5IrU7i3eVCjph9mJwspfSL0dQIzBaT4=
MIME-Version: 1.0
Date: Mon, 10 Feb 2020 12:22:25 -0500
From: Adam Serbinski <adam@serbinski.com>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <d0437f6d-84c8-e1cd-b6f5-c1009e00245d@linaro.org>
References: <20200207205013.12274-1-adam@serbinski.com>
 <20200209154748.3015-1-adam@serbinski.com>
 <20200209154748.3015-4-adam@serbinski.com>
 <d0437f6d-84c8-e1cd-b6f5-c1009e00245d@linaro.org>
User-Agent: Roundcube Webmail/1.4-beta
Message-ID: <616e3042f46cb7f052fc71e0ba4919a2@serbinski.com>
X-Sender: adam@serbinski.com
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH v2 3/8] ASoC: qdsp6: q6afe-dai: add support
 to pcm port dais
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

On 2020-02-10 12:13, Srinivas Kandagatla wrote:
> Few minor comments
> 
>> +static int q6afe_tdm_set_sysclk(struct snd_soc_dai *dai,
>> +		int clk_id, unsigned int freq, int dir)
>> +{
> 
> Why are we adding exactly duplicate function of q6afe_mi2s_set_sysclk 
> here?

It isn't an exact duplicate.

The reason I split off the new function is because the clock IDs for PCM
overlap/duplicate the clock IDs for TDM, yet the parameters to
q6afe_port_set_sysclk are not the same for PCM and TDM.


>>   +	SND_SOC_DAPM_AIF_IN("QUAT_PCM_RX", NULL,
>> +			    0, 0, 0, 0),
> 
> This can be in single line, same for below

I will adjust these.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
