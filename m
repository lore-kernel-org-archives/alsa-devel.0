Return-Path: <SRS0=2KR+=X3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2284C352AA
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:37:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C022218DE
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Oct 2019 08:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MwGGe6Tc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NU1Ix/Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C022218DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6AAE0166E;
	Wed,  2 Oct 2019 10:36:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6AAE0166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570005456;
	bh=LF9d0zpRhSQ7VS0731Dbty/Zz157OgI+rRORw1/b00k=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MwGGe6TcpEFQ1NyvsOKSwGob3sswNOtM9L1d13nn/yRgQnp6DhjMOS+R75d7n9hTI
	 fL9Idt8BYBQCApqaAqG2tVLiwMwUwSCY+Bn0oFA7jj24Iz8yHutoCaYiww9tBiw9OI
	 246oj8mEsCL7wvHaxjpA83hAdyChpBZxSeX9qRDk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 02D1AF8016F;
	Wed,  2 Oct 2019 10:36:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64C5AF80391; Wed,  2 Oct 2019 10:36:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D107BF8016F
 for <alsa-devel@alsa-project.org>; Wed,  2 Oct 2019 10:36:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D107BF8016F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="NU1Ix/Km"
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 450E5206C0;
 Wed,  2 Oct 2019 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570005399;
 bh=VFLFSHajzI2XLLn4FHsTaAlDTg/W3cYVMp1YuwmvH+E=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NU1Ix/Kmiz0krydxGjDuB0292uZb9C/dOsf9acv0fu1756Hd3IBh+PhWnpmUalpe/
 XubQulKwgX/z9RyzfjUfu23qPcERhitR771kDKeWbaWB76ZsRM7P+tHa0JhMSpuGgn
 /VHIR1Hao1kR4zq3naP8EpA+dKkq2LXEuo+q7zJI=
Date: Wed, 2 Oct 2019 10:36:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michal Suchanek <msuchanek@suse.de>
Message-ID: <20191002083637.GA1687317@kroah.com>
References: <20191002081717.GA4015@kitsune.suse.cz>
 <459d62805e8cb20e27667626e80d962569e7e83a.1570005196.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <459d62805e8cb20e27667626e80d962569e7e83a.1570005196.git.msuchanek@suse.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Vinod Koul <vkoul@kernel.org>, Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [alsa-devel] [PATCH 1/2] soundwire: depend on ACPI
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

T24gV2VkLCBPY3QgMDIsIDIwMTkgYXQgMTA6MzM6MjlBTSArMDIwMCwgTWljaGFsIFN1Y2hhbmVr
IHdyb3RlOgo+IFRoZSBkZXZpY2UgY2Fubm90IGJlIHByb2JlZCBvbiAhQUNQSSBhbmQgZ2l2ZXMg
dGhpcyB3YXJuaW5nOgo+IAo+IGRyaXZlcnMvc291bmR3aXJlL3NsYXZlLmM6MTY6MTI6IHdhcm5p
bmc6IOKAmHNkd19zbGF2ZV9hZGTigJkgZGVmaW5lZCBidXQKPiBub3QgdXNlZCBbLVd1bnVzZWQt
ZnVuY3Rpb25dCj4gIHN0YXRpYyBpbnQgc2R3X3NsYXZlX2FkZChzdHJ1Y3Qgc2R3X2J1cyAqYnVz
LAo+ICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4KPiAKPiBGaXhlczogN2MzY2QxODliODZkICgi
c291bmR3aXJlOiBBZGQgTWFzdGVyIHJlZ2lzdHJhdGlvbiIpCj4gU2lnbmVkLW9mZi1ieTogTWlj
aGFsIFN1Y2hhbmVrIDxtc3VjaGFuZWtAc3VzZS5kZT4KPiAtLS0KPiAgZHJpdmVycy9zb3VuZHdp
cmUvS2NvbmZpZyB8IDEgKwo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCjxmb3Jt
bGV0dGVyPgoKVGhpcyBpcyBub3QgdGhlIGNvcnJlY3Qgd2F5IHRvIHN1Ym1pdCBwYXRjaGVzIGZv
ciBpbmNsdXNpb24gaW4gdGhlCnN0YWJsZSBrZXJuZWwgdHJlZS4gIFBsZWFzZSByZWFkOgogICAg
aHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9zdGFibGUta2Vy
bmVsLXJ1bGVzLmh0bWwKZm9yIGhvdyB0byBkbyB0aGlzIHByb3Blcmx5LgoKPC9mb3JtbGV0dGVy
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRl
dmVsIG1haWxpbmcgbGlzdApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWls
bWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
