Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F17C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 12 May 2022 18:09:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 618921AC2;
	Thu, 12 May 2022 20:08:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 618921AC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652378983;
	bh=kmKK7agYZ5eq7QQOxTKMvD9R0gQEUDCU9gHMvoJiVTA=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZMq3Xa7T7uLWhmdjEU5k1hN/MnRkrYGTvX+zjwQWss5DLaWfMgiTmMNR6kkjxk7ts
	 ghYA1KxqcgSbEZXK4rQt0C9SCsJXqePjGs4B2l5bZynBKKKLeN2Nbct+4WdW4z/sER
	 tLDwQVP+Dw/6Yr1jvf5i2KhLxQKdn2mhj2dC+hc8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F3C22F80154;
	Thu, 12 May 2022 20:08:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 386FAF80245; Thu, 12 May 2022 20:08:51 +0200 (CEST)
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3151AF800BB
 for <alsa-devel@alsa-project.org>; Thu, 12 May 2022 20:08:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3151AF800BB
Received: from localhost (localhost.localdomain [127.0.0.1])
 by srv6.fidu.org (Postfix) with ESMTP id 995D9C800A0;
 Thu, 12 May 2022 20:08:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
 by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id VtnO0W-gAp6B; Thu, 12 May 2022 20:08:43 +0200 (CEST)
Received: from [192.168.176.111] (host-88-217-226-44.customer.m-online.net
 [88.217.226.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: wse@tuxedocomputers.com)
 by srv6.fidu.org (Postfix) with ESMTPSA id 10D9FC8009E;
 Thu, 12 May 2022 20:08:42 +0200 (CEST)
Message-ID: <a9a88617-101c-739c-fecd-5925e5f5085c@tuxedocomputers.com>
Date: Thu, 12 May 2022 20:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ALSA: hda/intel: Add quirk for TongFang devices with pop
 noise
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
References: <20220511133828.13724-1-wse@tuxedocomputers.com>
 <s5h35hggpao.wl-tiwai@suse.de>
 <71fadca3-7750-2fc0-c04a-f05ab4e85112@tuxedocomputers.com>
 <s5hv8ucf9f7.wl-tiwai@suse.de>
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <s5hv8ucf9f7.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, imre.deak@intel.com, tiwai@suse.com,
 linux-kernel@vger.kernel.org
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


Am 11.05.22 um 16:09 schrieb Takashi Iwai:
> On Wed, 11 May 2022 15:58:03 +0200,
> Werner Sembach wrote:
>> Am 11.05.22 um 15:41 schrieb Takashi Iwai:
>>> On Wed, 11 May 2022 15:38:28 +0200,
>>> Werner Sembach wrote:
>>>> When audio stops playing and sometimes when it starts playing, there is an
>>>> audible "pop" noise when using headphones on most Tongfang GMxMxxx,
>>>> GKxNxxx, GMxZxxx, GMxTxxx, and GMxAxxx devices.
>>>>
>>>> Disabling power saving for the Realtek codec fixes this noise. Presumably
>>>> it is triggered on some power event in the audio circuit.
>>>>
>>>> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
>>>> Cc: stable@vger.kernel.org
>>> Usually this denylist is a last resort if any other methods never
>>> helped.  Is it the case?
>> I also tried setting codec->power_save_node = 0; in a patch_realtek.c quirk.
>>
>> static void alc274_fixup_pop_noise(struct hda_codec *codec, const struct
>> hda_fixup *fix, int action)
>> {
>>        codec->power_save_node = 0;
>> }
>>
>> That initially seemed to work, but when I tested it again a day later
>> after a fresh install, it didn't anymore. I don't know what is
>> different. On the install before, I did some debugging with boot
>> parameters and other stuff, cant reproduce anymore what exactly.
> power_save_node is already 0 as default for patch_alc269(), so it must
> be irrelevant.
>
>> I took the line from alc274_fixup_bind_dacs which fixes the pop noise
>> when applied to the devices, but does a lot of random other stuff too
>> not meant for the device.
> It's only one thing, there are tons of different fixes :)
> alc274_fixup_bind_dacs() rather specifies the routing so that the
> speaker is connected to the preferred DAC.
>
> Many click noises come from the default pin shut-up behavior.  You
> can disable it or change it in other way.  Also, setting
> auto_mute_via_amp may influence on such behavior (that is included in
> alc274_fixup_bind_dacs()).
>
> Note that many quirks can be enabled even without compiling but via
> the codec patch loading (using hints).
>
>
> thanks,
>
> Takashi

Found a quirk in patch_realtek.c with the same effect as the
power_save=0 and 2 more affected subsystem ids. Patch send as v2.

Kind Regards,

Werner

