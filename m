Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AD3C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 01:18:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79C581913;
	Wed,  2 Mar 2022 02:17:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79C581913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646183906;
	bh=nIvvaem+k+6hnx/ohPtVgwNDvGvdINIt+iVn6LJ7TVU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=c61oZX8mjoOWTbgK0VvjfUmpCBcprmX0TNdKjKB3e7EF0QU/FSWQWsCVc7QszlVGT
	 wncsmg7eryh+q2vjfeps/nndUdhfRip4+UlaJEX5uQ6YUZMvcS7eOCwlrB6IXSlwcS
	 /jUFp1dUag3Piub4vmxP7jCCIiaXIQdn7anwMYfk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D1FEF801D8;
	Wed,  2 Mar 2022 02:17:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7EA1F80227; Wed,  2 Mar 2022 02:17:34 +0100 (CET)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84825F80054
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 02:17:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84825F80054
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DW; RN=8; SR=0; TI=W4_0.1.10_DEFAULT_21281DB5_1646183748019_o7001c92l;
Received: from WS-web
 (yang.lee@linux.alibaba.com[W4_0.1.10_DEFAULT_21281DB5_1646183748019_o7001c92l])
 by e01e07461.eu6 at Wed, 02 Mar 2022 09:17:21 +0800
Date: Wed, 02 Mar 2022 09:17:21 +0800
From: "Yang.Lee" <yang.lee@linux.alibaba.com>
To: "Mark Brown" <broonie@kernel.org>
Message-ID: <53306907-c963-4740-9a90-c1249ba0dff4.yang.lee@linux.alibaba.com>
Subject: =?UTF-8?B?5Zue5aSN77yaW1BBVENIIC1uZXh0XSBBU29DOiBhbWQ6IEZpeCBhbiBpZ25vcmVkIGVycm9y?=
 =?UTF-8?B?IHJldHVybiBmcm9tIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCk=?=
X-Mailer: [Alimail-Mailagent][W4_0.1.10][DEFAULT][Chrome]
MIME-Version: 1.0
References: <20220301064920.37788-1-yang.lee@linux.alibaba.com>,
 <Yh4UGGuspsc/gAyY@sirena.org.uk>
x-aliyun-mail-creator: W4_0.1.10_DEFAULT_TCwTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzkxLjAuNDQ3Mi4xMjQgU2FmYXJpLzUzNy4zNiBFZGcvOTEuMC44NjQuNjQ=FR
In-Reply-To: <Yh4UGGuspsc/gAyY@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel <alsa-devel@alsa-project.org>, tangmeng <tangmeng@uniontech.com>,
 Abaci Robot <abaci@linux.alibaba.com>, tiwai <tiwai@suse.com>,
 lgirdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
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
Reply-To: "Yang.Lee" <yang.lee@linux.alibaba.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

VGhlIGZ1bmN0aW9uIGRldl9lcnJfcHJvYmUoKSBpcyBjYWxsZWQgaW4gZnVuY3Rpb24gcGxhdGZv
cm1fZ2V0X2lycV9ieW5hbWUoKSB0byBwcmludCB0aGUgZXJyb3IgY29kZS4KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCuWP
keS7tuS6uu+8mk1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4K5Y+R6YCB5pe26Ze077ya
MjAyMuW5tDPmnIgx5pelKOaYn+acn+S6jCkgMjA6NDAK5pS25Lu25Lq677yaWWFuZyBMaSA8eWFu
Zy5sZWVAbGludXguYWxpYmFiYS5jb20+CuaKhOOAgOmAge+8mmxnaXJkd29vZCA8bGdpcmR3b29k
QGdtYWlsLmNvbT47IHBlcmV4IDxwZXJleEBwZXJleC5jej47IHRpd2FpIDx0aXdhaUBzdXNlLmNv
bT47IHRhbmdtZW5nIDx0YW5nbWVuZ0B1bmlvbnRlY2guY29tPjsgYWxzYS1kZXZlbCA8YWxzYS1k
ZXZlbEBhbHNhLXByb2plY3Qub3JnPjsgbGludXgta2VybmVsIDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgQWJhY2kgUm9ib3QgPGFiYWNpQGxpbnV4LmFsaWJhYmEuY29tPgrkuLvjgIDp
opjvvJpSZTogW1BBVENIIC1uZXh0XSBBU29DOiBhbWQ6IEZpeCBhbiBpZ25vcmVkIGVycm9yIHJl
dHVybiBmcm9tIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkKCk9uIFR1ZSwgTWFyIDAxLCAyMDIy
IGF0IDAyOjQ5OjIwUE0gKzA4MDAsIFlhbmcgTGkgd3JvdGU6Cgo+IC0gYWRhdGEtPmkyc19pcnEg
PSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZShwZGV2LCAiYWNwX2RhaV9pcnEiKTsKPiAtIGlmIChh
ZGF0YS0+aTJzX2lycSA8IDApCj4gKyBhZGF0YS0+aTJzX2lycSA9IHJldCA9IHBsYXRmb3JtX2dl
dF9pcnFfYnluYW1lKHBkZXYsICJhY3BfZGFpX2lycSIpOwo+ICsgaWYgKHJldCA8IDApCj4gICAg
cmV0dXJuIC1FTk9ERVY7CgpJZiBhbiBlcnJvciBjb2RlIGlzIGJlaW5nIHJldHVybmVkIHdlIHNo
b3VsZCByZXBvcnQgdGhhdCBlcnJvciBjb2RlCnJhdGhlciB0aGFuIHNxdWFzaGluZyBpdCBkb3du
IHRvIC1FTk9ERVYuCgo=
