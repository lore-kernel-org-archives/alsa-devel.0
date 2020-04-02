Return-Path: <SRS0=DopR=5S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0DEC43331
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D53B20737
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2020 19:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TA2BI4Xq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D53B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5C9B1670;
	Thu,  2 Apr 2020 21:18:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5C9B1670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585855157;
	bh=Z8QNI0QyFOSLiR/Dhz+240O4OZEwaqjPe9F6a+QsuYg=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TA2BI4XqsNRYN+FOkYm3N5wiugI6LBJtfRz3RHU5dU6lB6fFJhbTUjZMhJoU5r3TX
	 I2d0DwJkJ6vgqfnfvhznymv4rZBpp+Yh5Q+NZa/wZ4KNy216zDo9L8joyH1TgUpPWz
	 dTCYqGCsZPaO6YFyb7aoYIy+0CiQfv0jq7jezl8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75EA7F80140;
	Thu,  2 Apr 2020 21:18:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AACD5F80148; Thu,  2 Apr 2020 21:18:22 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 26FE9F80140
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2020 21:18:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 26FE9F80140
IronPort-SDR: u6cOCWGk8m4vlK6hAxTCkioxbJ8c3yMc+dfmfVUxLxENqDZLNF6RaQqc6sutShgEZK7REsVC1U
 LwqWt3bGIvLQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2020 12:18:11 -0700
IronPort-SDR: ixDvYpzNRjGQGbOjEKXVGM0Relmyh53plPatW1PNwRF0vAHWRljXVDxJOAzQHjVuhfqblcz8uT
 syTEA47nAiog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; d="scan'208";a="243167648"
Received: from akleen-mobl3.amr.corp.intel.com (HELO [10.212.244.82])
 ([10.212.244.82])
 by orsmga008.jf.intel.com with ESMTP; 02 Apr 2020 12:18:09 -0700
Subject: Re: [PATCH 2/2] ASoC: SOF: Turn "firmware boot complete" message into
 a dbg message
To: Hans de Goede <hdegoede@redhat.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
References: <20200402184948.3014-1-hdegoede@redhat.com>
 <20200402184948.3014-2-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <67dc07e1-aeb2-66e3-5bea-467b5ecb6974@linux.intel.com>
Date: Thu, 2 Apr 2020 14:18:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402184948.3014-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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



On 4/2/20 1:49 PM, Hans de Goede wrote:
> Using a Canon Lake machine with the SOF driver causes dmesg to fill
> up with a ton of these messages:
> 
> [  275.902194] sof-audio-pci 0000:00:1f.3: firmware boot complete
> [  351.529358] sof-audio-pci 0000:00:1f.3: firmware boot complete
> [  560.049047] sof-audio-pci 0000:00:1f.3: firmware boot complete
> etc.
> 
> Since the DSP is powered down when not in used this happens everytime
> e.g. a notification plays, polluting dmesg.
> 
> Turn this messages into a debug message, matching what the code already
> does for the ""booting DSP firmware" message.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks Hans.

> ---
>   sound/soc/sof/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
> index fc4ab51bacf4..4760a9734585 100644
> --- a/sound/soc/sof/loader.c
> +++ b/sound/soc/sof/loader.c
> @@ -603,7 +603,7 @@ int snd_sof_run_firmware(struct snd_sof_dev *sdev)
>   	}
>   
>   	if (sdev->fw_state == SOF_FW_BOOT_COMPLETE)
> -		dev_info(sdev->dev, "firmware boot complete\n");
> +		dev_dbg(sdev->dev, "firmware boot complete\n");
>   	else
>   		return -EIO; /* FW boots but fw_ready op failed */
>   
> 
