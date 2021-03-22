Return-Path: <SRS0=WNy5=IU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D90C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 14:39:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F9C6191C
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Mar 2021 14:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F9C6191C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7938185D;
	Mon, 22 Mar 2021 15:38:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7938185D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616423944;
	bh=gvVewpDI5W+XJaD8NQwhrf+O2i457YMVRgjbYUznR1I=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IgW9qmiR9zUNw8s9xl9+vNa1186+lJj7Dzx6XanrqyPSN4fpiZcIRalQ+jlouuIkk
	 fnS40sW8sZY5fQVn1VwINqgn3kSIgGGjA2K1MuVg7U4vhh/T3iV4t706zR4tSXnYxJ
	 gbsRmCogee1ux74UwNKy5YlfvDKs+TLYbFpUHdxE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02823F80156;
	Mon, 22 Mar 2021 15:38:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B68CF8016B; Mon, 22 Mar 2021 15:38:12 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E81FF80107
 for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2021 15:38:05 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 32F73A003E;
 Mon, 22 Mar 2021 15:38:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 32F73A003E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1616423885; bh=DxfygpitPra5Cpiwi463YlHdOGWgOHeQqjm+lS0lShU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=GJZvfhmKnms04+ZSNgkCOh42q886BBqayRTu2vqyYfX3jGYeIryR8NK5UbXX3AOnf
 +ENS0BARR4vSMmMRapVPUdn1uuSd8fZ1OUFu0DcM9X3c/ekfvKDuaRcOD+SFc7NqZ6
 JEb59xKL0lUmcdfxY5RxVJpIuZJKqWLFz9bvM76k=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 22 Mar 2021 15:37:52 +0100 (CET)
Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control supports
To: "Yuan, Perry" <Perry.Yuan@dell.com>, Mark Brown <broonie@kernel.org>,
 "pierre-louis.bossart@linux.intel.com"
 <pierre-louis.bossart@linux.intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@dell.com>,
 "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <20210301093834.19524-1-Perry_Yuan@Dell.com>
 <20210308172409.GF4656@sirena.org.uk>
 <SJ0PR19MB4528847687FEEE4A4DED8E3F84659@SJ0PR19MB4528.namprd19.prod.outlook.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <604693cc-08c7-2b5f-632a-58ed537c54a0@perex.cz>
Date: Mon, 22 Mar 2021 15:37:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4528847687FEEE4A4DED8E3F84659@SJ0PR19MB4528.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "mgross@linux.intel.com" <mgross@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "pobrn@protonmail.com" <pobrn@protonmail.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
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

Dne 22. 03. 21 v 10:25 Yuan, Perry napsal(a):
> Hi Mark:
> 
>> -----Original Message-----
>> From: Mark Brown <broonie@kernel.org>
>> Sent: Tuesday, March 9, 2021 1:24 AM
>> To: Yuan, Perry
>> Cc: pobrn@protonmail.com; pierre-louis.bossart@linux.intel.com;
>> oder_chiou@realtek.com; perex@perex.cz; tiwai@suse.com;
>> hdegoede@redhat.com; mgross@linux.intel.com; Limonciello, Mario;
>> lgirdwood@gmail.com; alsa-devel@alsa-project.org; linux-
>> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org
>> Subject: Re: [PATCH v4 2/2] ASoC: rt715:add micmute led state control
>> supports
>>
>> On Mon, Mar 01, 2021 at 05:38:34PM +0800, Perry Yuan wrote:
>>
>>> +	/* Micmute LED state changed by muted/unmute switch */
>>> +	if (mc->invert) {
>>> +		if (ucontrol->value.integer.value[0] || ucontrol-
>>> value.integer.value[1]) {
>>> +			micmute_led = LED_OFF;
>>> +		} else {
>>> +			micmute_led = LED_ON;
>>> +		}
>>> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, micmute_led);
>>> +	}
>>
>> These conditionals on inversion seem weird and counterintuitive.  If we're
>> going with this approach it would probably be clearer to define a custom
>> operation for the affected controls that wraps the standard one and adds the
>> LED setting rather than keying off invert like this.
> 
> Currently the sof soundwire driver has no generic led control yet.
> This patch can handle the led control needs for MIC mute LED, definitely the patch is a short term solution.
> There is a feature request discussion when we started to implement this solution.
> https://github.com/thesofproject/linux/issues/2496#issuecomment-713892620
> 
> The workable way for now is that we put the LED mute control to the codec driver.
> When there is new and full sound LED solution implemented, this part will be also optimized.
> The Hardware privacy feature needs this patch to handle the Mic mute led state change.
> Before that full solution ready in kernel, could we take this as short term solution?

Perry, it's about the machine detection. Your code is too much generic even
for the top-level LED trigger implementation. We need an extra check, if the
proper LED's are really controlled on the specific hardware. Other hardware
may use RT715 for a different purpose. Use DMI / ACPI checks to detect this
hardware and don't misuse the inversion flag to enable this code.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
