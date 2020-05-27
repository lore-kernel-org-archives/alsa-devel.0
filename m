Return-Path: <SRS0=+ZhY=7J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEC0C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 20:18:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409282075A
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2020 20:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="P1rG0j53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409282075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C07E179B;
	Wed, 27 May 2020 22:17:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C07E179B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590610713;
	bh=kKGn23xMKjaNnL/G+YGQdJqa5hcWZjCDOxk29/bYkBA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P1rG0j53q3+t26gJhOopWvZ5hY9jz/2XK+LdIS4bu9S29WlzsqlJEq0zZkLp4hyaT
	 JbaRpVFsOF6LdgwhktazeN9mWQKpv59hIFUbqq3/N5eyzRP2RUndImGj+VUWmxtZe3
	 plykkXJMpDy+cLZwNZbj/kE+gOCMGxDfRajX2XEw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D82DFF800FF;
	Wed, 27 May 2020 22:17:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E251EF8014E; Wed, 27 May 2020 22:17:40 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EFE0F800FF
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2020 22:17:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EFE0F800FF
IronPort-SDR: L8SrvhOrJ9hGSerluVZFshmtIAJIt3jlEVBr/XE48SPVb03LxVPMvSN3nmakC+fqRxEQ44Mvsj
 4hmkzk/UeSTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 13:17:29 -0700
IronPort-SDR: xyAdMrGw+Mv8fSqEw5shYD1VmXEHzE0Zgv7/V2RZE/xI/I4ibDeCew9fUZmFP+XmTELTHF5a9y
 ABXRv5MeM+EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,442,1583222400"; d="scan'208";a="376138411"
Received: from truongmi-mobl1.amr.corp.intel.com (HELO [10.255.229.101])
 ([10.255.229.101])
 by fmsmga001.fm.intel.com with ESMTP; 27 May 2020 13:17:28 -0700
Subject: Re: [PATCH 0/4] Kconfig updates for DMIC and SOF HDMI support
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 broonie@kernel.org, alsa-devel@alsa-project.org
References: <20200427165211.23463-1-ranjani.sridharan@linux.intel.com>
 <00d4ea9242cad11b7aab10326b7430f6106d63e3.camel@linux.intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d9931fc5-56a2-5626-5cee-aeadc7cc976a@linux.intel.com>
Date: Wed, 27 May 2020 15:17:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <00d4ea9242cad11b7aab10326b7430f6106d63e3.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: tiwai@suse.de, Arnd Bergmann <arnd@arndb.de>, kai.vehmanen@linux.intel.com
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



On 5/15/20 11:14 AM, Ranjani Sridharan wrote:
> On Mon, 2020-04-27 at 09:52 -0700, Ranjani Sridharan wrote:
>> This series provides the following updtes to the Intel machine driver
>> Kconfig:
>>
>> 1. The first patch adds the explicit dependency on GPIOLIB when
>> SND_SOC_DMIC is selected.
>>
>> 2. SND_SOC_SOF_HDA_AUDIO_CODEC is required for using the legacy
>> HDA codec driver for HDMI support in SOF. The last 3 three patches
>> make the required changes to account for this.
>>
>> Libin Yang (3):
>>    ASoC: intel: add depends on SND_SOC_SOF_HDA_AUDIO_CODEC for common
>>      hdmi
>>    ASoC: sof-sdw: remove CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC condition
>>    ASoC: sof_pcm512x: remove CONFIG_SND_HDA_CODEC_HDMI condition
>>
>> Pierre-Louis Bossart (1):
>>    ASoC: Intel: boards: add explicit dependency on GPIOLIB when DMIC
>> is
>>      used
> Hi Mark,
> 
> I see that you applied the series in your merge commit below but your
> for-next branch only has the first patch in the series and the
> remaining 3 are missing. Just wanted to check with you if I should
> resend them.
> 
> commit eda12425b266b85a8c4b8f4f25ca8afc7e36070f
> Merge: 433f9cba54fa 4262ddc2ad63
> Author: Mark Brown <broonie@kernel.org>
> Date:   Tue Apr 28 16:40:38 2020 +0100
> 
>      Merge series "Kconfig updates for DMIC and SOF HDMI support" from
> Ranjani Sridharan <ranjani.sridharan@linux.intel.com>:


Mark, is there any issue with this patchset? This series posted last 
month will conflict with Arnd's RT5682 cleanups (just tried, see below). 
I don't mind re-sending the patches on top of Arnd's, please let us know 
what's easiest for you. Thanks!

diff --cc sound/soc/intel/boards/Kconfig
index dce3e7eacef4,46073c04364a..000000000000
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@@ -432,8 -429,8 +432,13 @@@ config SND_SOC_INTEL_GLK_RT5682_MAX9835
         tristate "GLK with RT5682 and MAX98357A in I2S Mode"
         depends on I2C && ACPI && GPIOLIB
         depends on MFD_INTEL_LPSS || COMPILE_TEST
++<<<<<<< HEAD
  +      depends on SND_HDA_CODEC_HDMI && SND_SOC_SOF_HDA_AUDIO_CODEC
  +      select SND_SOC_RT5682
++=======
+       depends on SND_HDA_CODEC_HDMI
+       select SND_SOC_RT5682_I2C
++>>>>>>> ASoC: rt5682: split i2c driver into separate module
