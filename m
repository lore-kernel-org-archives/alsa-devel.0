Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750E0C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Jun 2022 13:44:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6BAF41751;
	Mon,  6 Jun 2022 15:43:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6BAF41751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654523084;
	bh=rPdSPdTUwzlpUarpnYtySWOb8ImAxScKQ0LcARnMROc=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VttO8/M6dS9F/RTmV2zsPT8N8VFHrG82nVpmmf62gAJosfZ2BvbOKcM7lJJllWCnR
	 uXj/xbzZe9udaFky5I5Ds0tL8SnS2YS4RNadWp3WpExLPYU3hWWT2XBcyz4NMNme/u
	 ikVueHXlNb5mW0aOBbQTNXGQFvVxjNQwvqCyIsDw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0A300F80423;
	Mon,  6 Jun 2022 15:43:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1178FF801D8; Mon,  6 Jun 2022 15:43:52 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CCE47F80089;
 Mon,  6 Jun 2022 15:43:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CCE47F80089
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="fM/GqTTv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1654523030; x=1686059030;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rPdSPdTUwzlpUarpnYtySWOb8ImAxScKQ0LcARnMROc=;
 b=fM/GqTTvdL9LsX9teU1UgKOuCtlIefFSpWtcSDaJEi2GOivEU6SIfvPi
 BYbGUSsSHFyERdqAxJ1UfGxr5xjDZqSnT+GIWZFkIlyZegI2x34W+47Cc
 edx+5eYp1eTDrQoDURigwKQ3GzOK0k5xfwQK5WnYcQEy0Yh6aPoiSwUw1
 osU8QoBu/fSwxePr/xJB5/tH5xE4wE1zf9eV+SUn2HWKpedUYecqdCrlE
 H7ZB5G4e+NbtDjDoGFCnJrkJmDRc4yCFBQNAlS1WeBsAF+l9uhA6rloOk
 yntX8XvKvmNL+cZWZ8f6iTu5bUSDIU6uoro0CfCHGYU8hbFm82LrdJYxQ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="258991673"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="258991673"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 06:42:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; d="scan'208";a="583644843"
Received: from bylee-mobl1.amr.corp.intel.com (HELO [10.212.115.14])
 ([10.212.115.14])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2022 06:42:50 -0700
Message-ID: <308e49b9-d3b5-198e-d1d7-c191353f3884@linux.intel.com>
Date: Mon, 6 Jun 2022 08:42:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: SOF: Fix potential NULL pointer dereference
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
References: <20220602135757.3335351-1-amadeuszx.slawinski@linux.intel.com>
 <Yp3lduXW6x2BRRB5@sirena.org.uk>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <Yp3lduXW6x2BRRB5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Takashi Iwai <tiwai@suse.com>, Daniel Baluta <daniel.baluta@nxp.com>,
 sound-open-firmware@alsa-project.org
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



On 6/6/22 06:31, Mark Brown wrote:
> On Thu, Jun 02, 2022 at 03:57:57PM +0200, Amadeusz Sławiński wrote:
>> Cleanup path for sof_prepare_widgets_in_path() should check if unprepare
>> callback exists before calling it, instead it checks if it does not
>> exist. Fix the check.
>>
>> Fixes: 370014c8197a ("ASoC: SOF: Add a prepare op to IPC topology widget ops")
> 
> This commit does not exist.

Indeed, this SHA was for the SOF tree, the upstream version is this:

66344c6d92113 ("ASoC: SOF: Add a prepare op to IPC topology widget ops")
