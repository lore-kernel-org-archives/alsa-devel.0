Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA2CC2D0E4
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 22:21:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDD82076E
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 22:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fmQ3iGyi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mailoo.org header.i=@mailoo.org header.b="HuMTfxeR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDD82076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mailoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4375A1742;
	Tue, 24 Nov 2020 23:20:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4375A1742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606256508;
	bh=Zv2iqi/lZFLtCiEbQyPJtG2tEUhBLriaZTvWYj1OZOs=;
	h=Subject:From:To:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fmQ3iGyiaGJk2FiamrWrnzSKeX8UmKgNm+q3Go6mjZ48IEu64qqmVvI3tADKDs8Hl
	 i8ejjOLHT7OUPsGI7uOva2rD2gHYlY32akLiqs+N/WIVw8WEV+moWJG1GeqGG6tfOn
	 8z5a+ZRR0YJyLKNU1TBHEklS6VGQAsPo6UH4rfKc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2FCFF800C1;
	Tue, 24 Nov 2020 23:20:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A334EF80165; Tue, 24 Nov 2020 23:20:56 +0100 (CET)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 00001F800C1
 for <alsa-devel@alsa-project.org>; Tue, 24 Nov 2020 23:20:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00001F800C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mailoo.org header.i=@mailoo.org
 header.b="HuMTfxeR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
 t=1606256447; bh=Zv2iqi/lZFLtCiEbQyPJtG2tEUhBLriaZTvWYj1OZOs=;
 h=X-EA-Auth:Message-ID:Subject:From:To:Date:Content-Type:
 MIME-Version:Content-Transfer-Encoding;
 b=HuMTfxeR3DtAV3bEG2fk4QVhxcVIKrGQs9EJuqWuD97r5n5vmw3RvbXqLDUtzvt2B
 GEqcYPMql1yn9YPRyaIFvTZt7YNhK4oUfVGXarksvWR+jaP2KlNipormrR2I8o4Dxr
 qPUi6oByZSPQtEkaDWrXvnOz9cVVqKlg2s6ETcvc=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
 via proxy.mailoo.org [213.182.55.207]
 Tue, 24 Nov 2020 23:20:47 +0100 (CET)
X-EA-Auth: lq+GW3UJ0XCFf9RTVO9KI3bEQmzJTpp9FgiYnLkYgSv8rKyaRinCxZXJmQ32+kg/BtKUr6sHWTDYjJ20Jz+r2M8lALw33BLvp7xiBdFks5A=
Message-ID: <f963978e5684ffd933d252d11d8cf7b14b2e00fb.camel@mailoo.org>
Subject: Dear akm.com, please publish/share AK4375[A] DAC datasheet
From: Vincent Knecht <vincent.knecht@mailoo.org>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Date: Tue, 24 Nov 2020 23:20:46 +0100
Content-Type: text/plain
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Thanks in advance



