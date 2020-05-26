Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6840C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 15:32:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B7EB20663
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 15:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a1nOyQke"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7EB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A58EB16E7;
	Tue, 26 May 2020 17:31:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A58EB16E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590507123;
	bh=PzvdI7jmPjHBr8bUlCRIYHkWNDT5lYSS4y0PbSoOHcs=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a1nOyQke4P+v7MGV8OOLOjNstUt5jNJJrFoewMaTs4cLP0cU57D9pL5w+BkWiu5bk
	 V6Grd4ngsKycFVNT7dBAzL9DQAWGtgbtrwySpiJLotajL1+biF77I6OXUS2Pj5GvH0
	 uH9hKQqQCedenEcC5Q967Lr0jzMgtlSLWtOkyDhk=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 29753F8014A;
	Tue, 26 May 2020 17:31:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A6E5F80150; Tue, 26 May 2020 17:31:06 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35947F80131
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 17:31:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35947F80131
IronPort-SDR: KkLugT4FzE+N9ghXSxyxFCQ79v53klID1ZFHXxiKPtPU9E8CS2wYOAVu+RNJBG7vGJBYDdKJTq
 o7MQR1MoHxMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 08:30:57 -0700
IronPort-SDR: vGeyyTBP5rAJ1KE0o0sHbkVasD0gSxCDYuY7s4p9MfCwJ7S5E3odZfKYF0ZUbP8PBnIPXrnLZq
 Aw1EI7earHCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; d="scan'208";a="255443356"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.10.59])
 ([10.213.10.59])
 by orsmga007.jf.intel.com with ESMTP; 26 May 2020 08:30:50 -0700
Subject: Re: [PATCH v2 1/2] ASoC: topology: refine and log the header in the
 correct pass
To: Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org
References: <20200521074847.71406-1-yang.jie@linux.intel.com>
 <20200521074847.71406-2-yang.jie@linux.intel.com>
 <4c05fcc4-2f94-1ca0-2148-af70ef739d00@intel.com>
 <faa1db0c-75ed-2482-9482-4ad329346bf4@linux.intel.com>
From: Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <e81515c4-84b6-7544-6f33-d88781c96496@intel.com>
Date: Tue, 26 May 2020 17:30:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <faa1db0c-75ed-2482-9482-4ad329346bf4@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

On 2020-05-26 4:45 PM, Keyon Jie wrote:
> On 5/26/20 8:38 PM, Cezary Rojewski wrote:
>> On 2020-05-21 9:48 AM, Keyon Jie wrote:

>> By having "log" code here we have one place for hdr validation, rather 
>> than two (the second being just an "if" to be fair..) and private 
>> array is no longer necessary. Local func ptr variable would take care 
>> of storing adequate function to call.
> 
> Hi Cezary, so what you suggested above is changing the 
> soc_tplg_load_header() to be something like this, right?
> 
> 
> static int soc_tplg_load_header(struct soc_tplg *tplg,
>      struct snd_soc_tplg_hdr *hdr)
> {
>      unsigned int hdr_pass;
>      int (*elem_load)(struct soc_tplg *, struct snd_soc_tplg_hdr *);
> 
>      tplg->pos = tplg->hdr_pos + sizeof(struct snd_soc_tplg_hdr);
> 
>      /* check for matching ID */
>      if (le32_to_cpu(hdr->index) != tplg->req_index &&
>          tplg->req_index != SND_SOC_TPLG_INDEX_ALL)
>          return 0;
> 
>      tplg->index = le32_to_cpu(hdr->index);
> 
>      switch (le32_to_cpu(hdr->type)) {
>      case SND_SOC_TPLG_TYPE_MIXER:
>      case SND_SOC_TPLG_TYPE_ENUM:
>      case SND_SOC_TPLG_TYPE_BYTES:
>          hdr_pass = SOC_TPLG_PASS_MIXER;
>          elem_load = soc_tplg_kcontrol_elems_load;
>          break;
>      case SND_SOC_TPLG_TYPE_DAPM_GRAPH:
>          hdr_pass = SOC_TPLG_PASS_GRAPH;
>          elem_load = soc_tplg_dapm_graph_elems_load;
>          break;
>      case SND_SOC_TPLG_TYPE_DAPM_WIDGET:
>          hdr_pass = SOC_TPLG_PASS_WIDGET;
>          elem_load = soc_tplg_dapm_widget_elems_load;
>          break;
>      case SND_SOC_TPLG_TYPE_PCM:
>          hdr_pass = SOC_TPLG_PASS_PCM_DAI;
>          elem_load = soc_tplg_pcm_elems_load;
>          break;
>      case SND_SOC_TPLG_TYPE_DAI:
>          hdr_pass = SOC_TPLG_PASS_BE_DAI;
>          elem_load = soc_tplg_dai_elems_load;
>          break;
>      case SND_SOC_TPLG_TYPE_DAI_LINK:
>      case SND_SOC_TPLG_TYPE_BACKEND_LINK:
>          /* physical link configurations */
>          hdr_pass = SOC_TPLG_PASS_LINK;
>          elem_load = soc_tplg_link_elems_load;
>          break;
>      case SND_SOC_TPLG_TYPE_MANIFEST:
>          hdr_pass = SOC_TPLG_PASS_MANIFEST;
>          elem_load = soc_tplg_manifest_load;
>          break;
>      default:
>          /* bespoke vendor data object */
>          hdr_pass = SOC_TPLG_PASS_VENDOR;
>          elem_load = soc_tplg_vendor_load;
>          break;
>      }
> 
>      if (tplg->pass == hdr_pass) {
>          dev_dbg(tplg->dev,
>              "ASoC: Got 0x%x bytes of type %d version %d vendor %d at 
> pass %d\n",
>              hdr->payload_size, hdr->type, hdr->version,
>              hdr->vendor_type, tplg->pass);
>          return elem_load(tplg, hdr);
>      }
> 
>      return 0;
> }
> 
> 
> I am also fine with this, though I thought my previous version looks 
> more organized and not so error-prone as we need 8 more assignation here.
> 
> Mark, Pierre, preference about this?
> 
> Thanks,
> ~Keyon
> 

Another option, if you want to reduce assignment count, is to keep 
soc_pass_load while still removing the private map. Said soc_pass_load 
would require declaration update to accept function ptr on top of what's 
already there.

In consequence, soc_tplg_load_header becomes a switch-case with a bunch of
case X:
	return soc_pass_load(tplg, hdr,
			pass=_MY_PASS
				(e.g. SOC_TPLG_PASS_VENDOR),
			elem_load=_MY_LOAD_FUNC
				(e.g. soc_tplg_vendor_load))

Czarek
