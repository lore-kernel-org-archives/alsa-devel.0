Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11EDC352A5
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:17:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 753FB20838
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 14:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NtFTNqLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753FB20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7D66166E;
	Mon, 10 Feb 2020 15:07:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7D66166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581343683;
	bh=GGP815sKohAfoaew6PXS1iIL7EOl1q4GCsetSOT0y2w=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NtFTNqLphXDjIGukOMBICcqIeRgZ9kF8TH/UFGZBUTZNrF2FrdzwArApLBZuL1f6v
	 xakhnFaG5fHKmWLAfvkgUHr4YoTwFuH63V7A0snEVMFefOYmOMH4m/J7ngmZuHUjWI
	 qLMyLHxk5QNgu8rP9WSyiXtOp8iYXsVY27B6UL9c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B368F8014F;
	Mon, 10 Feb 2020 15:07:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D0DC9F80157; Mon, 10 Feb 2020 15:07:11 +0100 (CET)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9B54F800E7
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 15:07:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9B54F800E7
IronPort-SDR: oqRzx0lXeeEg1xEKCEYbiDRhMQnV5Z49laxCyJx2NwCuazksmSlX5zi8MiVa3XCa/ZrylOLCrN
 w5o7n7KijAOGquSqqcNOBbezUaBGD7DXl978dHmJcefftrJcJmMT3OJ3c0BI8LQmiYYIr1eFMZ
 a2rWx5gwUX6ZiaAoZbLmk2/aWELFPlMIcVsOd7ZhxEg1CNBZQD04Zb6qOQPiaMgYVtyXTeu1Dj
 BAzWGTxxGEZSHYZTYTuzhJ4IfWRhu0KKDIsfKOQtaEBGx/7Cn1LQlqT6+LtzAthf/gdf/Em+Zs
 Y/o=
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; d="scan'208,217";a="45728364"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
 by esa4.mentor.iphmx.com with ESMTP; 10 Feb 2020 06:07:06 -0800
IronPort-SDR: e+6fzJfsFuKVrXa9NzyW694TluiUf9ZcyADi2utfT+DZo542CqLunYilpMaaP/Jbcydnn3jfjq
 cds0tSmNvH07eT/6/J5ebR7BBbdcHqYi8s897g0NteEI9/TrgqYJ+0oQSfPug2iYSI1EZ41VcI
 mBClLnPSkWCaX/aRj+MIvoUHAjdHfeQoSWokPszLDlrjZM6qqcwk2T3pzGVpEUX59onxPRmXal
 w8bvd+/rPh7oQ76AQ7t36MvmbGGw4vfU1BwirwIkHmes1Jb+s/TlAUOcAvVxOe1fub5cPdcu6b
 jTM=
From: "Sutar, Mounesh" <Mounesh_Sutar@mentor.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Thread-Topic: unsubscribe mounesh_sutar@mentor.com
Thread-Index: AdXgG1n3oZ3XJwB4RHKD7NuvQL1qjA==
Date: Mon, 10 Feb 2020 14:07:01 +0000
Message-ID: <04d8373c32d842a899636399ab14a0a2@SVR-IES-MBX-04.mgc.mentorg.com>
Accept-Language: en-US, en-IE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
MIME-Version: 1.0
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Subject: [alsa-devel] unsubscribe mounesh_sutar@mentor.com
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

unsubscribe mounesh_sutar@mentor.com
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
