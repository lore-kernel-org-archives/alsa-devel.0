Return-Path: <SRS0=tzaW=56=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE749C2BA19
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:52:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66609206D5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Apr 2020 07:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ig0ZqBmR";
	dkim=pass (1024-bit key) header.d=spliet.org header.i=@spliet.org header.b="eId0IXPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66609206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=spliet.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BDDBB1687;
	Tue, 14 Apr 2020 09:51:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BDDBB1687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586850767;
	bh=34NOXLlEHBTtMhKyNDIX7ns/BCxDiQlvNC2AqXBCRn0=;
	h=Subject:To:References:From:Date:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ig0ZqBmR76kc0cdvw41asUyfU2Dyw7fP5iypZ99zeWLpVvxU7znV28z2dtMd+/jbt
	 LQHqvTU1x1Nelf+mPvJyBHk6HLrxVg1CmASU7IX2YQyuFEZH/3yJ4UgTffEd6QI2y8
	 gglMcKm13a6rjBwOrleEwh0aVqzDbD3OlOiGxdqI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96F67F8032A;
	Tue, 14 Apr 2020 09:42:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E16AF80245; Mon, 13 Apr 2020 12:53:04 +0200 (CEST)
Received: from mupuf.org (mupuf.org [167.71.42.210])
 by alsa1.perex.cz (Postfix) with ESMTP id 7DA5AF800B9
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2020 12:53:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7DA5AF800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=spliet.org header.i=@spliet.org
 header.b="eId0IXPb"
Received: from [10.249.163.62] (global-5-181.nat-2.net.cam.ac.uk
 [131.111.5.181])
 by Neelix.spliet.org (Postfix) with ESMTPSA id 47A3E60033;
 Mon, 13 Apr 2020 11:52:56 +0100 (BST)
DKIM-Filter: OpenDKIM Filter v2.11.0 Neelix.spliet.org 47A3E60033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spliet.org;
 s=default; t=1586775176;
 bh=NpkrioZSBpH2AJPgU+1uCo+bdupY0Z/fsQgonpO3mM0=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=eId0IXPb2J+pldvO0gjk9GO+UAmRdPBovACr+O33ed01eo55pBPyBbIY1nl4oxruI
 LzwUKhshz+/BBJY5JeDtYtbPUPwvSiSGtVlweUnqO2ZgFEECu7tFgmV0owDpJw9lQE
 YillodaDmGWWNYyU6yGdebi9Hm0WhMNr7sOXzEAM=
Subject: Re: [PATCH 4/6] ALSA: hda: Keep the controller initialization even if
 no codecs found
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
References: <20200413082034.25166-1-tiwai@suse.de>
 <20200413082034.25166-5-tiwai@suse.de>
From: Roy Spliet <nouveau@spliet.org>
Message-ID: <ec79a499-3b55-3bea-13ff-9e3802d6b092@spliet.org>
Date: Mon, 13 Apr 2020 11:52:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200413082034.25166-5-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at Neelix
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 14 Apr 2020 09:41:48 +0200
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


Op 13-04-2020 om 09:20 schreef Takashi Iwai:
> Currently, when the HD-audio controller driver doesn't detect any
> codecs, it tries to abort the probe.  But this abort happens at the
> delayed probe, i.e. the primary probe call already returned success,
> hence the driver is never unbound until user does so explicitly.
> As a result, it may leave the HD-audio device in the running state
> without the runtime PM.  More badly, if the device is a HD-audio bus
> that is tied with a GPU, GPU cannot reach to the full power down and
> consumes unnecessarily much power.
> 
> This patch changes the logic after no-codec situation; it continues
> probing without the further codec initialization but keep the
> controller driver running normally.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207043
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Tested-by: Roy Spliet <nouveau@spliet.org>

> ---
>   sound/pci/hda/hda_intel.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 692857904d49..aa0be85614b6 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -2009,7 +2009,7 @@ static int azx_first_init(struct azx *chip)
>   	/* codec detection */
>   	if (!azx_bus(chip)->codec_mask) {
>   		dev_err(card->dev, "no codecs found!\n");
> -		return -ENODEV;
> +		/* keep running the rest for the runtime PM */
>   	}
>   
>   	if (azx_acquire_irq(chip, 0) < 0)
> @@ -2303,9 +2303,11 @@ static int azx_probe_continue(struct azx *chip)
>   #endif
>   
>   	/* create codec instances */
> -	err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
> -	if (err < 0)
> -		goto out_free;
> +	if (bus->codec_mask) {
> +		err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
> +		if (err < 0)
> +			goto out_free;
> +	}
>   
>   #ifdef CONFIG_SND_HDA_PATCH_LOADER
>   	if (chip->fw) {
> @@ -2319,7 +2321,7 @@ static int azx_probe_continue(struct azx *chip)
>   #endif
>   	}
>   #endif
> -	if ((probe_only[dev] & 1) == 0) {
> +	if (bus->codec_mask && !(probe_only[dev] & 1)) {
>   		err = azx_codec_configure(chip);
>   		if (err < 0)
>   			goto out_free;
> 
