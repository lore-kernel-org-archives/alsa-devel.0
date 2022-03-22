Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712E2C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Mar 2022 07:15:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F105916CC;
	Tue, 22 Mar 2022 08:14:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F105916CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647933308;
	bh=hGjRoxH+6JCWEw0whguZnUCgT3fGMhN7iVI4w6+PvUA=;
	h=From:To:Subject:Date:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CJw8t7dRvn1fUtXiV6I4F5/CRS72WZ+wPfHXIf9wk2xLnAiUW1toeZwb2K95RLeeW
	 mdDz3o3lKWEzQTPUoTYYo7lXkvl0VlGcP4yRJRMLc8CLl3JfJDzZf4TXB/Ee3a/Vei
	 xIHeyldZGHazMe2g05yZdsSKqv57F35lMEAHpsB0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6D86BF8012A;
	Tue, 22 Mar 2022 08:14:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16E8BF8016C; Tue, 22 Mar 2022 08:14:15 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7A7CEF80116
 for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2022 08:14:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A7CEF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dceDH6Mz"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22M7Cril065893;
 Tue, 22 Mar 2022 02:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1647933173;
 bh=U71nVSO+hSONrauFmnr7QvuSJDXB/wvwXfGLMI0sUhE=;
 h=From:To:CC:Subject:Date:References:In-Reply-To;
 b=dceDH6MzQ9aELggaGuRoBCzmXMnB42n9C/dRB5wEy3paU/61jxSU7s2stb3tYwgVz
 Dwg87fLrMeBqAFp96SWCZEPNIkSphVXH8WPVD4Ep8PMps0Id2sksWOwcgVKXBqpFau
 XiG86tZQIMpZRcx7lBJynMuAGfz9/5Tq43G7oWjA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22M7CrG0113379
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Mar 2022 02:12:53 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Mar 2022 02:12:53 -0500
Received: from DFLE107.ent.ti.com ([fe80::86f:14f0:164b:4dbe]) by
 DFLE107.ent.ti.com ([fe80::86f:14f0:164b:4dbe%17]) with mapi id
 15.01.2308.014; Tue, 22 Mar 2022 02:12:53 -0500
From: "Xu, Yang" <raphael-xu@ti.com>
To: Mark Brown <broonie@kernel.org>, Raphael-Xu <13691752556@139.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/2] support either TAS2764 or TAS2780
 device from TI
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/2] support either TAS2764 or TAS2780
 device from TI
Thread-Index: AQHYPSDTolFJ2wG/+kCSGo6twTwBNqzK/bkw
Date: Tue, 22 Mar 2022 07:12:53 +0000
Message-ID: <782e9789a3524e30b5617465d8242157@ti.com>
References: <20220318094903.22026-1-13691752556@139.com>
 <20220318094903.22026-2-13691752556@139.com> <YjhyLN0hwnatcdjt@sirena.org.uk>
In-Reply-To: <YjhyLN0hwnatcdjt@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.136.126]
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "Navada Kanyana, Mukund" <navada@ti.com>, "Ding, 
 Shenghao" <shenghao-ding@ti.com>
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

Hi Mark,

Just submit new patch which only rename the files as your suggestion.Please=
 check the new patchs,thanks.

Regards
Raphael
-----Original Message-----
From: Mark Brown <broonie@kernel.org>=20
Sent: Monday, March 21, 2022 8:40 PM
To: Raphael-Xu <13691752556@139.com>
Cc: alsa-devel@alsa-project.org; Xu, Yang <raphael-xu@ti.com>; Ding, Shengh=
ao <shenghao-ding@ti.com>; Navada Kanyana, Mukund <navada@ti.com>
Subject: [EXTERNAL] Re: [PATCH v2 2/2] support either TAS2764 or TAS2780 de=
vice from TI

On Fri, Mar 18, 2022 at 05:49:03PM +0800, Raphael-Xu wrote:
> Signed-off-by: Raphael-Xu <13691752556@139.com>
> ---
>  sound/soc/codecs/Kconfig                  |  13 +-
>  sound/soc/codecs/Makefile                 |   4 +-
>  sound/soc/codecs/tas2764.c                | 688 -----------------
>  sound/soc/codecs/tas27xx.c                | 861 ++++++++++++++++++++++
>  sound/soc/codecs/{tas2764.h =3D> tas27xx.h} |  27 +-
>  5 files changed, 890 insertions(+), 703 deletions(-)

Can you please respin this with a separate patch *just* doing the file rena=
mes?  git format-patch noticed that the header was a rename but it didn't m=
anage to figure that out for the main driver file which makes it much harde=
r to review what's actually changed underneath the rename.
