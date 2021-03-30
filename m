Return-Path: <SRS0=2x8D=I4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BB5C433C1
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 02:33:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B8061990
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Mar 2021 02:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B8061990
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 380531675;
	Tue, 30 Mar 2021 04:32:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 380531675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617071611;
	bh=kfgGgbJcZ1LkpbrCgECTFj1D71w8i5qFEKi5ym+lv04=;
	h=Date:In-Reply-To:References:From:To:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bLI0p9L6rChEwkZVDgd0/xboVWDX0tAxmE82Yem40ERU8Ad76SJCjRYVxARF7xZbj
	 /LR8FSkP7lVY677C9Qp9ifD7SzeYUxTJ9CL38whgDS4cEjaTlfenUNypDX8xC+jdOV
	 eWuwd8N4fPihxbCEt4QXCEav4iWe5UOiGZM6BZDA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EDA6F8023E;
	Tue, 30 Mar 2021 04:32:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D356FF80240; Tue, 30 Mar 2021 04:32:37 +0200 (CEST)
Received: from mxct.zte.com.cn (mx7.zte.com.cn [202.103.147.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 64CA9F800B9
 for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2021 04:32:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 64CA9F800B9
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id A5D5E8C4130C2D2E03CA;
 Tue, 30 Mar 2021 10:32:20 +0800 (CST)
Received: from kjyxapp01.zte.com.cn ([10.30.12.200])
 by mse-fl1.zte.com.cn with SMTP id 12U2VtPo039357;
 Tue, 30 Mar 2021 10:31:55 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from mapi (kjyxapp02[null]) by mapi (Zmail) with MAPI id mid14;
 Tue, 30 Mar 2021 10:31:55 +0800 (CST)
Date: Tue, 30 Mar 2021 10:31:55 +0800 (CST)
X-Zmail-TransId: 2b0460628d9bfd829523
X-Mailer: Zmail v1.0
Message-ID: <202103301031552696596@zte.com.cn>
In-Reply-To: <s5hy2e6i4ka.wl-tiwai@suse.de>
References: 1616989007-34429-1-git-send-email-wang.yi59@zte.com.cn,
 s5hy2e6i4ka.wl-tiwai@suse.de
Mime-Version: 1.0
From: <wang.yi59@zte.com.cn>
To: <tiwai@suse.de>
Subject: =?UTF-8?B?UmU6W1BBVENIXSBBTFNBOiBjb3JlOiByZW1vdmUgcmVkdW5kYW50IHNwaW5fbG9jayBwYWlyIGluIHNuZF9jYXJkX2Rpc2Nvbm5lY3Q=?=
X-MAIL: mse-fl1.zte.com.cn 12U2VtPo039357
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64 
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, wang.liang82@zte.com.cn,
 linux-kernel@vger.kernel.org, tiwai@suse.com, zhou.jia2@zte.com.cn,
 xue.zhihong@zte.com.cn
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

SGkgVGFrYXNoaSwKClRoYW5rcyBhIGxvdCBmb3IgeW91ciByZXZpZXchCgo+IE9uIE1vbiwgMjkg
TWFyIDIwMjEgMDU6MzY6NDcgKzAyMDAsCj4gcm9vdCB3cm90ZToKPiA+Cj4gPiBbMS4xLjEgIDx0
ZXh0L3BsYWluOyBVVEYtOCAoYmFzZTY0KT5dCj4gPgo+ID4gRnJvbTogSmlhIFpob3UgPHpob3Uu
amlhMkB6dGUuY29tLmNuPgo+ID4KPiA+IG1vZGlmaWNhdGlvbiBpbiBjb21taXQgMmEzZjcyMjFh
Y2RkICgiQUxTQTogY29yZTogRml4IGNhcmQgcmFjZXMgYmV0d2Vlbgo+ID4gcmVnaXN0ZXIgYW5k
IGRpc2Nvbm5lY3QiKSByZXN1bHRpbmcgaW4gdGhpcyBwcm9ibGVtLgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IEppYSBaaG91IDx6aG91LmppYTJAenRlLmNvbS5jbj4KPiA+IFNpZ25lZC1vZmYtYnk6
IFlpIFdhbmcgPHdhbmcueWk1OUB6dGUuY29tLmNuPgo+Cj4gVGhlIGNvZGUgY2hhbmdlIGxvb2tz
IGdvb2QsIGJ1dCB0aGUgcGF0Y2ggaXNuJ3QgY2xlYW5seSBhcHBsaWNhYmxlIHZpYQo+IGdpdC1h
bS4gIENvdWxkIHlvdSBmaXggeW91ciBNVUEgc2V0dXAsIG9yIHRyeSB0byBzdWJtaXQgdmlhCj4g
Z2l0LXNlbmQtZW1haWw/CgpBcG9sb2dpc2UgdG8gdGhlIGluY29udmVuaWVudCBvZiB0aGUgZm9y
bWF0LiBUaGlzIGlzIGEgYnVnIGluIHRoZSBtYWlsIHN5c3RlbSBvZiBvdXIKY29tcGFueSdzIElU
IGRlcGFydG1lbnQsIHdoaWNoIGNvbmZ1ZWQgdXMgZm9yIGEgbG9uZyB0aW1lIGFuZCB3aWxsIGJl
IHJlc29sdmVkIGluCm5leHQgbW9udGggOigKCldvdWxkIHlvdSBwbGVhc2UgZG8gbWUgYSBmYXZv
ciB0byBhY2NlcHQgdGhpcyBwYXRjaCBtYW51YWxseT8gTWFueSB0aGFua3MuCgo+Cj4KPiB0aGFu
a3MsCj4KPiBUYWthc2hpCj4KPiA+IC0tLQo+ID4gIHNvdW5kL2NvcmUvaW5pdC5jIHwgMiAtLQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9z
b3VuZC9jb3JlL2luaXQuYyBiL3NvdW5kL2NvcmUvaW5pdC5jCj4gPiBpbmRleCAwMThjZTRlZjEu
LjlmNTI3MGM5MCAxMDA2NDQKPiA+IC0tLSBhL3NvdW5kL2NvcmUvaW5pdC5jCj4gPiArKysgYi9z
b3VuZC9jb3JlL2luaXQuYwo+ID4gQEAgLTM5MCwxMCArMzkwLDggQEAgaW50IHNuZF9jYXJkX2Rp
c2Nvbm5lY3Qoc3RydWN0IHNuZF9jYXJkICpjYXJkKQo+ID4gICAgICAgICAgcmV0dXJuIDA7Cj4g
PiAgICAgIH0KPiA+ICAgICAgY2FyZC0+c2h1dGRvd24gPSAxOwo+ID4gLSAgICBzcGluX3VubG9j
aygmY2FyZC0+ZmlsZXNfbG9jayk7Cj4gPgo+ID4gICAgICAvKiByZXBsYWNlIGZpbGUtPmZfb3Ag
d2l0aCBzcGVjaWFsIGR1bW15IG9wZXJhdGlvbnMgKi8KPiA+IC0gICAgc3Bpbl9sb2NrKCZjYXJk
LT5maWxlc19sb2NrKTsKPiA+ICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShtZmlsZSwgJmNhcmQt
PmZpbGVzX2xpc3QsIGxpc3QpIHsKPiA+ICAgICAgICAgIC8qIGl0J3MgY3JpdGljYWwgcGFydCwg
dXNlIGVuZGxlc3MgbG9vcCAqLwo+ID4gICAgICAgICAgLyogd2UgaGF2ZSBubyByb29tIHRvIGZh
aWwgKi8KPiA+IC0tCj4gPiAyLjE4LjQKPiA+CgoKCi0tLQpCZXN0IHdpc2hlcwpZaSBXYW5n

