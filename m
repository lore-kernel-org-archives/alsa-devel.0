Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73FC4C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Apr 2022 10:43:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 651D41779;
	Wed, 27 Apr 2022 12:43:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 651D41779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651056230;
	bh=PD4eAIF01buC0ZOYv8Px7k9fsTHM2wkoxKEO2M9kyuQ=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g//EVI7eqrDUr5gBTKUGQnOSNBCS6zeJpvV8I+IntQs44toYj/w5nQ9dws2I27nhj
	 /uBlC6xZmD/S/ogUaLlwibERDhfQfw0QSA0VAtU+yGc2/PfSA+W3MZYVto96xSQMKM
	 VAKhziC+VyUD1zvExZJoAuVEBNQkia509f3M0izI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06160F80155;
	Wed, 27 Apr 2022 12:43:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C634AF8016E; Wed, 27 Apr 2022 12:42:58 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 498D4F80152
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2022 12:42:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 498D4F80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="iA3mq365"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651056176; x=1682592176;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PD4eAIF01buC0ZOYv8Px7k9fsTHM2wkoxKEO2M9kyuQ=;
 b=iA3mq365/ZZHHAgqd7Wrz1rBDii4ETwlZFsejUARl7I7LilumkxmF/PW
 Wy8SmgTy1LE1cJ6mQmsWn5/IqnQwWK4zA8rxhDAI++GIGSuNtWVKbJQE7
 R2iBknJv/t9hvsy91TiW06Ue+y5OIAjWeVUDvsSq4/T21+D8F62R9Wnbc
 L21tojEuH8XZ+79n6dtJHBKh/xMZJ7g9mZrRJaq4/DRMeOSxK3WAi5VJ+
 pEi7AXs1TKhNNzSSSZm1iMXW9pkWF4oLp180rzaOHV2k3/Aflq7MkIfbr
 9+H11r772i/g0lIG4KEAHJjD1Z2a3kGdUFK8LjyL2QW5Dq9l3z/Cg+ugd w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265698160"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="265698160"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2022 03:42:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="705489074"
Received: from rdegreef-mobl1.ger.corp.intel.com (HELO [10.252.32.27])
 ([10.252.32.27])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2022 03:42:49 -0700
Message-ID: <498ed317-13ec-2700-3070-a8097a34d938@linux.intel.com>
Date: Wed, 27 Apr 2022 13:43:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ASoC: SOF: ipc3-topology: Correct get_control_data for
 non bytes payload
Content-Language: en-US
To: Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20220427085011.21805-1-peter.ujfalusi@linux.intel.com>
 <YmkcyRlTeTRYeUH+@google.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <YmkcyRlTeTRYeUH+@google.com>
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



On 27/04/2022 13:36, Sergey Senozhatsky wrote:
> On (22/04/27 11:50), Peter Ujfalusi wrote:
>> @@ -784,16 +785,23 @@ static int sof_get_control_data(struct snd_soc_component *scomp,
>>  		}
>>  
>>  		cdata = wdata[i].control->ipc_control_data;
>> -		wdata[i].pdata = cdata->data;
>> -		if (!wdata[i].pdata)
>> -			return -EINVAL;
>>  
>>  		/* make sure data is valid - data can be updated at runtime */
>> -		if (widget->dobj.widget.kcontrol_type[i] == SND_SOC_TPLG_TYPE_BYTES &&
>> -		    wdata[i].pdata->magic != SOF_ABI_MAGIC)
>> -			return -EINVAL;
>> +		if (widget->dobj.widget.kcontrol_type[i] == SND_SOC_TPLG_TYPE_BYTES) {
>> +			if (!cdata->data)
>> +				return -EINVAL;
>> +
>> +			if (cdata->data->magic != SOF_ABI_MAGIC)
>> +				return -EINVAL;
>> +
>> +			wdata[i].pdata = cdata->data->data;
>> +			wdata[i].pdata_size = cdata->data->size;
>> +		} else {
>> +			wdata[i].pdata = cdata->chanv; /* points to the control data union */
>> +			wdata[i].pdata_size = wdata[i].control->size;
> 				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> A question, so here wdata[i].control->size is
> 
> 	scontrol->size = struct_size(scontrol->control_data, chanv,
> 					le32_to_cpu(mc->num_channels));
> 
> Right?
> 
> If so, then is this really what we memcpy()? We memcpy() control->data->chanv
> and its size is `sizeof(chanv) * le32_to_cpu(mc->num_channels)`, isn't it?
> 
> [..]
>>  	if (ipc_data_size) {
>>  		for (i = 0; i < widget->num_kcontrols; i++) {
>> +			if (!wdata[i].pdata_size)
>> +				continue;
>> +
>> +			memcpy(&process->data[offset], wdata[i].pdata,
>> +			       wdata[i].pdata_size);
>> +			offset += wdata[i].pdata_size;
>>  		}
>>  	}
> 
> So should sof_get_control_data() have instead of this
> 
> 	wdata[i].pdata_size = wdata[i].control->size;
> 
> something like this
> 
> 	wdata[i].pdata_size = wdata[i].control->size - sizeof(struct sof_ipc_ctrl_data);

Yes, you are right.

> 
> So that we will copy payload data, which is a bunch of chanv structs 8
> bytes each.

-- 
Péter
