Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DBBC88E78
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:46:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00A66601E7;
	Mon, 14 Sep 2026 18:45:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00A66601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789404369;
	bh=eNbKKPpwbHFTAP6yFtMdL3fEbYD1iR+sPz707WI1e1k=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vfYiW9X+pKmYzi2sk8ws8DXj4q5SllLLpuaqMxtAJ/sirfKvJ2yy2zUMHtDRyYt40
	 P1PJKWHq111gPHysd/BADBepzHjHbf5lbwlVkpoFfZp0cjxkKboEvi+yqcJzI+4+vp
	 aYYws6t5ukOCJNitoTEwUJf7bETE+XutG21/hiBo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08502F805F8; Mon, 14 Sep 2026 18:45:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 569B1F80604;
	Mon, 14 Sep 2026 18:45:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E38B2F8049C; Mon, 14 Sep 2026 18:45:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789404323;
	b=PsTHJzhJ2zELhiZ4uuYLDyRNur7SnNPSMzLazKKpHqKJ4q1/umIk0OFjeVNV5MnkXP/W
	 WXdBQj+q9LK7ZvtzqU3E+Kxj9uTgR4+yZITzFEd2FfuRmlJ1LD2caNNEGFZw6LdcVRiq3
	 VTG34jnXQ0JtdcWRDbZ66H3XGTTpv0YtWYMI58L/SvtKG9g/daj5ro/1e3W0oRVi1ldD4
	 +zAvyXBJMlTKO9prmizllqT2KNApOLTzreMHkMJ7qHsaPXOhY0W3arIwYvl6gmftj+fTS
	 7S39jjpQLfIdfxonWNbE3OevAKWAO8waz7DMNP3qgBxbokkIP9qYIAoAN9qMZUCzCGQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789404323;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=eNbKKPpwbHFTAP6yFtMdL3fEbYD1iR+sPz707WI1e1k=;
	b=Zsx3quGkXfwmKxflStZomGt1u0GEZwChCNjtqlNZcq1fpePK3LTSz0KLavBjIf+Br0SP
	 IKE6Fkm4Im0XSt1dslPcjOurDwfrJzCwO7Ff2Ig8D4GHW0E3VtS4hswpAdR8IEBmslheI
	 JAUCWTB3ozGRUHTKAPxPYH32R8qMaLD20JXNKwg+pmyltFxRDjIqvkzc8CBzk4ASsE+P+
	 Vnx7Gqdckkp5qcBHHnt3EJEwl92IwQLy9Hzw7o2UNpKziisOgSKB3U8lkRncnTMNAV31H
	 xh74PAcPSvnZkDpy5+SLjgM/qa8ezQ6EAcfd3WXqOG95G4Js/ut7iv+pv6TDViUIJuw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 862E0F8014B
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2026 18:45:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 862E0F8014B
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d53dc0129eb200-webhooks-bot@alsa-project.org>
In-Reply-To: <18d53dc01290ce00-webhooks-bot@alsa-project.org>
References: <18d53dc01290ce00-webhooks-bot@alsa-project.org>
Subject: Audiocard device is split into multiple PipeWire inputs and reports
 "[ALSA UCM error]"
Date: Mon, 14 Sep 2026 18:45:24 +0200 (CEST)
Message-ID-Hash: 6DCYDPKCGGU2345UT2X3ZTZYIPCUNO5P
X-Message-ID-Hash: 6DCYDPKCGGU2345UT2X3ZTZYIPCUNO5P
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6DCYDPKCGGU2345UT2X3ZTZYIPCUNO5P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgaXNzdWUgIzg1NiB3YXMgb3BlbmVkIGZyb20gYXJ0
b203NjoKCkhlbGxvLApJIGFtIGhhdmluZyBhIHByb2JsZW0gd2l0aCBhIFN0ZWluYmVyZyBVUjQ0
QyBVU0IgYXVkaW8gaW50ZXJmYWNlIG9uIEZlZG9yYSA0NC4KTXkgZ29hbCBpcyB0byB1c2UgdGhl
IFVSNDRDIHdpdGggRkwgU3R1ZGlvIHJ1bm5pbmcgdGhyb3VnaCBXaW5lL0JvdHRsZXMgYW5kIHJl
Y29yZCBmcm9tIG11bHRpcGxlIHBoeXNpY2FsIGlucHV0cyBhdCB0aGUgc2FtZSB0aW1lLiBJIGFt
IHVzaW5nIFBpcGVBU0lPIGFzIHRoZSBBU0lPIGRyaXZlci4gVGhlIFVSNDRDIGl0c2VsZiBzdXBw
b3J0cyA4LWNoYW5uZWwgY2FwdHVyZS4gQUxTQSBjYW4gYWNjZXNzIHRoZSBkZXZpY2UgYXMgYW4g
OC1jaGFubmVsIGRldmljZSwgYnV0IFBpcGVXaXJlIGRvZXMgbm90IGV4cG9zZSBpdCBhcyBvbmUg
OC1jaGFubmVsIGlucHV0IGRldmljZS7CoEluc3RlYWQsIFBpcGVXaXJlIGNyZWF0ZXMgbXVsdGlw
bGUgc2VwYXJhdGUgaW5wdXQgbm9kZXMsIGZvciBleGFtcGxlOgphbHNhX2lucHV0LnVzYi1ZYW1h
aGFfQ29ycG9yYXRpb25fU3RlaW5iZXJnX1VSNDRDLTAwLkhpRmlfX0xpbmUzX19zb3VyY2UKU3Rl
aW5iZXJnIFVSNDRDIFtBTFNBIFVDTSBlcnJvcl0gRnJvbnQgMQoKVGhlcmUgYXJlIGFsc28gYWRk
aXRpb25hbCBub2RlcyBzdWNoIGFzICJGcm9udCAyICYgMyIgYW5kICJGcm9udCAzICYgNCIuCkFs
bCBvZiB0aGVzZSBVUjQ0QyBpbnB1dCBub2RlcyBjb250YWluICJbQUxTQSBVQ00gZXJyb3JdIiBp
biB0aGVpciBkZXNjcmlwdGlvbi4KVGhpcyBjYXVzZXMgYSBwcm9ibGVtIGZvciBQaXBlQVNJTyBh
bmQgRkwgU3R1ZGlvLiBJbnN0ZWFkIG9mIHJlY2VpdmluZyBvbmUgQVNJTyBkZXZpY2Ugd2l0aCBt
dWx0aXBsZSBpbnB1dCBjaGFubmVscywgRkwgU3R1ZGlvIHNlZXMgdGhlIGlucHV0cyBhcyBzZXBh
cmF0ZSBkZXZpY2VzL25vZGVzLiBJIG5lZWQgdGhlIFVSNDRDIHRvIGJlIGF2YWlsYWJsZSB0byB0
aGUgQVNJTyBsYXllciBhcyBvbmUgbXVsdGktY2hhbm5lbCBkZXZpY2Ugc28gdGhhdCBJIGNhbiBy
ZWNvcmQgc2V2ZXJhbCBpbnB1dHMgc2ltdWx0YW5lb3VzbHkuCgpQaXBlQVNJTyBpdHNlbGYgaXMg
aW5zdGFsbGVkIGFuZCB3b3JraW5nIGNvcnJlY3RseS4gRkwgU3R1ZGlvIGNhbiBzZWUgUGlwZUFT
SU8sIGFuZCBJIGhhdmUgYWxyZWFkeSB0cmllZCBpbmNyZWFzaW5nIHRoZSBudW1iZXIgb2YgUGlw
ZUFTSU8gaW5wdXRzIGFuZCBjaGFuZ2luZyBpdHMgaW5wdXQvb3V0cHV0IGNvbmZpZ3VyYXRpb24s
IGJ1dCB0aGlzIGRvZXMgbm90IHNvbHZlIHRoZSBwcm9ibGVtIGJlY2F1c2UgdGhlIFVSNDRDIGlu
cHV0cyBhcmUgYWxyZWFkeSBzcGxpdCBpbnRvIHNlcGFyYXRlIFBpcGVXaXJlIG5vZGVzIGJlZm9y
ZSB0aGV5IHJlYWNoIFBpcGVBU0lPLgpXaGF0IEkgd291bGQgbGlrZSB0byBrbm93IGlzIHdoZXRo
ZXIgdGhlIGN1cnJlbnQgVUNNIGNvbmZpZ3VyYXRpb24gZm9yIHRoZSBTdGVpbmJlcmcgVVI0NEMg
aXMgaW5jb3JyZWN0IG9yIGluY29tcGxldGUsIGFuZCB3aGV0aGVyIHRoZXJlIGlzIGEgcmVjb21t
ZW5kZWQgVUNNIGNvbmZpZ3VyYXRpb24gdGhhdCBleHBvc2VzIHRoZSBVUjQ0QyBjYXB0dXJlIGRl
dmljZSBhcyBhIHNpbmdsZSA4LWNoYW5uZWwgUENNL2RldmljZSBpbnN0ZWFkIG9mIG11bHRpcGxl
IHNlcGFyYXRlIG5vZGVzLgoKVGhhbmsgeW91LgoKSXNzdWUgVVJMICAgICA6IGh0dHBzOi8vZ2l0
aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9pc3N1ZXMvODU2ClJlcG9zaXRvcnkg
VVJMOiBodHRwczovL2dpdGh1Yi5jb20vYWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYK
