Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57405C10F1B
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Dec 2022 10:27:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E21016BA;
	Wed, 21 Dec 2022 11:26:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E21016BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1671618442;
	bh=sMQaJw40v9O/0ooEQR8exjRFdMBmfeRaMmopj4aN0Q4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=hjoWCn2hso2G1Mv+HW/Ohqvok65QLcODB3tJGzboOB6jX54Tn/J3T6Lig6CB67iCm
	 8w/Zy3uIoMKyBmTqaFmm4E4lZFOKtxSNy278a6MSqHbnHFKQN4VuDcoGXl/evFcr0z
	 mRO0/AaET3rHIn2j9VyQ+k/VF+6RxJ2Jo69f8pL0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E40E0F80578;
	Wed, 21 Dec 2022 11:24:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30E01F804AD; Wed, 21 Dec 2022 11:23:50 +0100 (CET)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CA43F8024D
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2022 11:23:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3CA43F8024D
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=FfqMfjRl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1671618229; x=1703154229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sMQaJw40v9O/0ooEQR8exjRFdMBmfeRaMmopj4aN0Q4=;
 b=FfqMfjRlpEQEyzvx+MLXpQR8TuiJ75HR6GKfpqrIMyXKIJNwSDQlKdym
 2iQfzqyPU25D07uDMoMxqrLYG3FSlqQuDrg67eIFQQZg81pcL6hdcbn4w
 o/qnzOWAmJIM1zyue+VZ8mlUqX8bUU2QhyjZkFIU1YiC/d1nXQPFb9S0h
 QZssPyYbLMdDm+mg3AxhbHtcixJjQThPNGR3Y49IH7Rz8KSCdccPm34iq
 uKIrkHkN3pVpYjoNNQzrDLJxfAdRrqnd1aNGz+WByqLC0WX8iQenmL5tq
 sqOcELNcIflDWUwOmrO6eq9BOWq3tKGojtLcxb0eAK9UnRyrWFo76hprd Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="406078676"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; d="scan'208";a="406078676"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2022 02:23:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="681984367"
X-IronPort-AV: E=Sophos;i="5.96,262,1665471600"; d="scan'208";a="681984367"
Received: from cofearra-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.20.202])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2022 02:23:43 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 09/11] ASoC: SOF: sof-priv: Mark fw_tracing ops optional in
 documentation
Date: Wed, 21 Dec 2022 12:23:26 +0200
Message-Id: <20221221102328.9635-10-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221102328.9635-1-peter.ujfalusi@linux.intel.com>
References: <20221221102328.9635-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, rander.wang@intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The code treats the fw_tracing as optional feature but the documentation
was not reflecting this.
Correct it by explicitly stating that the fw_tracing is optional.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/sof/sof-priv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 144906c4cb63..752bf46c7bc9 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -444,7 +444,7 @@ struct sof_ipc_pcm_ops;
  * @pm:		Pointer to PM ops
  * @pcm:	Pointer to PCM ops
  * @fw_loader:	Pointer to Firmware Loader ops
- * @fw_tracing:	Pointer to Firmware tracing ops
+ * @fw_tracing:	Optional pointer to Firmware tracing ops
  *
  * @init:	Optional pointer for IPC related initialization
  * @exit:	Optional pointer for IPC related cleanup
-- 
2.39.0

