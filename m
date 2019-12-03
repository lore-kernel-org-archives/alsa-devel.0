Return-Path: <SRS0=OCx8=ZZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BA3C432C0
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 19:00:00 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E922080F
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Dec 2019 18:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hkaqWJKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E922080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 667361612;
	Tue,  3 Dec 2019 19:59:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 667361612
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575399597;
	bh=a4g2axipTmVvMMkVnnKQNTg/K5nXNO1uJ+UPekowPBk=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hkaqWJKvdf//wJMSsDdkQzuzn4GdgRDbPa0o/XfOgXSO4Mb4jsa5DIXqX+2vlfEzh
	 /72bOWquECmXbSMvUXtPsvRUKo7nbBsNzMdjvuVq1pN1IdhPeb2h1zRhnhzEBcqarU
	 UGzUGf8KWYoTmITHL20/3sNe8jo221+y/puMm4kA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB46CF800ED;
	Tue,  3 Dec 2019 19:59:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08847F80227; Tue,  3 Dec 2019 19:59:05 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7C6BF800ED
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2019 19:58:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7C6BF800ED
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 03 Dec 2019 10:58:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,274,1571727600"; d="scan'208";a="201104602"
Received: from cjlabarg-mobl2.amr.corp.intel.com (HELO [10.252.207.140])
 ([10.252.207.140])
 by orsmga007.jf.intel.com with ESMTP; 03 Dec 2019 10:58:56 -0800
To: Jaroslav Kysela <perex@perex.cz>,
 ALSA development <alsa-devel@alsa-project.org>
References: <20191203161908.7496-1-perex@perex.cz>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4bd562e7-64f6-1852-fe64-d280e91569c3@linux.intel.com>
Date: Tue, 3 Dec 2019 12:57:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191203161908.7496-1-perex@perex.cz>
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: snd-sof-pci - add model parameter
 and pass it to HDA codec driver
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



On 12/3/19 10:19 AM, Jaroslav Kysela wrote:
> It may be useful to pass the specific model to the generic HDA codec
> routines like the legacy HDA driver (snd-hda-intel) allows.
> The model name "sofbus" is tricky anyway.

Humm, I must admit I have never looked at this for the legacy driver, 
and I am a bit confused on what this would be used for?
The legacy driver uses codec->modelname but I can't figure out this part 
in hda_codec.c

if (codec->bus->modelname) {
	codec->modelname = kstrdup(codec->bus->modelname, GFP_KERNEL);

In theory there can be multiple codecs per bus (with different SDIs) so 
using the bus->modelname for the codec->modelname looks odd.
Is there an example of this being used for my education?

Also it'd make more sense to me to have this parameter in an 
intel-specific module, not the top level PCI one?

> 
> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>   include/sound/sof.h         | 1 +
>   sound/soc/sof/intel/hda.c   | 2 +-
>   sound/soc/sof/sof-pci-dev.c | 5 +++++
>   3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sound/sof.h b/include/sound/sof.h
> index 479101736ee0..a62686baa95d 100644
> --- a/include/sound/sof.h
> +++ b/include/sound/sof.h
> @@ -25,6 +25,7 @@ struct snd_sof_pdata {
>   	const char *drv_name;
>   	const char *name;
>   	const char *platform;
> +	const char *modelname;
>   
>   	struct device *dev;
>   
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 91bd88fddac7..ccb640bacc99 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -271,7 +271,7 @@ static int hda_init(struct snd_sof_dev *sdev)
>   	mutex_init(&hbus->prepare_mutex);
>   	hbus->pci = pci;
>   	hbus->mixer_assigned = -1;
> -	hbus->modelname = "sofbus";
> +	hbus->modelname = sdev->pdata->modelname;
>   
>   	/* initialise hdac bus */
>   	bus->addr = pci_resource_start(pci, 0);
> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
> index bbeffd932de7..c01ad85aad2a 100644
> --- a/sound/soc/sof/sof-pci-dev.c
> +++ b/sound/soc/sof/sof-pci-dev.c
> @@ -34,6 +34,10 @@ static int sof_pci_debug;
>   module_param_named(sof_pci_debug, sof_pci_debug, int, 0444);
>   MODULE_PARM_DESC(sof_pci_debug, "SOF PCI debug options (0x0 all off)");
>   
> +static char *model;
> +module_param(model, charp, 0444);
> +MODULE_PARM_DESC(model, "Use the given HDA board model.");
> +
>   #define SOF_PCI_DISABLE_PM_RUNTIME BIT(0)
>   
>   #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
> @@ -326,6 +330,7 @@ static int sof_pci_probe(struct pci_dev *pci,
>   	sof_pdata->desc = (struct sof_dev_desc *)pci_id->driver_data;
>   	sof_pdata->dev = dev;
>   	sof_pdata->platform = dev_name(dev);
> +	sof_pdata->modelname = model;
>   
>   	/* alternate fw and tplg filenames ? */
>   	if (fw_path)
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
