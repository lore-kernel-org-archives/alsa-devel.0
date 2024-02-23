Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F3AC5478C
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Feb 2024 11:46:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF65CEC7;
	Fri, 23 Feb 2024 12:46:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF65CEC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1708688797;
	bh=cewHMOUP9XE8f1iBRQp0XY/AtymJk2wyw8t26geqAWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JIuhIZJujY7nWRvOyLLVLq0wSd786hsw7pWiBGXdEKGKjsrKEUy3zT7l47azK0TCe
	 YcDg7l7RbW9TaTfJ3G0qLuBNLcQQpG8NudRFGb/7SIc3z51XnP3GQtjDZnJn7ZGgd+
	 ipxxnKvERrWB77laSUqgY+FroDHIgPRvlpQoWQJg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C1851F80637; Fri, 23 Feb 2024 12:45:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B2864F80636;
	Fri, 23 Feb 2024 12:45:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E6C5F805E4; Fri, 23 Feb 2024 12:45:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 28E7DF805C5
	for <alsa-devel@alsa-project.org>; Fri, 23 Feb 2024 12:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28E7DF805C5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=IbzbLFud
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708688707; x=1740224707;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cewHMOUP9XE8f1iBRQp0XY/AtymJk2wyw8t26geqAWQ=;
  b=IbzbLFudXFoYQCioB77t8IEZcB5qQmkkHnFqJbuaSI7sonPKjjAnuVed
   JEKasXKQtiCfvac7IEezsKGW/Bya0a+1qDbBJO64LLehaEp3VqaVknZDT
   5tpYYvF6tcigNfMbQwwIzjDLqetkrUrKJs42OhF0hHj7r8HXWShxXykt+
   DmuQYAQ06Z9QKEh9ndW/bJzmInQAgxpvyXbk6fakS6e9tArEv4jmoKnCQ
   as+8qwZ2NbqJgPDcbttBiojYXiU7APcSL5y7hldhmN5rSBqp8sAuKgmkU
   iAHfzIXfWrKsgPU4LTDza8PaXMyCXqJbNlqRRnrYdgGT0ROoklK4Ru77c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3504622"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000";
   d="scan'208";a="3504622"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2024 03:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000";
   d="scan'208";a="6092942"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
  by fmviesa006.fm.intel.com with ESMTP; 23 Feb 2024 03:45:00 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	tiwai@suse.com,
	perex@perex.cz,
	jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com,
	rodrigo.vivi@intel.com,
	tvrtko.ursulin@linux.intel.com,
	intel-gfx@lists.freedesktop.org,
	amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	hdegoede@redhat.com,
	Cezary Rojewski <cezary.rojewski@intel.com>
Subject: [PATCH v2 4/4] ALSA: hda: Reuse for_each_pcm_streams()
Date: Fri, 23 Feb 2024 12:46:26 +0100
Message-Id: <20240223114626.1052784-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240223114626.1052784-1-cezary.rojewski@intel.com>
References: <20240223114626.1052784-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 36RFMQ2WNXX6YGBBFW5Q7QHO4EJKN6KI
X-Message-ID-Hash: 36RFMQ2WNXX6YGBBFW5Q7QHO4EJKN6KI
X-MailFrom: cezary.rojewski@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/36RFMQ2WNXX6YGBBFW5Q7QHO4EJKN6KI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use the macro to improve readability.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/pci/hda/hda_codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 12f02cdc9659..2cac337f5263 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -3313,7 +3313,7 @@ int snd_hda_codec_parse_pcms(struct hda_codec *codec)
 	list_for_each_entry(cpcm, &codec->pcm_list_head, list) {
 		int stream;
 
-		for (stream = 0; stream < 2; stream++) {
+		for_each_pcm_streams(stream) {
 			struct hda_pcm_stream *info = &cpcm->stream[stream];
 
 			if (!info->substreams)
-- 
2.25.1

