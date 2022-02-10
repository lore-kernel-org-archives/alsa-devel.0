Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44A5C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Feb 2022 14:52:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D71481914;
	Thu, 10 Feb 2022 15:51:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D71481914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644504716;
	bh=6RsubzXM+GzN9yvnRsU2F1Ujjq8hUfNBS47UtXZzmA8=;
	h=Date:Subject:From:To:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cm09vadsDuZg5AQwjCDDiqR3AcUNJuV9EhmmvdBhqmk8YqlNDNkIuwBlpwzD8zhuB
	 b0kNbASdEOqVYEb+to4lTUUioGrBNV0wk33j7BSJ7z+saRKYLTW9IGr04M9VcFSS5L
	 GQeji7izF5gcPIa/vYko24uMdnAIn+46bMtImO9c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77278F8016C;
	Thu, 10 Feb 2022 15:51:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5ADCF8028B; Thu, 10 Feb 2022 15:51:01 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6DCB9F800A7
 for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2022 15:50:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6DCB9F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="Kx7lVucm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644504659; x=1676040659;
 h=message-id:date:mime-version:subject:from:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=6RsubzXM+GzN9yvnRsU2F1Ujjq8hUfNBS47UtXZzmA8=;
 b=Kx7lVucm/pfeVKkELIK6jE3rIq/JjsQcG+QcT5yrAb/WD4ZUyraVYGzH
 qc/nPkzgPzX8HM3nX8QLPEL2JysVErgp56E4lWR8Uy/HFo72UgRYxyc6y
 L27eauEbtlA5paWyV98R74s8CDCfiVPA1/HX3NwOay61CJMLQwnsDhp+U
 QC3DIWbH8wj4oa9fwNWA4MAX1R+bO6k/SEq9CvDmp11ifHRAEuwrP8pJk
 4VISPbwmDIGtjHpEUO9TN8Sn6OuzxvVOEjENGAf1aQlP2QVg+rrEe01Zt
 i6Ts01P+QKi4L6eeFMfxxltrz2QZmwgXLURf37PaIVm0qwD8HK2hg8XdL Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249711453"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="249711453"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 06:50:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="679167899"
Received: from barabano-mobl.ccr.corp.intel.com (HELO [10.252.41.18])
 ([10.252.41.18])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 06:50:51 -0800
Message-ID: <9d1ed0e0-e69e-e725-b820-4a1c04ecdf4c@linux.intel.com>
Date: Thu, 10 Feb 2022 16:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 9/9] ASoC: SOF: Convert the generic probe support to SOF
 client
Content-Language: en-US
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
 <20220210105519.19795-10-peter.ujfalusi@linux.intel.com>
 <YgUZKgPacRNrFk/e@sirena.org.uk>
 <cc1598d7-5029-197c-9abc-49043fdc11ed@linux.intel.com>
In-Reply-To: <cc1598d7-5029-197c-9abc-49043fdc11ed@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
 kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com,
 ranjani.sridharan@linux.intel.com, fred.oh@linux.intel.com,
 daniel.baluta@nxp.com
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



On 10/02/2022 16:41, Péter Ujfalusi wrote:
> 
> 
> On 10/02/2022 15:54, Mark Brown wrote:
>> On Thu, Feb 10, 2022 at 12:55:19PM +0200, Peter Ujfalusi wrote:
>>> Add a new client driver for probes support and move
>>> all the probes-related code from the core to the
>>> client driver.
>>
>> This breaks an x86 allmodconfig build:
>>
>> /mnt/kernel/sound/soc/sof/compress.c: In function 'create_page_table':
>> /mnt/kernel/sound/soc/sof/compress.c:87:9: error: implicit declaration of function 'snd_sof_create_page_table'; did you mean 'create_page_table'? [-Werror=implicit-function-declaration]
>>    87 |  return snd_sof_create_page_table(component->dev, dmab,
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~
>>       |         create_page_table
> 
> Interesting, we have this under constant builds for months and we
> certainly are building things as modules.
> 
> Let me check and fix this.

This patch never got reviewed in SOF:
ASoC: SOF: compr: Add compress ops implementation

and this introduced the use of snd_sof_create_page_table()

I don't sof-compress enabled, only imx and mediatek have it enabled.

Daniel, were there any reason to not send this to sof-dev prior?

-- 
Péter
