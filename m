Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47293C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 20:12:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 824A5181C;
	Mon, 14 Mar 2022 21:12:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 824A5181C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647288773;
	bh=0pxnGlpNlByYOct0+KSsGuFm7zdrYGlPoAuOPRTXj50=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pr/ZFlM0oOhwoPLUBg4ebSehrBoUNaGvIP45zIiXGQpNh23Bdl3tt7GJS5rqKi3Y5
	 GkEMFbTeeSj89obIYJo5z6FEviXUcrt+52ogUmlqEKWeb1bEhgMhlijiqkQBEn6a3E
	 JhpAz/Cfj5g8aF7VQwkjyeHUvno2lHbEFvb5VamI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32D00F80224;
	Mon, 14 Mar 2022 21:07:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 430EBF804E4; Mon, 14 Mar 2022 21:07:50 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 794CEF801EC
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 21:07:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 794CEF801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="BrLgd9+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647288468; x=1678824468;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0pxnGlpNlByYOct0+KSsGuFm7zdrYGlPoAuOPRTXj50=;
 b=BrLgd9+rDlnSHNz/oDzvzl8CUVZC/WJg1gJ10J3x46JaPsoYiqiNT49q
 0hh+s/HmD74HPmVmBUGZ4hnE+klh+paX+J56JXDTSorwtR8svQGSEEBOZ
 7W004YZTefzCq4LJWdkmXj0Sa9x58weJ/3wg1yum8sMVT9V7EafDSFaVG
 +MPwEnskqWrDtJ8y3vsQ3ugrzPZTkvS1ioze8jhNL4N+cNaOWaUC1RzHg
 pOUyZ+sAiu3DfsNf+HkfurUH2rVz8lEfyfQPBsVXmHsH7HAggRZsXpOuL
 1y5RRgS+E1s6sbL2e48OU8hDD6+MTIh7PLaYPoOhucP4a25tNUPD1gOdG A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256088210"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; d="scan'208";a="256088210"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 13:07:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; d="scan'208";a="580252859"
Received: from pmishr1-mobl1.amr.corp.intel.com ([10.254.25.117])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Mar 2022 13:07:32 -0700
Message-ID: <23007aea35f6edb9006928221094dcfb5aa25d1f.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: IPC4-tooplogy: Add ccore tokens
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 14 Mar 2022 13:07:31 -0700
In-Reply-To: <20220314200520.1233427-3-ranjani.sridharan@linux.intel.com>
References: <20220314200520.1233427-1-ranjani.sridharan@linux.intel.com>
 <20220314200520.1233427-3-ranjani.sridharan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, tiwai@suse.com
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

On Mon, 2022-03-14 at 13:05 -0700, Ranjani Sridharan wrote:
> Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> ---
>  sound/soc/sof/ipc4-topology.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Please disregard this patch. It was sent in error. Sorry for the
noise. 

Thanks,Ranjani

