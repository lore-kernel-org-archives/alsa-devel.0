Return-Path: <SRS0=gPEE=A7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A7C433E2
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 01:59:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8E720B1F
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jul 2020 01:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lLH1vKXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8E720B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB6451615;
	Mon, 20 Jul 2020 03:58:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB6451615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595210389;
	bh=yHek6pKsp5WqwscUFlzd3acDTSbCUDpF9ORi7ySx6BE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lLH1vKXKq+3Z7RFUvROsKhAtei0upFJnWCuXkytrkfkAUIeipuToWjijcQr2KPVTB
	 vCFmbDUE7w4qiHaRaDKIwh7T6BIMTXBMWmbaF/BWm46CZZOmnagxZjZP7FRn3vldl3
	 Ii61nEbPm/xQcL+Wfie/ndNZNxQzaobAmUf7OBOI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CFA9F800CE;
	Mon, 20 Jul 2020 03:58:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49765F800E0; Mon, 20 Jul 2020 03:58:57 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by alsa1.perex.cz (Postfix) with ESMTP id 828B3F800C1
 for <alsa-devel@alsa-project.org>; Mon, 20 Jul 2020 03:58:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 828B3F800C1
Received: from [10.130.0.63] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2ZP+hRfzLwBAA--.1914S3;
 Mon, 20 Jul 2020 09:58:39 +0800 (CST)
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Loongson
 platform
To: Takashi Iwai <tiwai@suse.de>
References: <1594954292-1703-1-git-send-email-likaige@loongson.cn>
 <s5hzh7yk4rk.wl-tiwai@suse.de>
From: Kaige Li <likaige@loongson.cn>
Message-ID: <d95c163f-ab9b-acf1-f89d-d163726b6528@loongson.cn>
Date: Mon, 20 Jul 2020 09:58:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <s5hzh7yk4rk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxn2ZP+hRfzLwBAA--.1914S3
X-Coremail-Antispam: 1UD129KBjvdXoWruw1xWrWUKF1xAry7Xr1fWFg_yoWfKFb_Ar
 y2kF4fC3WfJwn7Ww4rtrs3tr4xuF1DXrW7uryfGFZIq34fAa48urn5Cr9xCr4UXFZ7Jry3
 GayF9rWrZ34jgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
 Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
 0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
 6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
 0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
 bIxvr21lc2xSY4AK67AK6w4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
 UI43ZEXa7VUbNzVUUUUUU==
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 Xuefeng Li <lixuefeng@loongson.cn>
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


On 07/17/2020 02:57 PM, Takashi Iwai wrote:
> On Fri, 17 Jul 2020 04:51:31 +0200,
> Kaige Li wrote:
>> Add pin quirks to enable use of the headset mic on Loongson platform.
>>
>> Signed-off-by: Kaige Li <likaige@loongson.cn>
>> @@ -7654,6 +7663,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
>>   	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
>>   	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
>>   	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
>> +	SND_PCI_QUIRK(0x10ec, 0x0269, "Loongson HDA", ALC269_FIXUP_LOONGSON_HDA),
> This is basically Realtek ALC269 codec itself, so putting this here
> may hit with many other machines.
>
> Doesn't it has any proper PCI or codec SSID?  The lack of them usually
> means a bug of BIOS.

  Ok, I will have a look. If there is any progress, I will reply to you again.

  Thank you!

  Kaige

> thanks,
>
> Takashi

