Return-Path: <SRS0=dVJd=E6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060AEC83010
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 17:08:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A065208C3
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Nov 2020 17:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qVX7i6we"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A065208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57023175C;
	Tue, 24 Nov 2020 18:07:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57023175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1606237695;
	bh=oT95B7BGEwR7AVCh3LeFxy+jH5s0J9PCxmvy+2xqKfQ=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qVX7i6wezvN5gGTFU3Hh2TdRLQThKQFSeFkzfuZeRkIZo9iQqYkLAk5PwTYhXeOua
	 KFZICSmmgwhkPcWiCRw+LfcosSutgvQMR7Ntr/bh8+AH2gTdWgDHPcFSRD0I6QC3SH
	 9mD2lL/Mt91RjLcBRhqL4ZNn5eS1CquZFJq+1Ntg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CFF06F80570;
	Tue, 24 Nov 2020 17:58:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC6E0F80165; Sun, 22 Nov 2020 19:23:43 +0100 (CET)
Received: from smtprelay.hostedemail.com (smtprelay0055.hostedemail.com
 [216.40.44.55])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B341F80113
 for <alsa-devel@alsa-project.org>; Sun, 22 Nov 2020 19:23:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B341F80113
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay05.hostedemail.com (Postfix) with ESMTP id 524371802912B;
 Sun, 22 Nov 2020 18:23:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: match16_380b6892735e
X-Filterd-Recvd-Size: 3051
Received: from XPS-9350.home (unknown [47.151.128.180])
 (Authenticated sender: joe@perches.com)
 by omf14.hostedemail.com (Postfix) with ESMTPA;
 Sun, 22 Nov 2020 18:23:29 +0000 (UTC)
Message-ID: <dec07021e7fc11a02b14c98b713ae2c6e2a4ca00.camel@perches.com>
Subject: Re: [RFC] MAINTAINERS tag for cleanup robot
From: Joe Perches <joe@perches.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Tom Rix
 <trix@redhat.com>, Matthew Wilcox <willy@infradead.org>
Date: Sun, 22 Nov 2020 10:23:28 -0800
In-Reply-To: <751803306cd957d0e7ef6a4fc3dbf12ebceaba92.camel@HansenPartnership.com>
References: <20201121165058.1644182-1-trix@redhat.com>
 <20201122032304.GE4327@casper.infradead.org>
 <ddb08a27-3ca1-fb2e-d51f-4b471f1a56a3@redhat.com>
 <20201122145635.GG4327@casper.infradead.org>
 <0819ce06-c462-d4df-d3d9-14931dc5aefc@redhat.com>
 <751803306cd957d0e7ef6a4fc3dbf12ebceaba92.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 24 Nov 2020 17:58:08 +0100
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-scsi@vger.kernel.org, clang-built-linux@googlegroups.com,
 amd-gfx@lists.freedesktop.org, cluster-devel@redhat.com,
 linux-acpi@vger.kernel.org, tboot-devel@lists.sourceforge.net,
 coreteam@netfilter.org, xen-devel@lists.xenproject.org,
 MPT-FusionLinux.pdl@broadcom.com, linux-media@vger.kernel.org,
 alsa-devel@alsa-project.org, intel-gfx@lists.freedesktop.org,
 ecryptfs@vger.kernel.org, linux-omap@vger.kernel.org, devel@acpica.org,
 linux-nfs@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-crypto@vger.kernel.org, patches@opensource.cirrus.com,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
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

On Sun, 2020-11-22 at 08:49 -0800, James Bottomley wrote:
> We can enforce sysfs_emit going forwards
> using tools like checkpatch

It's not really possible for checkpatch to find or warn about
sysfs uses of sprintf. checkpatch is really just a trivial
line-by-line parser and it has no concept of code intent.

It just can't warn on every use of the sprintf family.
There are just too many perfectly valid uses.

> but there's no benefit and a lot of harm to
> be done by trying to churn the entire tree

Single uses of sprintf for sysfs is not really any problem.

But likely there are still several possible overrun sprintf/snprintf
paths in sysfs.  Some of them are very obscure and unlikely to be
found by a robot as the logic for sysfs buf uses can be fairly twisty.

But provably correct conversions IMO _should_ be done and IMO churn
considerations should generally have less importance.



