Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868F6CD98CF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Jun 2026 08:15:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5E41601FC;
	Tue, 16 Jun 2026 10:15:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5E41601FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781597728;
	bh=YyHmtSyL2lsgT0es0Eetl/XKw4nAr3/w77RlgtbYc7I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BbrRQ0sU3pg9+DUyN6f51reRFZ0lPiJD+sPhxpsggk4NYS657vJs7AaG9w6u6RCN2
	 y//YLE0SOlLmvv7njYmsiH5qjFgf54U+JdaBnNqfbdfR/sTF59LWhLVlhfdeaJpYNI
	 O1phYZsTdNap0j0MQWEbPnesxeRHjNEP98tGGNa8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16559F805FF; Tue, 16 Jun 2026 10:14:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7DE3BF805F7;
	Tue, 16 Jun 2026 10:14:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9811F80495; Tue, 16 Jun 2026 10:14:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=188.68.63.102
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781597685;
	b=BSBm6BZyD/E5ZeQJh42kPF/ZtZldmCiWiDwAKekWtdkA8VMrexQPPcStxdf8nAA6FLM+
	 dlCF/zjWxov21cSdUzzhxV1auhN7uV2Bj7mHTjGIzik2hyLTgXMGsM1bwIT64yyC7f9N1
	 i6MzuSzBqtEUw//vCxLDv45n8vJizN+evfMZicZVNs0zm+vjN0Am6oyzg0LyQhYyDQlQJ
	 ZJPPAA3ohLwY/9VgFEBhF2PZj6Fj6p98Qbw+DMfgJ+bcxyPhEm6hsL7JztYxSIYYu6+t2
	 ANmjL5/Cjr95uabv7lA/MevNZeUb9cMvZs7OIsPJ5NNYvmRlqP8BZHlqOiYwylshsVQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781597685;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:From:Subject:To;
	bh=YyHmtSyL2lsgT0es0Eetl/XKw4nAr3/w77RlgtbYc7I=;
	b=nTEBfW/c4hBMSv9x/K45v/fZDVX1TQpNwIHGidei/q6R0kvRKIQ0XZt6FXYH+meOJs9v
	 E/v+3LNm3OGfKLlQXr+5GOgtSWyqUUlhKzkTxpoD9kxuTTDLVIOVDHhYagdFBr1ohZUY+
	 v5Lyl1Nw60dn4OI370lSacZ2Wa6BrINz4Ar5AmPDlAziVEJoYwxMIXPfNsMOHjHu+PdOj
	 WbHVke6AZSBpXN1nZhvlyr5Z4QtLcoDehosQMn5bPx0h/VjCtHJzSF1Cw5lXnnT2eIsnt
	 nrBkSYxjtAWwFj2v1mupbAISWi3hOB/0DUqGZcv6awOVxHk1k46oSzZ9HGSPMSLR9CA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=leemhuis.info header.i=@leemhuis.info header.a=rsa-sha256
 header.s=key2 header.b=EUH3Fxd1;
	arc=none smtp.remote-ip=188.68.63.102
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de
 [188.68.63.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7641F80038
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2026 10:14:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7641F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=leemhuis.info header.i=@leemhuis.info
 header.a=rsa-sha256 header.s=key2 header.b=EUH3Fxd1
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gffsQ3Pk6z6717;
	Tue, 16 Jun 2026 10:14:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1781597658;
	bh=YyHmtSyL2lsgT0es0Eetl/XKw4nAr3/w77RlgtbYc7I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=EUH3Fxd1QMdV3l7mSGAn/da6tuaV6CvxCyQZk0624HBfcV109U/HwFVjwwY8rnFfZ
	 /7OLb3qxuUUxu0oIPL2fVqxtIQkPgwK3IL5QS4AVcARwomvMpWXp8MjrFdfq+4vZ5G
	 of4bYahh/SsNewi+VvzbXCyjSbdgEujezRnBmQxgX3YcCFN6IzSAQfePrQR21dFgkQ
	 5hAxKj4toZGwGmIPVAIXMAKwoAT4ohierbqxJA7gTxCk/cKmi0Qcuc+tkS+ZC2tn5k
	 tAf7Msu4PtX2Iq83fVdk6thOhoojwGjWgxxXB6m59Fb1EgArLe5b0ugfLFGJAufmiG
	 pLJdlwEjT0s0w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gffqr5HFzz4yXG;
	Tue, 16 Jun 2026 10:12:56 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gffqq6nVvz8sZP;
	Tue, 16 Jun 2026 10:12:55 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown
 [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 084036034E;
	Tue, 16 Jun 2026 10:12:54 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f)
 smtp.mailfrom=regressions@leemhuis.info
 smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <ba4a8fa6-1786-4fca-a6e1-c203d6b6bc0c@leemhuis.info>
Date: Tue, 16 Jun 2026 10:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
To: Lukas Wunner <lukas@wunner.de>, "superm1@kernel.org" <superm1@kernel.org>
Cc: Filippe Duke <fduke@greennet.ua>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "tiwai@suse.com" <tiwai@suse.com>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
 <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
 <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>
 <ahyerEqlBdIbQN9u@wunner.de>
 <60c710e22fc987a3b444e5b687a9a64bb454f0f8.camel@greennet.ua>
 <ah016_TukXkcqnyQ@wunner.de>
Content-Language: de-DE, en-US
In-Reply-To: <ah016_TukXkcqnyQ@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178159757535.1706911.6070558377354035513@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: 084036034E
X-NC-CID: ZlEHvU8dYJiledOsQPvvksck1cHFs/89lKalpQIxxw90SeOQ2Dw=
Message-ID-Hash: LSBZSIXOYCEP5SW4UNQLGDWYJ7AQKIY6
X-Message-ID-Hash: LSBZSIXOYCEP5SW4UNQLGDWYJ7AQKIY6
X-MailFrom: regressions@leemhuis.info
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LSBZSIXOYCEP5SW4UNQLGDWYJ7AQKIY6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 6/1/26 09:34, Lukas Wunner wrote:
> On Sun, May 31, 2026 at 09:22:52PM +0000, Filippe Duke wrote:
>> A working LTS kernel version tells completely different story.
> 
> Right:
> 
>  00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
> [...]
> -       Interrupts: pin B disabled, MSI(X) routed to IRQ 34
> +       Interrupts: pin B disabled, MSI(X) routed to IRQ 28
> [...]
> -               Address: 0000000000000000  Data: 0000
> +               Address: 00000000fee00000  Data: 0022
> 
> That's the only difference.  Seems plausible that it causes
> communication failure with the HDA controller.
> 
> The offending commit

Reminder, that was 4d4c10f763d780 ("PCI: Explicitly put devices into D0
when initializing") [v6.16-rc1] from Mario.

This thread stalled and Isee no patch submissions referring to that
change, which makes me wonder:

Is anybody still looking into this, or did this fell through the cracks?

Side note, for completeness: Josh Perry recently reported problems with
a  RTL8168h/8111h NICs due to the same change:
https://lore.kernel.org/netdev/d4aaa5e8-7366-461c-94b1-ccf3631c8bf9@6bit.com/

Ciao, Thorsten

> causes current_state to be PCI_D0 instead of
> PCI_UNKNOWN at boot time enumeration and this results in different
> code paths being taken.
> 
> I note that current_state is queried in three places in
> drivers/pci/msi/msi.c, so I'd start by instrumenting them with
> printk()'s to see why the behavior is different.
> 
> E.g. __pci_write_msi_msg() bails out if current_state is not PCI_D0.
> Perhaps it used to do that on a working kernel and now it doesn't.


