From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA async callback re-enter and DEADLOCK.
Date: Tue, 27 Mar 2012 14:40:47 +0200
Message-ID: <4F71B54F.4080507@ladisch.de>
References: <CACwG4MQMn_KjiP9eUbiqJEMW5eF40+aOvcGM=fhSs8SPPgaE=A@mail.gmail.com>
	<4F7181D7.5040203@ladisch.de>
	<CACwG4MRqtvN31XsvzxOCq3c7nab8NxJKVguYojOzkeP9THq8XQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id EC31C24624
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 14:37:25 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7FBBC216A7
	for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2012 08:37:25 -0400 (EDT)
In-Reply-To: <CACwG4MRqtvN31XsvzxOCq3c7nab8NxJKVguYojOzkeP9THq8XQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?0J/QsNCy0LXQuyDQmtC+0LvQvtC00LjQvQ==?= <pavelkolodin@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

0J/QsNCy0LXQuyDQmtC+0LvQvtC00LjQvSB3cm90ZToKPiBTbywgaW4gbXVsdGktdGhyZWFkZWQg
YXBwbGljdGlvbiwgdGhlIGJldHRlciBzb2x1dGlvbiB3b3VsZCBiZSB0byBzdGFydCBzZXBhcmF0
ZSB0aHJlYWQgdGhhdCB3b3VsZCB0YWxrIHdpdGggQUxTQSBvbmx5PwoKWWVzLiAgSWYgeW91IGFs
cmVhZHkgaGF2ZSBhIHBvbGwoKS1iYXNlZCBldmVudCBsb29wIGluIHNvbWUgdGhyZWFkLAppdCBt
aWdodCBtYWtlIHNlbnNlIHRvIHB1dCB0aGUgQUxTQSBjb2RlIHRoZXJlLCBidXQgdGhpcyBkZXBl
bmRzIG9uCmhvdyB0aGVzZSB0aHJlYWRzIGFmZmVjdCBlYWNoIG90aGVyLgoKClJlZ2FyZHMsCkNs
ZW1lbnMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQWxz
YS1kZXZlbCBtYWlsaW5nIGxpc3QKQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnCmh0dHA6Ly9t
YWlsbWFuLmFsc2EtcHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbHNhLWRldmVsCg==
