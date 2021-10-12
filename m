Return-Path: <SRS0=z7f8=PA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA064C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 16:43:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6974D61076
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Oct 2021 16:43:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6974D61076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6E53829;
	Tue, 12 Oct 2021 18:42:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6E53829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634056980;
	bh=EqMMI3/nUH/fIn8AOCwIVyjdVa2SX0ZaphPkOXPFfwE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LBgVPvHWDzjrA0qaLjQH943O+OaNPlI53AqYQUgZBs/uVwwlwA2Orx0+EOLZDbGOj
	 y8wx/97zuO0xhtUylKpWYUNHxiOa4RlM2KZrqBsYd8hptes8YUydGSiD29fSJd4o92
	 EghWtq1I7gsLgaAunORzTnucmjetz6bUiqHy5d3Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5FD86F801F7;
	Tue, 12 Oct 2021 18:42:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 53EE3F80212; Tue, 12 Oct 2021 18:42:07 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BF4F2F800C0
 for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2021 18:41:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF4F2F800C0
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="225979447"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; d="scan'208";a="225979447"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 09:41:22 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; d="scan'208";a="486456106"
Received: from csharp1-mobl.amr.corp.intel.com (HELO [10.213.183.127])
 ([10.213.183.127])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2021 09:41:21 -0700
Subject: Re: [PATCH v2 1/3] ALSA: pcm: introduce INFO_NO_REWINDS flag
To: Takashi Iwai <tiwai@suse.de>
References: <20211004162423.85323-1-pierre-louis.bossart@linux.intel.com>
 <20211004162423.85323-2-pierre-louis.bossart@linux.intel.com>
 <s5h8rz8ez3s.wl-tiwai@suse.de>
 <c62b3749-c5ea-7b1e-2831-272c8a14d3ac@linux.intel.com>
 <s5hbl43egs8.wl-tiwai@suse.de>
 <1ae2012b-d6bd-77ce-0a9e-98aec4d0f868@linux.intel.com>
 <s5hv9223h86.wl-tiwai@suse.de>
 <e630eb5f-f0f2-c193-ab68-46df26083275@linux.intel.com>
 <s5hk0ii1cwf.wl-tiwai@suse.de>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e3c854ba-9abf-c9f1-1d74-1a82c9a7b6b3@linux.intel.com>
Date: Tue, 12 Oct 2021 11:41:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <s5hk0ii1cwf.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, broonie@kernel.org,
 P9ter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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



On 10/12/21 10:27 AM, Takashi Iwai wrote:
> On Tue, 12 Oct 2021 17:15:56 +0200,
> Pierre-Louis Bossart wrote:
>>
>>> In either way, the new_ptr has to be validated beforehand that it's
>>> within 0..boundary-1.  (old_ptr is assumed to be valid.)
>>
>> In the 3 of the calls to pcm_lib_apply_appl_ptr(), the check is done
>> already prior to calling that function
>> 	if (appl_ptr >= runtime->boundary)
>> 		appl_ptr -= runtime->boundary;
>> 	err = pcm_lib_apply_appl_ptr(substream, appl_ptr);
>>
>>
>> it's rather unclear to me why the same check is not done for sync_ptr, e.g.
>>
>> if (!(sync_ptr.flags & SNDRV_PCM_SYNC_PTR_APPL)) {
>> 	err = pcm_lib_apply_appl_ptr(substream,	
>> 			     sync_ptr.c.control.appl_ptr);
>>
>> if (!(sflags & SNDRV_PCM_SYNC_PTR_APPL)) {
>> 	err = pcm_lib_apply_appl_ptr(substream,
>> 				scontrol.appl_ptr);
>>
>> Should I add a check there, or add a check inside of
>> pcm_lib_apply_appl_ptr() which would be a duplicate in the majority of
>> cases?
> 
> I guess adding in pcm_lib_appl_appl_ptr() would be easier and safer.
> There is even one more place that is calling pcm_lib_apply_appl_ptr()
> in the very latest commit (a fix for a buggy 32bit compat ioctl).

ok, here's the code I'll start testing. Thanks a lot Takashi for your help.

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index a144a3f68e9e..e839459916ca 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -2127,11 +2127,30 @@ int pcm_lib_apply_appl_ptr(struct
snd_pcm_substream *substream,
 {
        struct snd_pcm_runtime *runtime = substream->runtime;
        snd_pcm_uframes_t old_appl_ptr = runtime->control->appl_ptr;
+       snd_pcm_sframes_t diff;
        int ret;

        if (old_appl_ptr == appl_ptr)
                return 0;

+       /*
+        * check if a rewind is requested by the application, after
+        * verifying the new appl_ptr is in the 0..boundary range
+        */
+       if (substream->runtime->info & SNDRV_PCM_INFO_NO_REWINDS) {
+               if (appl_ptr >= runtime->boundary)
+                       appl_ptr -= runtime->boundary;
+
+               diff = appl_ptr - old_appl_ptr;
+               if (diff >= 0) {
+                       if (diff > runtime->buffer_size)
+                               return 0;
+               } else {
+                       if (runtime->boundary + diff > runtime->buffer_size)
+                               return 0;
+               }
+       }
+
        runtime->control->appl_ptr = appl_ptr;
        if (substream->ops->ack) {
                ret = substream->ops->ack(substream);

