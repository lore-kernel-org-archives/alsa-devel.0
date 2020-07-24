Return-Path: <SRS0=4jWs=BD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD2DC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:33:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D04720714
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2020 03:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Iu72Y4o4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D04720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09C591680;
	Fri, 24 Jul 2020 05:32:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09C591680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595561626;
	bh=hUw4w+yGRrvSU0jPyhI2m3yty4+m+CV0n8S+kfN1tRQ=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iu72Y4o4O0yt9PuOXRU76Rgcg58LV+a9OYGNuUlutODs/HxodR20sorYkRpiJRtCF
	 yz+wC1P2aj6gYocQLgMHSXGqPEBKiKXS9QuD667Dblzi7U9TXNmvhmNdW4eoZCU+2P
	 MXmQOss0d8oqCTK04Wn2uAVp1eE++xB9JPi4XIPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 85648F800CE;
	Fri, 24 Jul 2020 05:32:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F6A4F8014C; Fri, 24 Jul 2020 05:32:53 +0200 (CEST)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by alsa1.perex.cz (Postfix) with ESMTP id 8F49DF8011F
 for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2020 05:32:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F49DF8011F
Received: from [10.130.0.63] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX2VWVhpfr_sDAA--.1607S3;
 Fri, 24 Jul 2020 11:32:39 +0800 (CST)
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: Fix headset mic on Loongson
 platform
To: Takashi Iwai <tiwai@suse.de>
References: <1594954292-1703-1-git-send-email-likaige@loongson.cn>
 <s5hzh7yk4rk.wl-tiwai@suse.de>
 <d95c163f-ab9b-acf1-f89d-d163726b6528@loongson.cn>
From: Kaige Li <likaige@loongson.cn>
Message-ID: <66a95c5e-4997-ea4a-258e-343cdb91dfea@loongson.cn>
Date: Fri, 24 Jul 2020 11:32:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d95c163f-ab9b-acf1-f89d-d163726b6528@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9DxX2VWVhpfr_sDAA--.1607S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWDuFW7tF4rZFWDArWrXwb_yoWkKFg_Cr
 W7Can7Cw15trZ7Wan5tFs5tr4I9FykXrWUuryfGFs0q34xAF18Wr4rGrn3Aw4UJFZrJryf
 u3yFvrW5C340gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbsAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
 6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
 A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
 Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
 CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
 IcxG8wCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
 UI43ZEXa7VUj5l1PUUUUU==
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

On 07/20/2020 09:58 AM, Kaige Li wrote:

>
> On 07/17/2020 02:57 PM, Takashi Iwai wrote:
>> On Fri, 17 Jul 2020 04:51:31 +0200,
>> Kaige Li wrote:
>>> Add pin quirks to enable use of the headset mic on Loongson platform.
>>>
>>> Signed-off-by: Kaige Li <likaige@loongson.cn>
>>> @@ -7654,6 +7663,7 @@ static const struct snd_pci_quirk 
>>> alc269_fixup_tbl[] = {
>>>       SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", 
>>> ALC269_FIXUP_PCM_44K),
>>>       SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", 
>>> ALC269_FIXUP_LENOVO_EAPD),
>>>       SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MACH-WX9", 
>>> ALC256_FIXUP_HUAWEI_MACH_WX9_PINS),
>>> +    SND_PCI_QUIRK(0x10ec, 0x0269, "Loongson HDA", 
>>> ALC269_FIXUP_LOONGSON_HDA),
>> This is basically Realtek ALC269 codec itself, so putting this here
>> may hit with many other machines.
>>
>> Doesn't it has any proper PCI or codec SSID?  The lack of them usually
>> means a bug of BIOS.
>
>  Ok, I will have a look. If there is any progress, I will reply to you 
> again.
Sorry for that, there is no proper PCI or codec SSID. We have fixed this 
by writing the firmware. So this patch is useless.

Thank you for your time!

Kaige
>
>  Thank you!
>
>  Kaige
>
>> thanks,
>>
>> Takashi
>

