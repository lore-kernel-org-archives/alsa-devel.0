Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC230C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Feb 2022 10:53:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F15401891;
	Fri, 25 Feb 2022 11:52:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F15401891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645786398;
	bh=M7P3auaW4hDFpOp89wIa4AgAvrFPa7PAP7ECIN6cFKA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UR+8hXHUUh9eztYd4my6J1UIUQ3CyX9VXER9JRP5xdJPvkTRtgm0nOqM9nPSberH6
	 RstvUPIVbu2gJBWY09KHmLVc4R/CCJZzd0vLHNGV52BZZxR/IDm88vwJJ7/SiEIYpr
	 VKwLGlCULJYFkr2543or5osBhFAi9cAqXDNahGmY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92F6DF8012F;
	Fri, 25 Feb 2022 11:52:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D92BEF80132; Fri, 25 Feb 2022 11:52:26 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BADCCF800E1
 for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2022 11:52:18 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 1E017A003F;
 Fri, 25 Feb 2022 11:52:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 1E017A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1645786338; bh=iJ1NLrVE5m5/910GN8+APcCFZEpD5R1STwg2JWo5YLk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TTTCRKQ6KbNfa0FDRsV7vkM5ih7pSBJQ3husdPxJSOrHWnuWgpFuXKoxNDf5ffyIj
 Yf7xOgB3bayNEA/lIkZni2ISS2qdKfRwUupvxVu01Q2ZfCp62NBMvwcLHkKM2gZpx8
 KzBLzBfe6vMXmdIkThcfz/ngGU8chh185PuWmAQw=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Fri, 25 Feb 2022 11:52:05 +0100 (CET)
Message-ID: <83e4b67d-91d3-dca9-4b1f-d209f927d517@perex.cz>
Date: Fri, 25 Feb 2022 11:52:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V0 1/1] ALSA: pcm: fix blocking while loop in
 snd_pcm_update_hw_ptr0()
Content-Language: en-US
To: Raghu Bankapur <quic_rbankapu@quicinc.com>, Vinod Koul
 <vkoul@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 ierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Kai Vehmanen
 <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org,
 Zubin Mithra <zsm@chromium.org>, linux-kernel@vger.kernel.org
References: <cover.1645784757.git.quic_rbankapu@quicinc.com>
 <4d8b1cb4b0db88c3e28207a81403fbf1e4a87bff.1645784757.git.quic_rbankapu@quicinc.com>
From: Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <4d8b1cb4b0db88c3e28207a81403fbf1e4a87bff.1645784757.git.quic_rbankapu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Krishna Jha <quic_kkishorj@quicinc.com>
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

On 25. 02. 22 11:39, Raghu Bankapur wrote:
> When period interrupts are disabled, while loop in snd_pcm_update_hw_ptr0()
> results in the machine locking up if runtime->hw_ptr_buffer_jiffies is 0.
> Validate runtime->hw_ptr_buffer_jiffies value before while loop to avoid
> delta check.

I would set hw_ptr_buffer_jiffies to 1 in this case in snd_pcm_post_start().

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
