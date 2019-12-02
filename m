Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F29C432C0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:08:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D64D21774
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 05:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="A1n+rx+r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rg7YdarC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D64D21774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 067FF82B;
	Mon,  2 Dec 2019 06:07:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 067FF82B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575263288;
	bh=R+4eiYDHv3AupputpX0J/VfQ3A0VTiLpys/6RpNf0BI=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=A1n+rx+rxdsk17AoIa3H+hOSN0Yj3qdaxY9llHWelQJUkk1dvgmCZQjUWAhdm6ZOQ
	 pJ885M8YjPiBwDgya7O56/eI/lqy61U++4O24Z8xhIdDoWZXxKL1nUO9hKpCXTMVgV
	 XSRiQQ90Pax+QgXwbGBhkw7FoU2c4d59pD77QmEQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 832A9F80090;
	Mon,  2 Dec 2019 06:07:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11EA4F80214; Mon,  2 Dec 2019 06:07:14 +0100 (CET)
Received: from hqemgate14.nvidia.com (hqemgate14.nvidia.com [216.228.121.143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4ED76F80090
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 06:07:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4ED76F80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="rg7YdarC"
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5de49bfe0000>; Sun, 01 Dec 2019 21:07:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Sun, 01 Dec 2019 21:07:06 -0800
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Sun, 01 Dec 2019 21:07:06 -0800
Received: from [10.24.218.121] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Dec
 2019 05:07:05 +0000
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 <alsa-devel@alsa-project.org>, <tiwai@suse.de>
References: <20191129143756.23941-1-kai.vehmanen@linux.intel.com>
 <20191129143756.23941-2-kai.vehmanen@linux.intel.com>
From: Nikhil Mahale <nmahale@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <ca44751a-dcac-3711-b515-59083744df7b@nvidia.com>
Date: Mon, 2 Dec 2019 10:37:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191129143756.23941-2-kai.vehmanen@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1575263231; bh=DyD7L+hjw3WgkpuYSG2KaJY6kYj/a4VIyoVZSO/2RqQ=;
 h=X-PGP-Universal:Subject:To:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=rg7YdarC/ZHj9ONvwsffRyjD2dBuLwunZ3Mgke8/3YOJG6gUtKiNgArxqIQRUVvlz
 FyhC2WF2vLG6hJsEYRt3vLrSO3oTx+AjN78Cbex85xQOikI8kxmUBaMP2HB6h3u2ku
 49Dq4YKwPXrdTemop0iR/+ZpU1cBTLfCWD/JpI1TjjKeYFeDODvB7RbG/ICsoLa65Y
 z8aAVi8FJGKb5ni6EoWH6qqQNqN9RNuCDtX0UrY23+ljMBBAU58bnkfPgWapRiK/fs
 sPKBZWbQitcZKUy+bybq8rc11OVzTXvIH1xyNIUFG4NdM0ksTKOiTukX0gf4kJ4Q16
 iQzQQ6F5uuZ6A==
Subject: Re: [alsa-devel] [PATCH 2/2] [RFC] ALSA: hda: hdmi - preserve
 non-MST PCM routing for Intel platforms
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Thanks Kai, see inline -

On 11/29/19 8:07 PM, Kai Vehmanen wrote:
> Commit 5398e94fb753 ("ALSA: hda - Add DP-MST support for NVIDIA codecs")
> introduced a slight change of behaviour how non-MST monitors are
> assigned to PCMs on Intel platforms.
> 
> In the drm_audio_component.h interface, the third parameter
> to pin_eld_notify() is pipe number. On Intel platforms, this value
> is -1 for MST. On other platforms, a non-zero pipe id is used to
> signal MST use.

Do you mean "on Intel platforms, this value is -1 for non-MST"?

I am looking into functions
intel_audio_codec_enable/intel_audio_codec_disable, they sets
pipe = -1 for non-MST cases, right?

> This difference leads to some subtle differences in hdmi_find_pcm_slot()
> with regards to how non-MST monitors are assigned to PCMs.
> This patch restores the original behaviour on Intel platforms while
> keeping the new allocation policy on other platforms.

What exact change commit 5398e94fb753 ("ALSA: hda - Add DP-MST support
for NVIDIA codecs") made in behaviour on Intel platform? Sorry, it is not
clear to me from your reply on this thread.

For non-MST monitors, pipe = -1 is getting passed
to intel_pin_eld_notify().
check_presence_and_report -> pin_id_to_pin_index changes value of dev_id
from -1 to 0, comment there says "(dev_id == -1) means it is NON-MST pin
return the first virtual pin on this port". If this is the case, non-MST
monitor should get PCM of index 'pin_nid_idx' like it was happening
before commit 5398e94fb753. Isn't it?

Thanks,
Nikhil Mahale

> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> ---
>  sound/pci/hda/patch_hdmi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index c3940c197122..1dd4c92254a4 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1353,6 +1353,11 @@ static int hdmi_find_pcm_slot(struct hdmi_spec *spec,
>  		i = spec->num_nids + (per_pin->dev_id - 1);
>  		if (i < spec->pcm_used && !(test_bit(i, &spec->pcm_bitmap)))
>  			return i;
> +
> +		/* keep legacy assignment for dev_id>0 on Intel platforms */
> +		if (spec->intel_hsw_fixup)
> +			if (!test_bit(per_pin->pin_nid_idx, &spec->pcm_bitmap))
> +				return per_pin->pin_nid_idx;
>  	}
>  
>  	/* have a second try; check the area over num_nids */
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
