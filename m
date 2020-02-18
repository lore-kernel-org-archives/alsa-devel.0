Return-Path: <SRS0=1Vby=4G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C77BC34026
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:13:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAD032173E
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Feb 2020 11:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fxuSaB5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAD032173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C8591673;
	Tue, 18 Feb 2020 12:12:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C8591673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1582024385;
	bh=Emuqgo3MEznIuvrdQGvRUsjDknfSqPl2kZH7Ymefqdk=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fxuSaB5lRPiOMNth5km/HR0Gqb9/oAJ2vuGysMSPiScdESYCbnwLwcL87HYSShVnL
	 y78bI13CDr54re3b5xXkxtQdEAwj7LU0ZUC79ldfUHU5ZUAlOtcu/NZdfBoZJC+4ga
	 wOisl4QHnxgfyATLgCtR9o8gGC/dwTzuKKoyQDGU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C6CBF80145;
	Tue, 18 Feb 2020 12:12:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8B24F80148; Tue, 18 Feb 2020 12:12:12 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E2FEAF80137
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2020 12:12:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E2FEAF80137
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Feb 2020 03:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,456,1574150400"; d="scan'208";a="435819634"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga006.fm.intel.com with ESMTP; 18 Feb 2020 03:12:03 -0800
Date: Tue, 18 Feb 2020 13:12:02 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] ASoC: SOF: intel: Fix probe error without i915
 graphics
In-Reply-To: <s5h8sl1guk2.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.21.2002181248120.2957@eliteleevi.tm.intel.com>
References: <20200216203516.10869-1-tiwai@suse.de>
 <alpine.DEB.2.21.2002171506330.2957@eliteleevi.tm.intel.com>
 <s5hk14lgvy6.wl-tiwai@suse.de>
 <alpine.DEB.2.21.2002171612320.2957@eliteleevi.tm.intel.com>
 <s5h8sl1guk2.wl-tiwai@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Hey,

On Mon, 17 Feb 2020, Takashi Iwai wrote:

> On Mon, 17 Feb 2020 15:21:37 +0100,
> Kai Vehmanen wrote: 
>> at least in my tests, acomp_exit() ended up releasing a bunch of devres 
>> allocations made with devm_kzalloc() that had no relation to acomp. I 
>> noted that in devres.c:find_group(), docs say:
> 
> Isn't it the devres object allocated in the component base code
> itself?

true, but problem are other devres allocations done to the PCI device.

I did some more testing and if I force a failure in snd_hdac_i915_init()
and do cleanup with snd_hdac_acomp_exit() in the same function, it works
as expected:

[ 1476.111313] sof-audio-pci 0000:00:1f.3: bound 0000:00:02.0 (ops vgt_balloon_space [i915])
[ 1476.111315] sof-audio-pci 0000:00:1f.3: couldn't bind with audio component
[ 1476.111338] i915 0000:00:02.0: DEVRES REL 00000000b76305ff grp< (0 bytes)
[ 1476.111346] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000006f2e9c46 grp< (0 bytes)
[ 1476.111360] sof-audio-pci 0000:00:1f.3: DEVRES REM 000000000810c760 hdac_acomp_release (64 bytes)
[ 1476.111366] sof-audio-pci 0000:00:1f.3: init of i915 and HDMI codec failed

So this is good. It released the group created for acomp. But, but,
if the init is successful, but later in probe I end up disabling i915 
support (e.g. no codec driver in the kernel) and try to do cleanup of 
acomp resources by calling snd_hdac_i915_exit(), I get this suprising 
devres log:

[ 3007.592029] i915 0000:00:02.0: DEVRES REL 0000000071c16ac0 grp< (0 bytes)
[ 3007.592038] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000008b5ea24e grp< (0 bytes)
[ 3007.592044] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000f9d4d35c devm_kzalloc_release (1816 bytes)
[ 3007.592051] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000fa1e4d1a devm_kzalloc_release (1816 bytes)
[ 3007.592057] sof-audio-pci 0000:00:1f.3: DEVRES REL 0000000057d8edec devm_kzalloc_release (320 bytes)
[ 3007.592063] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000aea01a3d devm_kzalloc_release (320 bytes)
[ 3007.592069] sof-audio-pci 0000:00:1f.3: DEVRES REL 0000000039d17832 devm_kzalloc_release (320 bytes)
[ 3007.592075] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000009958e500 devm_kzalloc_release (320 bytes)
[ 3007.592081] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000eea2922f devm_kzalloc_release (320 bytes)
[ 3007.592088] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000dd6f6f2a devm_kzalloc_release (320 bytes)
[ 3007.592093] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000005ca30f2d devm_kzalloc_release (320 bytes)
[ 3007.592099] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000bf594d2d devm_kzalloc_release (320 bytes)
[ 3007.592104] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000009a0669c2 devm_kzalloc_release (320 bytes)
[ 3007.592110] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000757c42ee devm_kzalloc_release (320 bytes)
[ 3007.592115] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000a928376b devm_kzalloc_release (320 bytes)
[ 3007.592121] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000007bf93e19 devm_kzalloc_release (320 bytes)
[ 3007.592127] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000485f5b74 devm_kzalloc_release (320 bytes)
[ 3007.592133] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000007c95c553 devm_kzalloc_release (320 bytes)
[ 3007.592139] sof-audio-pci 0000:00:1f.3: DEVRES REL 00000000d7b60566 devm_kzalloc_release (320 bytes)
[ 3007.592145] sof-audio-pci 0000:00:1f.3: DEVRES REL 000000002805a826 devm_kzalloc_release (320 bytes)
[ 3007.592160] sof-audio-pci 0000:00:1f.3: DEVRES REM 0000000085720a3d hdac_acomp_release (64 bytes)


These allocations are not done for acomp, but are rather allocs
done for the SOF DSP device during the init. E.g. the 1816 byte alloc is 
devm_kzalloc of "struct hdac_hda_priv":

[ 3007.558102] sof-audio-pci 0000:00:1f.3: HDA codec #0 probed OK: response: 10ec0700
[ 3007.558109] sof-audio-pci 0000:00:1f.3: DEVRES ADD 00000000fa1e4d1a devm_kzalloc_release (1816 bytes)

... now I guess this is just how the component framework works. We do 
register the hdac-bus device as aggregate master device in 
snd_hdac_acomp_init() by calling component_master_add_with_match(). So 
calling snd_hdac_acomp_exit() will bring down the aggregate master device.

I now worked around this my putting the acomp_exit() at end of the SOF
DSP device removal.

Br, Kai
