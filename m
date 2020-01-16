Return-Path: <SRS0=iD9L=3F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14865C47409
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:47:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9797D206D5
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jan 2020 12:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cWH8piXm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyWIfQa7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9797D206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B35617CE;
	Thu, 16 Jan 2020 13:46:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B35617CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579178855;
	bh=+ATZUvwMPPVsp2jVVcBARJ7WnOZhcaS+II/Dl525cZw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cWH8piXmEc6Qq3KDBxCXvWN/Py2g+WLzJgH7tJJzQj3Gc9GBtnPu2T6e5Lpq+evVr
	 dKpqXTqEZGukbHZ6vBJraERouMKNWz/5AWEoP6H7xZRREeS/QNMZeFOUKBBHMeSNJj
	 m0X/PU0hZYI1hGE61e3Tidw6p/Bc1rb0W7q7VaSQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5164F801F2;
	Thu, 16 Jan 2020 13:45:54 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DB7F5F8021E; Thu, 16 Jan 2020 13:45:52 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3A34F800B9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2020 13:45:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3A34F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="cyWIfQa7"
Received: from localhost (unknown [223.226.122.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C11A82075B;
 Thu, 16 Jan 2020 12:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579176565;
 bh=kYzkOEmCDFe62a7WuBff4raLrGb2r2xPUtR2Sr2MPTI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cyWIfQa78sWdoZCbKCO+81DnbHCnlIUxwC0VvYv6raWoCBzmbApTn6jHKO9It6VwC
 p+vvDgh6e/pP/svKhamE3fkQA0gnbDE7amC3MJHYdX53nL22eCNiUNC2jaGqd3PZco
 +6d776W26zvyKPuB57R26Rq4chYXifN3kBMEQUDc=
Date: Thu, 16 Jan 2020 17:39:18 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <20200116120918.GR2818@vkoul-mobl>
References: <20200114233124.13888-1-pierre-louis.bossart@linux.intel.com>
 <20200116120459.GP2818@vkoul-mobl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200116120459.GP2818@vkoul-mobl>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] soundwire: cadence: fix kernel-doc
	parameter descriptions
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

T24gMTYtMDEtMjAsIDE3OjM1LCBWaW5vZCBLb3VsIHdyb3RlOgo+IE9uIDE0LTAxLTIwLCAxNzoz
MSwgUGllcnJlLUxvdWlzIEJvc3NhcnQgd3JvdGU6Cj4gPiBGaXggcHJldmlvdXMgdXBkYXRlLCBi
YWQgZ2l0IG1lcmdlIGxpa2VseS4gb29wcy4KPiAKPiBBcHBsaWVkLCB0aGFua3MKCkJ0dyBJIHN0
aWxsIGhhdmUgdGhlc2Ugd2FybnMgb24gbXkgbmV4dCB3aXRoIFc9MQoKZHJpdmVycy9zb3VuZHdp
cmUvaW50ZWxfaW5pdC5jOjE5Mzo3OiB3YXJuaW5nOiBubyBwcmV2aW91cyBwcm90b3R5cGUgZm9y
IOKAmHNkd19pbnRlbF9pbml04oCZIFstV21pc3NpbmctcHJvdG90eXBlc10KIHZvaWQgKnNkd19p
bnRlbF9pbml0KGFjcGlfaGFuZGxlICpwYXJlbnRfaGFuZGxlLCBzdHJ1Y3Qgc2R3X2ludGVsX3Jl
cyAqcmVzKQogICAgICAgXn5+fn5+fn5+fn5+fn4KZHJpdmVycy9zb3VuZHdpcmUvY2FkZW5jZV9t
YXN0ZXIuYzoxMDIyOiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdjbG9j
a19zdG9wX2V4aXQnIG5vdCBkZXNjcmliZWQgaW4gJ3Nkd19jZG5zX2luaXQnCiAgTEQgW01dICBk
cml2ZXJzL3NvdW5kd2lyZS9zb3VuZHdpcmUtY2FkZW5jZS5vCmRyaXZlcnMvc291bmR3aXJlL2lu
dGVsX2luaXQuYzoyMTQ6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBtZW1iZXIgJ2N0
eCcgbm90IGRlc2NyaWJlZCBpbiAnc2R3X2ludGVsX2V4aXQnCmRyaXZlcnMvc291bmR3aXJlL2lu
dGVsX2luaXQuYzoyMTQ6IHdhcm5pbmc6IEV4Y2VzcyBmdW5jdGlvbiBwYXJhbWV0ZXIgJ2FyZycg
ZGVzY3JpcHRpb24gaW4gJ3Nkd19pbnRlbF9leGl0JwoKLS0gCn5WaW5vZApfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlz
dApBbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVj
dC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
