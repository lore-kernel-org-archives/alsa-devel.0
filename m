Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6992C433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Apr 2022 18:48:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FED684B;
	Wed, 27 Apr 2022 20:47:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FED684B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651085314;
	bh=oQdgX6Kb2ZWEaM7RC23nOxdzQZGJbiTSxWzy621oJuE=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=amSmV3vMBkd6ALKc0pLszmi7prabYSFrTKQWSYbzLLqBY0jZHIf2tTK5Fa2FxTut6
	 qkYBLp63pdKTMd4gEtZNrRgMqa7yhxZ61Rrptz1ebQ0Tmbo4eZZLsMwXux62C5AGWH
	 1ma0BgtiCPUVOmIelxA1A5CGFrnkOEnr2ed2AObU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DC8CF80155;
	Wed, 27 Apr 2022 20:47:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 85B67F8016E; Wed, 27 Apr 2022 20:47:41 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 20553F80100
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 20:47:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 20553F80100
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="G4uQfp+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651085256; x=1682621256;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=oQdgX6Kb2ZWEaM7RC23nOxdzQZGJbiTSxWzy621oJuE=;
 b=G4uQfp+/ndt05VC1DXvWiLQZYZnv6QaP6CTkOVHWP07oXX9UvHAL0so4
 P5yRXj/G24hcCbTul1JGvbRBIiq/vIqqIyQ8UzbTfMBmKMpAVANhZrD46
 3DpONNaWR398nIeOwUFygyQCo32ZBqFRUG5XwiEZuAjDlETn8YQIAcbdd
 hweD1/CCl/1p4mYASCklrAnuuj+pzBXqVsYJOBZBEgYQKcoOn13CQ736s
 ieImEs8xyq4vjlN7Pany1IlZeLT79OhpY+yn23AHns6JdhTBQAwHRn8Wa
 H22Na476lwlC17/Fbn3Ocz9Ls7EifFVWt74xoVxXXH19dC9k7TmaZYcZN A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246595556"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; d="scan'208";a="246595556"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2022 11:47:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; d="scan'208";a="705683362"
Received: from rajamsri-mobl2.gar.corp.intel.com (HELO [10.252.58.132])
 ([10.252.58.132])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2022 11:47:27 -0700
Message-ID: <2592d293-1423-d1a7-f404-d89bb474aeb7@linux.intel.com>
Date: Wed, 27 Apr 2022 21:47:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3] ASoC: SOF: ipc3-topology: Correct get_control_data for
 non bytes payload
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20220427124025.14615-1-peter.ujfalusi@linux.intel.com>
 <YmlBgsQtrayqK0P6@google.com> <YmlDEY960ypq/QHH@google.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <YmlDEY960ypq/QHH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, cujomalainey@google.com,
 ranjani.sridharan@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org
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



On 27/04/2022 16:20, Sergey Senozhatsky wrote:
> On (22/04/27 22:13), Sergey Senozhatsky wrote:
>>> @@ -784,16 +785,26 @@ static int sof_get_control_data(struct snd_soc_component *scomp,
>>>  		}
>>>  
>>>  		cdata = wdata[i].control->ipc_control_data;
>>> -		wdata[i].pdata = cdata->data;
>>> -		if (!wdata[i].pdata)
>>> -			return -EINVAL;
>>>  
>>>  		/* make sure data is valid - data can be updated at runtime */
>>
>> A silly nit: does this comment belong to SOF_ABI_MAGIC check below?
> 
> I mean something like this?

yes, makes sense. Although I also played with the idea of dropping the
ABI magic check as well, but let's keep it for now.
> 
> ---
>  
>  		cdata = wdata[i].control->ipc_control_data;
>  
> -		/* make sure data is valid - data can be updated at runtime */
>  		if (widget->dobj.widget.kcontrol_type[i] == SND_SOC_TPLG_TYPE_BYTES) {
> +			/*
> +			 * make sure data is valid - data can be updated at
> +			 * runtime
> +			 */
>  			if (cdata->data->magic != SOF_ABI_MAGIC)
>  				return -EINVAL;
>  

-- 
Péter
