Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFBAC433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Feb 2022 09:31:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25095185F;
	Wed, 16 Feb 2022 10:30:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25095185F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1645003864;
	bh=aWKfLj+OcuQ7ORm2NzKcSLdWPXwTMvCyCCSlhItZJdc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bjBCl3KM3UtN7pbuBZncyHyh+78y6XjrQ04pO21OLYXf3NBLyfiJ3bNCPx8cYY/iP
	 JMOWFUfHErkdHZr75T1+8aM4w371UOPDxoZBu5GPaa0pqF3353Y1JM6GzX0IlM+Od4
	 O4go/SHVIVgPkoPLgJNi5WYP24bEdKRZIOyz6kIM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 958E3F8057A;
	Wed, 16 Feb 2022 10:25:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 554C3F800C0; Tue, 15 Feb 2022 20:13:44 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35D6CF800C0
 for <alsa-devel@alsa-project.org>; Tue, 15 Feb 2022 20:13:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 35D6CF800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Pb9b+lIl"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2784BB81C66;
 Tue, 15 Feb 2022 19:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA149C340EB;
 Tue, 15 Feb 2022 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1644952415;
 bh=aWKfLj+OcuQ7ORm2NzKcSLdWPXwTMvCyCCSlhItZJdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Pb9b+lIl3czsbILZx4JGaHKfxai5nhmkbafSdXIePkm1+42+PtZWRvtnxsIxieHjT
 9ekyHuwvisvcr9fVX07+lClUNa2p0vhktIvKZSAjwuXs2gg0KwuzJxVI1eJwsCEsx9
 QAqj6xuEKLMkpaRxHB9Jbh5UZNn3lhP/U/32rVpI9FJi1e5LJ0Z2HLVW0p7KctTIZB
 uH0ohVDX/Qm561zC5FzYDM+alYJWObfXnSGwWXg348TFcT9AqtFzE3U54RAksJmBj5
 t03G17WjapCI9e95mge26r6O7cubp0cNepLCQdTnroGWEV76h8vqtZwzBmUYMX3S66
 UcWCeciahTo0A==
Date: Tue, 15 Feb 2022 13:21:10 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH][next] treewide: Replace zero-length arrays with
 flexible-array members
Message-ID: <20220215192110.GA883653@embeddedor>
References: <20220215174743.GA878920@embeddedor>
 <202202151016.C0471D6E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202202151016.C0471D6E@keescook>
X-Mailman-Approved-At: Wed, 16 Feb 2022 10:25:43 +0100
Cc: alsa-devel@alsa-project.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, target-devel@vger.kernel.org,
 linux-hardening@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-i3c@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-acpi@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-ext4@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-xtensa@linux-xtensa.org,
 mpi3mr-linuxdrv.pdl@broadcom.com, coresight@lists.linaro.org,
 sparmaintainer@unisys.com, linux-um@lists.infradead.org,
 greybus-dev@lists.linaro.org, linux-rpi-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devel@acpica.org, linux-cifs@vger.kernel.org, netdev@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, GR-QLogic-Storage-Upstream@marvell.com,
 linux-crypto@vger.kernel.org, linux-alpha@vger.kernel.org
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

On Tue, Feb 15, 2022 at 10:17:40AM -0800, Kees Cook wrote:
> On Tue, Feb 15, 2022 at 11:47:43AM -0600, Gustavo A. R. Silva wrote:
> > There is a regular need in the kernel to provide a way to declare
> > having a dynamically sized set of trailing elements in a structure.
> > Kernel code should always use “flexible array members”[1] for these
> > cases. The older style of one-element or zero-length arrays should
> > no longer be used[2].
> > 
> > This code was transformed with the help of Coccinelle:
> > (next-20220214$ spatch --jobs $(getconf _NPROCESSORS_ONLN) --sp-file script.cocci --include-headers --dir . > output.patch)
> > 
> > @@
> > identifier S, member, array;
> > type T1, T2;
> > @@
> > 
> > struct S {
> >   ...
> >   T1 member;
> >   T2 array[
> > - 0
> >   ];
> > };
> 
> These all look trivially correct to me. Only two didn't have the end of
> the struct visible in the patch, and checking those showed them to be
> trailing members as well, so:
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

I'll add this to my -next tree.

Thanks!
--
Gustavo
