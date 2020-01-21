Return-Path: <SRS0=ytyY=3K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9981CC2D0DB
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:18:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2420524655
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WXWK66gF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yahoo.de header.i=@yahoo.de header.b="dsWtLfoC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2420524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A53D1669;
	Tue, 21 Jan 2020 09:17:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A53D1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579594720;
	bh=sfD5J/u5EXYJ/rj8UdqjdpC4/imuaF5Ihxv1n9krSTE=;
	h=To:References:From:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WXWK66gFoDIeu1uNdB7joH43wDsu3eSj2lp93iEnfvmSnfX1vTUba9WpHledyCwPb
	 bHeosGheXi36h1726AfEdyRINLs90HMUw5eXhxXSYRBcVysfxt1hWXZ0siGVGYssn/
	 RDy0W6TFuLr+c0zZfP4C4kMt3Kam+bqHCVjGkXxg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E653BF8015B;
	Tue, 21 Jan 2020 09:17:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6410F801D9; Tue, 21 Jan 2020 09:17:48 +0100 (CET)
Received: from sonic311-30.consmr.mail.ir2.yahoo.com
 (sonic311-30.consmr.mail.ir2.yahoo.com [77.238.176.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85AD9F800E7
 for <alsa-devel@alsa-project.org>; Tue, 21 Jan 2020 09:17:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85AD9F800E7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=yahoo.de header.i=@yahoo.de
 header.b="dsWtLfoC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s2048;
 t=1579594661; bh=1iWdI32FKyeKGA5/9rxHs8JbkXjq5gPdlM3QL3I20tM=;
 h=Subject:To:References:From:Date:In-Reply-To:From:Subject;
 b=dsWtLfoC+wl4mYQrSdKD5i52AEIG95aoOCZ/4qlgMuFWVUqOxUvQCZqdux0H5/jUKc1ZWraSTD9zdhZqDP+6n6xNLYKebu72lif2dCKD+W2ZfW0dEk0L30OqwLWMMdkKGBTLcHiS7Id1A99hjsEHjnroDMaUgsIT+1S8C/I0IVoFTKix+E+E/1tSFqTglLBAbqSpc80cm68QOZeaQgF5VIXZ2uYDT1PyyWFShsV41L5grQecD+7qd7YkDCtKajfv/7xnOvZkw/mkm80rTR8hqQI0+AsIfeA9XrRXqSYwyWZNa649sA0BCaLvArTapmUNhmAHk0lsU7o//FQ6fzqkmg==
X-YMail-OSG: X9WNq9EVM1lAn7mroUGks6_bZt4D9IyS._bN6BegOd3cQ3duxmbFMET1hHZ1qTH
 5TH93rVFua_REZK59jnne3Gx1yrX0oOXzmX6pPhP_UR3hIWbhkY_23gvyx3k.YzPvp..FtKhu.bO
 w1kY4OinKLSdSxeftV4i6vvzWCwVf_ClqU2TAZ3fDjgUuM240W_kBpQq3SzqJ6QEYMKYY3FqwTmx
 S39HKqgTMoVTrXBW7Xoe9UC9Tx9JgJZuKGROaGY_GxOrO2Mju22Fm7jI7VGeZEihOMCTnuI8FupI
 BRflSf7ggUqJjxnaZrQZDOhzA4l6oHbI2ZStzce7veOh59DWhj9D4PH0gxtDFaBICT8h4zJlxN7D
 rZ3a00YnPNYNPKoO1hA.VmKBKa0tkVLCzXDy6v8llSLVYcNBvoyxdg8NYbWROFjMP_KDDmL3Fq6s
 GO1Axtmmq3k_XOnwMmiAA4D7MbkUj4sMj2sExo3LMsny_rxwpuB26LNNd0d7L3RDO2_hCkxoOkzR
 LzzlC_CC4KfuST90OOgq1iBlN0_TYLXBZMmsioqiO17Kadh8zDKNDCZg57qpIVJzORJluw11QT8D
 _1uJ5iKEV.lIlvknTWw98mOHWEfQBFYNrH5QnZbzVmBuUQzr3vlj0kbb.cT9feO5UfK2gvDO_jzG
 pSTLq.xIEJ2LrnnMYF4YcOkZvXnRgl0ieSY.5ltdy19b7f9TWRGcx2vYekv_eKYX2L3tIniyb5ko
 sIQ4FbSfi2qTidMzQRI0_en7WMdx23RjbRpny2bI8D3IGH.v49Jnff1.cvQPKp9DQBTxXCEgNGsJ
 rUuJw_VBvqWnvp0VOJK8i1Wh53yGha5rxK1xRVAvFRouyzt2pQO7T0w5F_4pd7BpOjE1wxfDlyrR
 bZC4bf3.fqKyXIeB3UasJD6XpOtyq8gey4PwlanRsS9PKOxTUcDj.FxKPLrfyikoV.ZmRHn270Cw
 5QcASTaWhSCsYP5AadWI1nN0ZXGixoj04mnwGbZOKYXEhSMDlcsrsMO57Jlbs7gdJPlkbsH016Jo
 S.7_xnQYv.PfS1Z7gQpBa4ju81os_IsgnDQM8rKMkOD9NM_bKiTkkREccmKMKd2NSQq3jSMso7Ch
 8Ux2JYBP6Ge.CUM47oGZU3pUJzfHKF0Cr6ZB9mAvLDwdKKAtYpCFA.ZVk2_Jihw4JQUJSAy3EFeH
 WHIEPAcM0UF5qa1bpLGhwDmPWNOtyDkKzG5tRif9.KSIYCqK2ARgWKFM314bxUgvHS1xAa5.WdXM
 gU2hu6voy0LbblU4ztYmmW5EG3G5tknnGDmr1UQ04kJ8Op3OPTJHObyp_ExIHI3xdRMu3LtzYObN
 FdkcqojRd9Hn3LBTgBXmICCbStBBaTPSoklCPjM33r28AZttLZPKTjvFjE88ZTL4Ew.eT6iIQjTN
 W7QpaezR1d2w-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.ir2.yahoo.com with HTTP; Tue, 21 Jan 2020 08:17:41 +0000
Received: by smtp427.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 45c72941256810feb94a42b441765f32; 
 Tue, 21 Jan 2020 08:17:36 +0000 (UTC)
To: Alexander Tsoy <alexander@tsoy.me>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.de>
References: <9457db14-4084-c0dd-5c89-821b35c3db66.ref@yahoo.de>
 <9457db14-4084-c0dd-5c89-821b35c3db66@yahoo.de>
 <697208e751dcbcc70cf00af7b625a4109b9c66cb.camel@tsoy.me>
From: Tobias <toszlanyi@yahoo.de>
Message-ID: <a0e87326-839d-76df-dfd1-6d571017fc27@yahoo.de>
Date: Tue, 21 Jan 2020 09:17:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <697208e751dcbcc70cf00af7b625a4109b9c66cb.camel@tsoy.me>
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
Subject: Re: [alsa-devel] USB Audio Interface / Denon MC7000 and MC8000
 controller
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

VGhhbmtzIGEgbG90IGZvciB0aGUgaGludCBBbGV4YW5kZXIuIEFueWhvdywgSSBhbSBub3Qgc3Vy
ZSB3aGVyZSB0byBwdXQgCnRoYXQuCkFsc28gVGFrYXNoaSBJd2FpIHdhcyBpbnZvbHZlZCBhbHJl
YWR5IGFuZCBJIHdvdWxkIGxpa2UgdG8gcHJldmVudCAKbWl4aW5nIHVwIHRoaW5ncyBvciBkb3Vi
bGUgd29yay4KClBsZWFzZSBhZHZpc2UgaW4gZGV0YWlsIHdoYXQgSSB3b3VsZCBuZWVkIHRvIGRv
IGFzIEkgYW0gbm90IGEgcHJvZ3JhbW1lci4KClRoYW5rcyBhIGxvdC4KVG9iaWFzCgpBbSAyMC4w
MS4yMCB1bSAwOToyMiBzY2hyaWViIEFsZXhhbmRlciBUc295Ogo+INCSINCh0LEsIDE0LzEyLzIw
MTkg0LIgMDk6MjQgKzAxMDAsIFRvYmlhcyDQv9C40YjQtdGCOgo+PiBIZWxsbyBkZWFyIEFMU0Eg
ZGV2ZWxvcGVycy4KPj4KPj4gSSBoYXZlIHB1cmNoYXNlZCBhIE1DNzAwMCBjb250cm9sbGVyIGlu
IG9yZGVyIHRvIGNvbnRyb2wgTUlYWFggb24KPj4gVWJ1bnR1Cj4+IDE2LjA0LiBBY2NvcmRpbmcg
dG8gdGhlIERlbm9uIHNwZWNpZmljYXRpb24gdGhlIGNvbnRyb2xsZXIgc2hvdWxkCj4+IGhhdmUK
Pj4gYmVlbiBjbGFzcyBjb21wbGlhbnQgYnV0IHRoZXJlIGlzIGFuIGlzc3VlIHdpdGggdGhlIEF1
ZGlvIGludGVyZmFjZQo+PiB0bwo+PiB3b3JrIHByb3Blcmx5IGdpdmluZyBmb2xsb3dpbmcgbWVz
c2FnZSAuLi4KPj4KPj4gJCBkbWVzZwo+PiAuLi4KPj4+IFsgICA3NC41MjI4MzFdIHVzYiAxLTEu
MzogbmV3IGhpZ2gtc3BlZWQgVVNCIGRldmljZSBudW1iZXIgNiB1c2luZwo+Pj4geGhjaV9oY2QK
Pj4gWyAgIDc0LjYyMzc4NF0gdXNiIDEtMS4zOiBOZXcgVVNCIGRldmljZSBmb3VuZCwgaWRWZW5k
b3I9MTVlNCwKPj4gaWRQcm9kdWN0PTgwMDQKPj4gWyAgIDc0LjYyMzc4OV0gdXNiIDEtMS4zOiBO
ZXcgVVNCIGRldmljZSBzdHJpbmdzOiBNZnI9MSwgUHJvZHVjdD0yLAo+PiBTZXJpYWxOdW1iZXI9
Mwo+PiBbICAgNzQuNjIzNzkzXSB1c2IgMS0xLjM6IFByb2R1Y3Q6IERFTk9OIERKIE1DNzAwMAo+
PiBbICAgNzQuNjIzNzk2XSB1c2IgMS0xLjM6IE1hbnVmYWN0dXJlcjogREVOT04gREoKPj4gWyAg
IDc0LjYyMzc5OF0gdXNiIDEtMS4zOiBTZXJpYWxOdW1iZXI6IDIwMTYwMwo+PiBbICAgNzQuNjI1
MTM0XSB1c2IgMS0xLjM6IGNsb2NrIHNvdXJjZSA2NSBpcyBub3QgdmFsaWQsIGNhbm5vdCB1c2UK
Pj4KPj4gInx8fGNsb2NrIHNvdXJjZSA2NSBpcyBub3QgdmFsaWQsIGNhbm5vdCB1c2UiIGlzIHJl
cGVhdGVkCj4+IHVuY291bnRhYmxlCj4+IHRpbWVzIHRoZW4KPj4KPiBQbGVhc2UgdHJ5IHRvIGFk
ZCBkZWxheSBhZnRlciBlYWNoIGNsYXNzIGNvbnRyb2wgcmVxdWVzdCBpbgo+IHNuZF91c2JfY3Rs
X21zZ19xdWlyaygpOgo+Cj4gICAgICBpZiAoY2hpcC0+dXNiX2lkID09IFVTQl9JRCgweDE1ZTQs
IDB4ODAwNCkgJiYKPiAgICAgICAgICAocmVxdWVzdHR5cGUgJiBVU0JfVFlQRV9NQVNLKSA9PSBV
U0JfVFlQRV9DTEFTUykKPiAgICAgICAgICBtc2xlZXAoMjApOwo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpBbHNhLWRldmVsIG1haWxpbmcgbGlzdApB
bHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcKaHR0cHM6Ly9tYWlsbWFuLmFsc2EtcHJvamVjdC5v
cmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
