Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB872C25B7A
	for <alsa-devel@archiver.kernel.org>; Mon, 20 May 2024 12:28:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A2F6E0D;
	Mon, 20 May 2024 14:28:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A2F6E0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1716208137;
	bh=DGcKwpnm0IaxJEb1l+kKTe6wdeH678B7xPsroNWQ1Rw=;
	h=Date:Subject:To:References:From:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=PU8901qrubXNVMtvD/R//POlV5/7CQMdy8jopIYd7mmL0iDLPKvZiwl4dVo++zBE8
	 IHdTwVUgJcqMYPjYs1KD/7I9MPFNHsOBep28i2bjiJKw4/9byfHvg7ExSM+bNxzWzE
	 8ldhlPdzgtQMpWFXSvxLCiCCNOVy5QbinSYWid+E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2785F80699; Mon, 20 May 2024 14:26:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 129B9F806A0;
	Mon, 20 May 2024 14:26:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9EDAF8026A; Mon, 20 May 2024 14:20:54 +0200 (CEST)
Received: from msa.smtpout.orange.fr (out-65.smtpout.orange.fr
 [193.252.22.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9FEE7F800DF;
	Mon, 20 May 2024 14:20:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9FEE7F800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256
 header.s=t20230301 header.b=iwhmvtrd
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 8FWTs7QkmyBie8FWTsPyIk; Sat, 18 May 2024 10:34:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1716021277;
	bh=HvBJuxK1qEQGY419eTHQS0e80FA2YaU9Iq9DBa3kX10=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iwhmvtrdL4BdsBWGJzKEpidQIiq9tYMuH0xt9xdOS7fc8Nl1J5yik1eSFqgb2VZgk
	 SfKIbYIHE0a5ct0ikO52QWFqvqm67pgrZcUKpOhlNNaZSwjY+YKVWoJS9xAbRgwpso
	 b2oBsgypqrjRFSFwu6ix9ZOftKcBVWYFM86CViQ6avj4S1KqDH0LPBBZqFNCuoA+s+
	 BTV4OFbYmIeHwMF2gZU4G1w91Scp5bZHDLlI3pq7cApCALEzGcFQe2JqFcb11PClPJ
	 syUymcbQu6mylvYyG3smWFis+IAGtjZ6YoDg+cbrYl18wBMHJ4ThylD4w8Jm84nPZr
	 tCstCJWA+cZzw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 May 2024 10:34:37 +0200
X-ME-IP: 86.243.17.157
Message-ID: <b736e11e-430a-462b-898a-d5e1dcf7f74a@wanadoo.fr>
Date: Sat, 18 May 2024 10:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ASoC: topology: Constify an argument of
 snd_soc_tplg_component_load()
To: Mark Brown <broonie@kernel.org>
References: 
 <f2f983e791d7f941a95556bb147f426a345d84d4.1715526069.git.christophe.jaillet@wanadoo.fr>
 <1fb69d24-03af-4742-9f44-5a93704f5cfb@sirena.org.uk>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1fb69d24-03af-4742-9f44-5a93704f5cfb@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KAUSDZNKJXMVNQS77XJSXDPM5V5TKRR6
X-Message-ID-Hash: KAUSDZNKJXMVNQS77XJSXDPM5V5TKRR6
X-MailFrom: christophe.jaillet@wanadoo.fr
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: lgirdwood@gmail.com, tiwai@suse.com, cezary.rojewski@intel.com,
 pierre-louis.bossart@linux.intel.com, peter.ujfalusi@linux.intel.com,
 yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com, srinivas.kandagatla@linaro.org,
 bgoswami@quicinc.com, daniel.baluta@nxp.com, linux-sound@vger.kernel.org,
 alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Le 14/05/2024 à 12:21, Mark Brown a écrit :
> On Mon, May 13, 2024 at 07:37:20PM +0200, Christophe JAILLET wrote:
>> snd_soc_tplg_component_load() does not modify its "*ops" argument. It
>> only read some values and stores it in "soc_tplg.ops".
> 
> As mentioned in submitting-patches.rst when submitting a patch series
> you should supply a cover letter for that patch series which describes
> the overall content of the series.  This helps people understand what
> they are looking at and how things fit together.

Ok.
I usually do, but I thought that the subjects were self-explanatory 
enough in this case.

Do you want me to resend?

CJ
