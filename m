Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF4DC4450A
	for <alsa-devel@archiver.kernel.org>; Sun, 19 Jul 2026 00:14:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5F16B60202;
	Sun, 19 Jul 2026 02:14:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5F16B60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784420057;
	bh=GzIh3uO+H+NffvrlF9x94QVETDDkXtbonH+FfMWbw/E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fLmdal/avNiB7MfzwYJrWwKZNN7qezVMvKmuq7ZJAlhszoGLKBbxSskIPSGH3NP33
	 QJh9KWRPQ/nhgAMAiopiHquWvj76rr9ppYJ0WiSKfiK5cV5LVToXhbN0QMsIwYlo/a
	 33TMHSMjkAZWp1MqubIYmDid1mwN1XVU6vl32RoA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 653A8F8057A; Sun, 19 Jul 2026 02:13:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 353C9F805F7;
	Sun, 19 Jul 2026 02:13:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15223F80551; Sun, 19 Jul 2026 02:13:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1784420016;
	b=ik4ivc7/QCgnV7ZzOHqLgySihQAZWYEJf6eI2U/nRzEDo4H29nIUv4TvVQx80IVVWRL1
	 5IVlPcD6gwHbUml/98ZQb9bc2wNxwx388y6l2LKgFWKdFvOFI2QTYnSc8qXerEEgW6GmZ
	 szdeq52ats2VmzJk4cR51SBAh9xkCYJjDSJdtGmDKr4mzxuHsjcVhlMXBp26ZOzSuIz62
	 8ZSSYsEo4b5OVXhUxOkSjscVXnaDhV/oCAyoJX0YJeuSbkxDf6LrBBWjbHVxqZ0J/KTNI
	 z7f/6IDDBHDd2aksEcUDuIrznejq/jLAYqblELS886EyYhouhJzBSBwY2xeqj8PHCfA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784420016;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=GzIh3uO+H+NffvrlF9x94QVETDDkXtbonH+FfMWbw/E=;
	b=C9jLYZzW//4Nt4IxUHz75KSKXSda5OEaXlNnf6OxiJxB/fc3vOckyP435Lb3z3zJRSzO
	 I8rJ8JeSbf/Dn2SPmxz468tgBoyR7eQhy3qX4Uwr4X+e1+ek5LXFe8tKg654gSmSD2SCO
	 bvkoOiabE3FciNqEQHvJOyh9YX096S4see4EPV21U9aDmH64ZyZ9qGH4Vpbv9tU0p58PF
	 T+pgfbLTDg7lcbYoeVJLmkVbAKEzHKcLh+2qByy+2Xdr7mGB74FTLQM/Rqa0m7uTRx5fY
	 y5wXks+E49h2jcQNMz6So5vHA7n0Mq1e/feTFkFJ7rXeYoF2ApXpoT5tCNU1mNh/wIQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 952A9F80246
	for <alsa-devel@alsa-project.org>; Sun, 19 Jul 2026 02:13:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 952A9F80246
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c3888cc3fc2400-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/814@alsa-project.org>
Subject: ucm2: MediaTek: Add SOF UCM for mt8186 mt6366 rt1019 rt5682s
Date: Sun, 19 Jul 2026 02:13:37 +0200 (CEST)
Message-ID-Hash: LNLULWYOH6KCSTWN6XPYGOMTEJ2ISPPX
X-Message-ID-Hash: LNLULWYOH6KCSTWN6XPYGOMTEJ2ISPPX
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LNLULWYOH6KCSTWN6XPYGOMTEJ2ISPPX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

YWxzYS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYgcHVsbCByZXF1ZXN0ICM4MTQgd2FzIGVkaXRlZCBm
cm9tIGRhbmdvd3J0OgoKQWRkIGEgVUNNIHByb2ZpbGUgZm9yIHRoZSBTT0YgdmFyaWFudCBvZiB0
aGUgTWVkaWFUZWsgTVQ4MTg2IChLb21wYW5pbyA1MjApCnNvdW5kIGNhcmQgYHNvZi1tdDgxODZf
cnQxMDE5X3J0NTY4MnNgLCBhcyBmb3VuZCBvbiBDb3Jzb2xhLWZhbWlseSBDaHJvbWVib29rcwoo
ZS5nLiBnb29nbGUsc3RlZWxpeCkuCgpUaGUgY2FyZCBleHBvc2VzOgotIFJUMTAxOSBhbXBsaWZp
ZXIgLT4gc3BlYWtlciAoU09GX0RMMiAtPiBJMlMzKQotIFJUNTY4MlMgY29kZWMgLT4gaGVhZHNl
dCBqYWNrOiBoZWFkcGhvbmVzIChTT0ZfREwxIC0+IEkyUzEpIGFuZCBoZWFkc2V0IG1pYwogIChT
T0ZfVUwyIC0+IEkyUzApCi0gTVQ2MzY2IGJ1aWx0LWluIGRpZ2l0YWwgbWljcm9waG9uZSAoU09G
X1VMMSkKClJUNTY4MlMgREFDL0FEQyByb3V0aW5nIGZvbGxvd3MgdGhlIGV4aXN0aW5nIG10ODE5
NSBtdDYzNTktcnQxMDE5LXJ0NTY4Mgpwcm9maWxlIChzYW1lIGNvZGVjKSwgd2l0aCBib2FyZCBz
cGVjaWZpY3M6Ci0gTVQ2MzY2IGludGVybmFsIERNSUMgbmVlZHMgb25lLXdpcmUgbW9kZSAoYE10
NjM2NiBEbWljIE1vZGUgU3dpdGNoYCkKLSBoZWFkc2V0LW1pYyBjYXB0dXJlIChTT0ZfVUwyIC0+
IEkyUzApIG5lZWRzIHRoZSBBRkUKICBgVUwyX0NIMS9DSDIgSTJTMF9DSDEvQ0gyIFN3aXRjaGAg
aW50ZXJjb25uZWN0Ci0gYSBtb2RlcmF0ZSBhbmFsb2cgY2FwdHVyZSBnYWluIGZvciB0aGUgaGVh
ZHNldCBtaWMKClRlc3RlZCBvbiBnb29nbGUsc3RlZWxpeCAoRGViaWFuLCBQaXBlV2lyZSk6IHNw
ZWFrZXIsIGhlYWRwaG9uZXMsIGhlYWRzZXQgbWljCmFuZCBidWlsdC1pbiBtaWMgYWxsIHZhbGlk
YXRlZCBlbmQtdG8tZW5kOyBqYWNrIGRldGVjdGlvbiB3b3Jrcy4KCmBhbHNhLWluZm8uc2hgIG91
dHB1dCAocGVyIENPTlRSSUJVVElORywgZm9yIHRoZSBVQ00gdmFsaWRhdG9yKSB0byBmb2xsb3cg
4oCUIEkKd2lsbCBhdHRhY2ggaXQgc28gdGhlIGNhcmQgY2FuIGJlIGFkZGVkIHRvIHRoZSBgYWxz
YS10ZXN0c2AgdmFsaWRhdG9yIHNldC4gQ0kKbWF5IG5vdCBmdWxseSBlbXVsYXRlIHRoaXMgbmV3
IGNhcmQgdW50aWwgdGhlbi4KClJlcXVlc3QgVVJMICAgOiBodHRwczovL2dpdGh1Yi5jb20vYWxz
YS1wcm9qZWN0L2Fsc2EtdWNtLWNvbmYvcHVsbC84MTQKUGF0Y2ggVVJMICAgICA6IGh0dHBzOi8v
Z2l0aHViLmNvbS9hbHNhLXByb2plY3QvYWxzYS11Y20tY29uZi9wdWxsLzgxNC5wYXRjaApSZXBv
c2l0b3J5IFVSTDogaHR0cHM6Ly9naXRodWIuY29tL2Fsc2EtcHJvamVjdC9hbHNhLXVjbS1jb25m
Cg==
