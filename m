Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68379CD6E4C
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Jun 2026 07:34:49 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D7312601B0;
	Mon,  1 Jun 2026 09:34:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D7312601B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780299286;
	bh=bsvnCUzHmtPAQvzXZfKyuJapqwi6rj1thyCpPf1C5n4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rRzPSy3excC358EP3Aeed9agXnxs+pkDzx5iojjssxSEnINlqpw0T+VDcVIUEUa3D
	 +a11uW6KJaM1MxNYI34DoW09VDA++EyGuB3Xqf+p210S+VCkmLIzXOF1mwRIkW1gAp
	 smb1MdwNc4QQWgpPCwpBAKViCPHR5esFqBOy3oHU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7E058F805F3; Mon,  1 Jun 2026 09:34:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DE7EBF805F2;
	Mon,  1 Jun 2026 09:34:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C49EAF80535; Mon,  1 Jun 2026 09:34:06 +0200 (CEST)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net
 [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B740F800E2
	for <alsa-devel@alsa-project.org>; Mon,  1 Jun 2026 09:34:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B740F800E2
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net",
 Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 78462C17;
	Mon, 01 Jun 2026 09:34:03 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 558986029989; Mon,  1 Jun 2026 09:34:03 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:34:03 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Filippe Duke <fduke@greennet.ua>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"superm1@kernel.org" <superm1@kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [REGRESSION][BISECTED] HDA controller MMIO unreadable on Intel
 5-series PCH (Ibex Peak) since v6.16
Message-ID: <ah016_TukXkcqnyQ@wunner.de>
References: <5e54aea4a97f1cbbe866d9d8f3f25f9f2958e1c9.camel@greennet.ua>
 <cf379972-6b2d-42e5-9660-32d031516862@kernel.org>
 <e05ab19cf41224661325a8acb5f10d31a1d8fbf0.camel@greennet.ua>
 <ahyerEqlBdIbQN9u@wunner.de>
 <60c710e22fc987a3b444e5b687a9a64bb454f0f8.camel@greennet.ua>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60c710e22fc987a3b444e5b687a9a64bb454f0f8.camel@greennet.ua>
Message-ID-Hash: FY7CB7F2GKJQRDGRD5V5NYDDDAWQVEUS
X-Message-ID-Hash: FY7CB7F2GKJQRDGRD5V5NYDDDAWQVEUS
X-MailFrom: lukas@wunner.de
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FY7CB7F2GKJQRDGRD5V5NYDDDAWQVEUS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sun, May 31, 2026 at 09:22:52PM +0000, Filippe Duke wrote:
> A working LTS kernel version tells completely different story.

Right:

 00:1b.0 Audio device: Intel Corporation 5 Series/3400 Series Chipset
[...]
-       Interrupts: pin B disabled, MSI(X) routed to IRQ 34
+       Interrupts: pin B disabled, MSI(X) routed to IRQ 28
[...]
-               Address: 0000000000000000  Data: 0000
+               Address: 00000000fee00000  Data: 0022

That's the only difference.  Seems plausible that it causes
communication failure with the HDA controller.

The offending commit causes current_state to be PCI_D0 instead of
PCI_UNKNOWN at boot time enumeration and this results in different
code paths being taken.

I note that current_state is queried in three places in
drivers/pci/msi/msi.c, so I'd start by instrumenting them with
printk()'s to see why the behavior is different.

E.g. __pci_write_msi_msg() bails out if current_state is not PCI_D0.
Perhaps it used to do that on a working kernel and now it doesn't.

Thanks,

Lukas
