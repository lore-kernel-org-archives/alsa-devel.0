Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A29CC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Feb 2022 16:31:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 53EF7193F;
	Wed, 23 Feb 2022 17:31:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 53EF7193F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645633915;
	bh=cGU3CIIQE1Irr2fInyYQqrBgMX4IysWI+rsOi/NgXbc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NzuyLkUaphcAPsOKzAmERCIfW61tVRx4BW/58uRAU6uer+cwmYzg3w39aegigL0F2
	 0a8BlxIU1Z2MFaNtcktZsdezoQUo0ptOOMGTxhO1gs+kGm27smgkAjK9yQqsOqR8Mq
	 3ZpnBwY5h73ieihfp3Xd8DHheCHtopNtzhPnyB/w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C022BF8019D;
	Wed, 23 Feb 2022 17:31:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2B287F80237; Wed, 23 Feb 2022 17:31:02 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 973C0F800F5
 for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2022 17:30:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 973C0F800F5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="mY3REBFj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1645633856; x=1677169856;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=cGU3CIIQE1Irr2fInyYQqrBgMX4IysWI+rsOi/NgXbc=;
 b=mY3REBFjLR1G6bn981/zoniCXxlhsNqNQz+ptkyJ4jlNz7DX9n4GZep/
 QDDLHUD6Di6TUygBEtxMwchXgksN++pic8an2wz2Y7oA2cDhRxDvOC7AK
 2r64uC/BFtvOgqfkjP/+aJMp8oeBK8nLEZy9GY4svUNotOQCzY/L/cyce
 EgJ2Sy7Ad1ndtZOBVu8V5PxrebqWE3o8Z4COZ1pfHaILU/lRSbzgayvOK
 sQMZQ1hRi5ybt6L7fOb3n4ICEGZxDzxOXJGhLPY4xJfkO/GZOJgz/mZ+b
 q5pahwB16XXAUYHIyXgypZvG6CUpDirDSHYf3fnSQun3gQooBgNFFu973 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="252203539"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; d="scan'208";a="252203539"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 08:16:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; d="scan'208";a="548317618"
Received: from aacunaco-mobl1.amr.corp.intel.com (HELO [10.209.144.93])
 ([10.209.144.93])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2022 08:16:12 -0800
Message-ID: <438fa589-475b-9f0b-2366-773c81a98e70@linux.intel.com>
Date: Wed, 23 Feb 2022 09:31:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: Intel: soc-acpi-byt: Add new WM5102 ACPI HID
Content-Language: en-US
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jie Yang <yang.jie@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
References: <20220223135237.731638-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220223135237.731638-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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



On 2/23/22 07:52, Hans de Goede wrote:
> The Lenovo Yoga Tablet 2 1050F/L tablets use an ACPI HID of "10WM5102"
> for their wm5102 codec, add this to the list of HIDs for the wm5102 codec.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks Hans!

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/common/soc-acpi-intel-byt-match.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> index 142000991813..c532529a3856 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> @@ -127,7 +127,7 @@ static const struct snd_soc_acpi_codecs rt5640_comp_ids = {
>  
>  static const struct snd_soc_acpi_codecs wm5102_comp_ids = {
>  	.num_codecs = 2,
> -	.codecs = { "WM510204", "WM510205"},
> +	.codecs = { "10WM5102", "WM510204", "WM510205"},
>  };
>  
>  static const struct snd_soc_acpi_codecs da7213_comp_ids = {
