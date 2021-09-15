Return-Path: <SRS0=xeto=OF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF810C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 08:45:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CE7861212
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Sep 2021 08:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CE7861212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1214017BA;
	Wed, 15 Sep 2021 10:45:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1214017BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631695553;
	bh=dKAZ/IJ5FY5dxVRmNKjIMIuHkA4Szv63UFxfSKJopN8=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Xbl35FUn1pnO1y7x0fYPXj7tJkua5R/FVHhQzSyxhYsjRzzsu2EcE+nVE0KcdbFS6
	 DLzehacSqofWd+7tGeD8GYVrebVq4U6H0YTuKqp6m8ILp3z+fwhR9XbxvQUf7pdJxT
	 IRztC0I7B5X6cAnuCly02wi8Vrbv8b8JxVAq2vMc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 77AB4F80227;
	Wed, 15 Sep 2021 10:45:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B87E5F8027C; Wed, 15 Sep 2021 10:44:57 +0200 (CEST)
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch
 [185.70.40.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 792B3F800EF
 for <alsa-devel@alsa-project.org>; Wed, 15 Sep 2021 10:44:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 792B3F800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="ltcGwYXf"
Date: Wed, 15 Sep 2021 08:44:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1631695493;
 bh=PmMMW/PMwCy83iN7ibnySmyUiOmGviDzgbB2tjIIN1E=;
 h=Date:To:From:Reply-To:Subject:From;
 b=ltcGwYXfpW/XOMsYsLlLxpRnJGLQgxHHZ49j+m6sNyd7MJe6y+62dSuPL+xCccAp1
 SHPsCZvfyv+ivUpfmzLKxPNbCP7FWAMfA//PConl0XBB8iFao6nWm3EetqHc2IuQL6
 s3vaqszhe+6/YCNFAhPGUx4j4z5CNoGj4nUcMBg0=
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Ryan McClue <re.mcclue@protonmail.com>
Subject: Location Of _snd_ctl_ops Definitions
Message-ID: <F8QtqhEtr7zd-TLTxx_4bX0GAXvq-griyYIyEpXrRybmRihHHpwt5nZUCn97mDEbJSW9TTesUMmwmFUukYEjWnGsCYi70LZhg6BA6iF9BMQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
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
Reply-To: Ryan McClue <re.mcclue@protonmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

VGhlIHN0cnVjdCBfc25kX2N0bF9vcHMgY29udGFpbnMgYSBudW1iZXIgb2YgZnVuY3Rpb24gcG9p
bnRlcnMuCldoZXJlIGFyZSB0aGVzZSBmdW5jdGlvbnMgZGVmaW5lZCBpbiB0aGUgYWxzYS1saWIg
c291cmNlIHRyZWUsIGUuZyBpbnQgKCpzdWJzY3JpYmVfZXZlbnRzKShzbmRfY3RsX3QgKmhhbmRs
ZSwgaW50IHN1YnNjcmliZSkKCi0tClJ5YW4gTWNDbHVlLCBTeWRuZXk=
