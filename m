Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0B6C5479D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Jan 2023 16:39:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 93046763B;
	Wed, 11 Jan 2023 17:38:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 93046763B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673455170;
	bh=68GKm1v4X9d75N2gFb7QHOuMeiVHu3tWfcucZZXTBB8=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=MVvx9mpEEEl/iPshfgcyP5l+HRsutdy1qyS+xqTqL6GqbEICCI9q63C56pM2kdYVs
	 k/IdaHv5nVsXIA1tgp4JQAVGiC/4jTMz32PPg4nHrKvSQhbDKyQO7zCzUT5HMSCGjd
	 Vt2fRmQtJdc0K+MKNeECjmcU1wcSOVxnZAoEw0Z8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B854F805AA;
	Wed, 11 Jan 2023 17:36:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A6DFF805A1; Wed, 11 Jan 2023 17:36:20 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DC76AF80588
 for <alsa-devel@alsa-project.org>; Wed, 11 Jan 2023 17:36:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC76AF80588
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KJhF+Sry
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673454979; x=1704990979;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=68GKm1v4X9d75N2gFb7QHOuMeiVHu3tWfcucZZXTBB8=;
 b=KJhF+Sry5EWnr4S5PCEuNtg2ysAhDOdvK5zsgFA9PQ4BEr9lOvwxdw/c
 /6xPA195fSCfISrAfdVXLyYZ+5qpwp03JYYKNzIjJnk6yscEbunhTkiBN
 9/WIFuk0LxU5Ror8x/W38ZuCkJPwlSc8knBhyWgQEKhS5oEQMy+6Q2IA4
 /GkcgbSNeJrWOgtjFoeuZ+GKGIn0NBNVGR3G4Ag9bpscrbON9GRQWfPEk
 QFA4aPDu4nhTnfSlnUTmHgkIVatimuJq9WFx+/iCAGpJX0KwVF7vV0rQE
 Cd4Pv7rKjlMngviXrGmzQPadYzqSDCnNnRAgbrpNEoyyA3uaojObEkDA+ A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="324704227"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="324704227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 08:32:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607408734"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="607408734"
Received: from flobatol-mobl1.amr.corp.intel.com (HELO [10.212.110.208])
 ([10.212.110.208])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 08:32:37 -0800
Message-ID: <512a60e3-8194-c3ab-99a3-4443db2255a1@linux.intel.com>
Date: Wed, 11 Jan 2023 09:49:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH 15/19] soundwire: amd: add startup and shutdown dai ops
Content-Language: en-US
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
 vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20230111090222.2016499-1-Vijendar.Mukunda@amd.com>
 <20230111090222.2016499-16-Vijendar.Mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230111090222.2016499-16-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Mastan.Katragadda@amd.com, Sunil-kumar.Dommati@amd.com,
 Basavaraj.Hiregoudar@amd.com, open list <linux-kernel@vger.kernel.org>,
 Mario.Limonciello@amd.com, arungopal.kondaveeti@amd.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>



On 1/11/23 03:02, Vijendar Mukunda wrote:
> Add start up and shutdown dai ops for AMD Master driver.

I don't think those startup and shutdown ops are necessary, we removed
them for Intel, see "soundwire: intel: remove DAI startup/shutdown"

