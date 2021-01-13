Return-Path: <SRS0=Rjjp=GQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0FEC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:35:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5693923382
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Jan 2021 15:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5693923382
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3DB61712;
	Wed, 13 Jan 2021 16:34:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3DB61712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610552099;
	bh=kwULFix9G7pbW0wVEOfUIeEVZgL0bDNVUPPElIw2L5I=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bU7sL0TdYtpd/gH8Vrq6HX5XoRPWe1Xy8p1qTHspVV76XVOZzB6KQeM1BCaFijS/f
	 SQ27HXOLmUNeL9eRZQn/HNX03bBI4GPtvBXgxOT7X9Xlfd6gsaszo2+2VXnDw5ypTJ
	 JlCwYN8MWy0m18JFMfjPJewx5d+cZdh7ehQZyAXI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59E21F80085;
	Wed, 13 Jan 2021 16:34:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7678AF801ED; Wed, 13 Jan 2021 16:34:05 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D7C5F8014D
 for <alsa-devel@alsa-project.org>; Wed, 13 Jan 2021 16:33:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D7C5F8014D
IronPort-SDR: KfJSPo4Fbwj5x03zUqLBv37IlRa1TlgYxS9K5r2939nsmPCaR4L6YwOIODyxxm+Tpxo7ZNljGf
 OdxjuMPu7YYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="239759102"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; d="scan'208";a="239759102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jan 2021 07:33:56 -0800
IronPort-SDR: hjMEXaxfebTLlTXbTXzD+7BCsh6JSp020H2wQBESIl1uklTjbQvwP4c2kuSh67t3f9xq4j2owl
 usP0MTcdj9Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; d="scan'208";a="348856443"
Received: from kekkonen.fi.intel.com ([10.237.72.68])
 by orsmga003.jf.intel.com with ESMTP; 13 Jan 2021 07:33:55 -0800
From: Jaska Uimonen <jaska.uimonen@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH v2 0/2] Enable using multiple kcontrol types in a widget
Date: Wed, 13 Jan 2021 17:25:38 +0200
Message-Id: <20210113152540.2116439-1-jaska.uimonen@linux.intel.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Jaska Uimonen <jaska.uimonen@linux.intel.com>
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

I'm requesting comments to this small series to enable multiple
different kcontrol types for a single widget.

Currently asoc allows to define and parse multiple same type kcontrols
for single widget. So you can have for example two volume controls in a
widget but not for example one byte and one enum control. I personally
had this kind of use case where I wanted to set filter coefficients with
bytes and something else with an enum in one processing widget.

I don't have that good perspective on the asoc history on this part so I
don't know is there some reason for the existing logic or is it just ok
to change it like in this series. I've been told some drivers use
virtual widget for this kind of situation, so they define two widget's
(one virtual) with separate controls, but in reality bind the controls
into the same component in lower level. Or can we just actually use
separate types in one widget?

First patch is changing the kcontrol_type uint in dapm widget to a
pointer to hold an array of kcontrol types and then creating these
different types in a loop in dapm widget load. Second patch is me
utilizing this in sof driver.

Changes since v1:
- don't add kcontrol type to core i.e. to kcontrol and kcontrol_news
- extend existing dapm widget kcontrol_type into holding an array of
  types

Jaska Uimonen (2):
  ASoC: soc-dapm: enable use of multiple control types
  ASoC: SOF: topology: use individual kcontrol types

 include/sound/soc-topology.h |   2 +-
 sound/soc/soc-topology.c     | 466 +++++++++++++++++------------------
 sound/soc/sof/topology.c     |  13 +-
 3 files changed, 232 insertions(+), 249 deletions(-)

-- 
2.24.1

