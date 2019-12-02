Return-Path: <SRS0=OACP=ZY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5258DC432C0
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:19:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAAC2146E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Dec 2019 11:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JSSxnFq6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAAC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D5FF886;
	Mon,  2 Dec 2019 12:18:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D5FF886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575285567;
	bh=sTiKEiW/4+r5JQSG1CyQuIxl+pAAJuyhYp3FAdVz6uI=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JSSxnFq6Blvfpzc74SWy9JZ0x5Zeolf//1VuXbiJ8r1t2o8j3Fn1CifVgth6RoW5F
	 wfqnJRiKFHleqbausjXIWp3oEIowLY2VmC9W/vvNWIkKWCf2EdNayW7Ub21CfrTDMA
	 QDfOqeSeTWuQO0Tklkb7DF7gCluLXX3Xg73/Z30U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C3AAF801D9;
	Mon,  2 Dec 2019 12:18:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F25DEF80214; Mon,  2 Dec 2019 12:18:34 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1E5BCF80090
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2019 12:18:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1E5BCF80090
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 02 Dec 2019 03:18:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; d="scan'208";a="410384043"
Received: from zeliteleevi.tm.intel.com ([10.237.55.130])
 by fmsmga005.fm.intel.com with ESMTP; 02 Dec 2019 03:18:27 -0800
Date: Mon, 2 Dec 2019 13:18:26 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@zeliteleevi
To: Nikhil Mahale <nmahale@nvidia.com>
In-Reply-To: <ca44751a-dcac-3711-b515-59083744df7b@nvidia.com>
Message-ID: <alpine.DEB.2.21.1912021149450.16459@zeliteleevi>
References: <20191129143756.23941-1-kai.vehmanen@linux.intel.com>
 <20191129143756.23941-2-kai.vehmanen@linux.intel.com>
 <ca44751a-dcac-3711-b515-59083744df7b@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Cc: tiwai@suse.de, alsa-devel@alsa-project.org,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

Hey,

On Mon, 2 Dec 2019, Nikhil Mahale wrote:

> On 11/29/19 8:07 PM, Kai Vehmanen wrote:
> > In the drm_audio_component.h interface, the third parameter
> > to pin_eld_notify() is pipe number. On Intel platforms, this value
> > is -1 for MST. On other platforms, a non-zero pipe id is used to
> 
> Do you mean "on Intel platforms, this value is -1 for non-MST"?
[...]
> I am looking into functions
> intel_audio_codec_enable/intel_audio_codec_disable, they sets
> pipe = -1 for non-MST cases, right?

yup, -1 for non-MST, that was just plain wrong in my Friday mail. The 
problem seems to be pipe id is positive in some non-MST cases (like 
https://github.com/thesofproject/linux/issues/1536 ), which is very 
suprising looking at e.g. intel_audio_codec_enable(), but that seems to be 
happening nevertheless.

This would seem like a lurking bug on the i915 graphics driver side. Your 
patch changed the behaviour in these cases on ALSA side (PCM was selected 
based on per_pin->pin_nid_idx, ignoring dev_id), but one can argue whether 
this is worth preserving (or just drop/revert the RFC patch). I'll try to 
get a bit more info on the rootcause and how common case this is.

Br,
Kai
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
