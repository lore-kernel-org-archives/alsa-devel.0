Return-Path: <SRS0=JMHt=2M=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01AAC2D0C0
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 16:27:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D518E2070A
	for <alsa-devel@archiver.kernel.org>; Sun, 22 Dec 2019 16:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lF9BwQR5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="tAU8nMI+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="QgPaewRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D518E2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=akkea.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E96C1660;
	Sun, 22 Dec 2019 17:27:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E96C1660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1577032072;
	bh=xH9496dKshZEn5MH3gNYo8ocIFu5XAcJtBeUwoQd+Lc=;
	h=Date:From:To:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lF9BwQR52vQQsR29hKdjeM/I5ZEXkEhYHwQSCk/EbnA6j0nzHWTmacqQkjy3voOE6
	 axSBOD5BVm9MG7AL4x+2frVuel+7lLHVfiC+E/XMRMvZJvGBlGB4QdgjDT8zHIQ11M
	 JzYeeObn+KZZLsmC/WiXxI7VPeMoF2OtbiHKRRkU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BFDDF8011C;
	Sun, 22 Dec 2019 17:27:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7D678F80136; Sun, 22 Dec 2019 17:26:58 +0100 (CET)
Received: from node.akkea.ca (node.akkea.ca [192.155.83.177])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9E30BF800AD
 for <alsa-devel@alsa-project.org>; Sun, 22 Dec 2019 17:26:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E30BF800AD
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="tAU8nMI+"; 
 dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca
 header.b="QgPaewRv"
Received: from localhost (localhost [127.0.0.1])
 by node.akkea.ca (Postfix) with ESMTP id 5997E4E2006;
 Sun, 22 Dec 2019 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1577032012; bh=lk9n/H5OSRh/eNco0XIFOxKBT6v9JzTnq1Z23DQmHEE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=tAU8nMI+A66/QdQwZA2pwNdrzATWia4EeolinMMU1jAcyZL+fglcCS3oUTOFy+ThO
 BGUxVDCD4QE3O5/vd3sDUj5mNF02iipVrkvGsT87SqV/G8oNmONgVtvh7ye/sGR8Nu
 gEt3+0Ji/GvnlH5411c40PApaFQoL3h86FH5ujiM=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
 by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0Ju1VJTmglr; Sun, 22 Dec 2019 16:26:51 +0000 (UTC)
Received: from www.akkea.ca (node.akkea.ca [192.155.83.177])
 by node.akkea.ca (Postfix) with ESMTPSA id C44C94E2003;
 Sun, 22 Dec 2019 16:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
 t=1577032011; bh=lk9n/H5OSRh/eNco0XIFOxKBT6v9JzTnq1Z23DQmHEE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QgPaewRv2sRM8fKVBqjqVQMZPUjRwmFsgBADtmiybFwygb8QbDiI/kUQWSWvB/XZA
 cIRz2yK0Dvi14pAikoDCg2Ce3M32fPvZ2cij7clvJ2AEbU+sl/EnPVxGiO+PHIiCSV
 0qhPvkRdE2TJ7NYLfESfcIno9oy1y7X0YnDBUWYc=
MIME-Version: 1.0
Date: Sun, 22 Dec 2019 08:26:51 -0800
From: Angus Ainslie <angus@akkea.ca>
To: Mark Brown <broonie@kernel.org>
In-Reply-To: <20191220130143.GF4790@sirena.org.uk>
References: <20191219210944.18256-1-angus@akkea.ca>
 <20191219210944.18256-2-angus@akkea.ca>
 <20191220130143.GF4790@sirena.org.uk>
Message-ID: <499dffad51cb7819bd118ad15048816c@akkea.ca>
X-Sender: angus@akkea.ca
User-Agent: Roundcube Webmail/1.3.6
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, kernel@puri.sm,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ASoC: gtm601: add Broadmobi bm818
	sound profile
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gMjAxOS0xMi0yMCAwNTowMSwgTWFyayBCcm93biB3cm90ZToKPiBPbiBUaHUsIERlYyAxOSwg
MjAxOSBhdCAwMTowOTo0M1BNIC0wODAwLCBBbmd1cyBBaW5zbGllIChQdXJpc20pIHdyb3RlOgo+
IAo+PiAgc3RhdGljIGludCBndG02MDFfcGxhdGZvcm1fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikKPj4gIHsKPj4gKwlzdHJ1Y3Qgc25kX3NvY19kYWlfZHJpdmVyICpkYWlfZHJp
dmVyOwo+PiArCj4+ICsJZGFpX2RyaXZlciA9IG9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRl
di0+ZGV2KTsKPj4gKwo+IAo+IEkgd2FzIGdvaW5nIHRvIGFwcGx5IHRoaXMgYnV0IGl0IGNhdXNl
cyBidWlsZCB3YXJuaW5nczoKPiAKPiBzb3VuZC9zb2MvY29kZWNzL2d0bTYwMS5jOiBJbiBmdW5j
dGlvbiDigJhndG02MDFfcGxhdGZvcm1fcHJvYmXigJk6Cj4gc291bmQvc29jL2NvZGVjcy9ndG02
MDEuYzo4MzoxMzogd2FybmluZzogYXNzaWdubWVudCBkaXNjYXJkcyDigJhjb25zdOKAmQo+IHF1
YWxpZmllciBmcm9tIHBvaW50ZXIgdGFyZ2V0IHR5cGUgWy1XZGlzY2FyZGVkLXF1YWxpZmllcnNd
Cj4gICBkYWlfZHJpdmVyID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOwo+
ICAgICAgICAgICAgICBeCgpTb3JyeSwgbWlzc2VkIHRoYXQuCgpOZXcgdmVyc2lvbiBpbmJvdW5k
LgoKQW5ndXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
QWxzYS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHBz
Oi8vbWFpbG1hbi5hbHNhLXByb2plY3Qub3JnL21haWxtYW4vbGlzdGluZm8vYWxzYS1kZXZlbAo=
