Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E988ECAAD3
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 16:38:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D091C1EB;
	Mon, 19 Sep 2022 18:37:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D091C1EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663605492;
	bh=r+HZWjhnLpHKnwLolm/pb8EvOPq9AuDh1WJbjYTmxqw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PddMJaMxPOgYQkG2gNq7iJEw7trMaY6Zq95ecFKYsYXPtZTQG3JosUpQohSFjSX35
	 013zkBTZ1/bkyShv6qAMXt2PXw3t6m1Xr6LfOLMZoFr+wvkZApaJ8EDmWk9+XXcHS2
	 KE2wfLId6sSTyxrFW6nNWN+7VjBd5rj5bvnDbs04=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DCE8F8016D;
	Mon, 19 Sep 2022 18:37:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 65901F8023A; Mon, 19 Sep 2022 18:37:21 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5DB1FF800C9
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 18:37:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5DB1FF800C9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="eyHZt8MV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1663605435; x=1695141435;
 h=date:from:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=r+HZWjhnLpHKnwLolm/pb8EvOPq9AuDh1WJbjYTmxqw=;
 b=eyHZt8MVfXvvhiW/KpfuIoRQr11/rKthvDqd+2FPAfB4siirkxDi3mub
 tKhiRLjT+knXWy9pGImHmGgJ8KYbuxBiJuLc7N2fZP17vBxKx4F7qvOoA
 SckEqjvqWHvrVU8nARXL2BJ3d3NMHqP/ehNlfECplgfEAcXm6abO/I1LC
 bviXK0Ktqbtn41hUHzyMWkhv/FI0uf4GdTx+cuMcCdhEho9lh+pljkpgE
 PBiM0WYa+gdFVYaZmpb64Cb0KAVWqEO4m2k6N5zRuumGPGSiK0AiN8tCu
 jlndpnKt23ibMIWbURoPLwWRxH4oRS+GvR6CjsQagW/Zaf+2aZFuCf3As Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10475"; a="363406989"
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; d="scan'208";a="363406989"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 09:37:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,328,1654585200"; d="scan'208";a="569717770"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2022 09:37:09 -0700
Date: Mon, 19 Sep 2022 19:37:55 +0300 (EEST)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda/hdmi: Fix the converter allocation for the
 silent stream
In-Reply-To: <20220919135444.3554982-1-perex@perex.cz>
Message-ID: <alpine.DEB.2.22.394.2209191937020.2722275@eliteleevi.tm.intel.com>
References: <20220919135444.3554982-1-perex@perex.cz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

Hi,

On Mon, 19 Sep 2022, Jaroslav Kysela wrote:

> Track the converters handling the silent stream using a new
> variable to avoid mixing of the open/close and silent stream
> use. This change ensures the proper allocation of the converters.
> 
> Fixes: 5f80d6bd2b01 ("ALSA: hda/hdmi: Fix the converter reuse for the silent stream")

thanks, this looks fine now!

Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Br, Kai
