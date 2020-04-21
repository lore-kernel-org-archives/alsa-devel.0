Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F29C54FC9
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:56:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2AED206E9
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 15:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uj1xWbDt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AED206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DDCF616C3;
	Tue, 21 Apr 2020 17:55:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DDCF616C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587484589;
	bh=BAW0+T6XTjOXMnngIG+zVNvt7I2G3nrMZwRjgWNO/qY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uj1xWbDt1fkSq3nGgRf2F42YxCMiSGEZEkFp2bLRtQj9STFm4HKguhBNMatugF4GG
	 FckLLNxE6f2C4aI9C8/1pT6CLilyEtDCHYBYAi7T96g7Ji593WvSWHp7O8tXFFCHlT
	 NBTb2bfx0k+Dd11Lv0BxqVR4SNPxYrYEvyKl4vMs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6F308F80143;
	Tue, 21 Apr 2020 17:55:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEF40F801EC; Tue, 21 Apr 2020 17:55:37 +0200 (CEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by alsa1.perex.cz (Postfix) with ESMTP id 18092F8012F
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 17:55:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 18092F8012F
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 03LFtMkQ010973;
 Tue, 21 Apr 2020 10:55:22 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 03LFtG0c010964;
 Tue, 21 Apr 2020 10:55:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 21 Apr 2020 10:55:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH 2/5] powerpc: Replace _ALIGN_DOWN() by ALIGN_DOWN()
Message-ID: <20200421155516.GT26902@gate.crashing.org>
References: <a5945463f86c984151962a475a3ee56a2893e85d.1587407777.git.christophe.leroy@c-s.fr>
 <3911a86d6b5bfa7ad88cd7c82416fbe6bb47e793.1587407777.git.christophe.leroy@c-s.fr>
 <CACPK8XfqnqgkXcBzp=nqd=AJX1MK05eTNiyOdaEuRu3_6RsXSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XfqnqgkXcBzp=nqd=AJX1MK05eTNiyOdaEuRu3_6RsXSQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linux-fbdev@vger.kernel.org,
 kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, Paul Mackerras <paulus@samba.org>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
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

Hi!

On Tue, Apr 21, 2020 at 01:04:05AM +0000, Joel Stanley wrote:
> On Mon, 20 Apr 2020 at 18:38, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
> > _ALIGN_DOWN() is specific to powerpc
> > ALIGN_DOWN() is generic and does the same
> >
> > Replace _ALIGN_DOWN() by ALIGN_DOWN()
> 
> This one is a bit less obvious. It becomes (leaving the typeof's alone
> for clarity):
> 
> -((addr)&(~((typeof(addr))(size)-1)))
> +((((addr) - ((size) - 1)) + ((typeof(addr))(size) - 1)) &
> ~((typeof(addr))(size)-1))
> 
> Which I assume the compiler will sort out?

[ This is line-wrapped, something in your mailer?  Took me a bit to figure
  out the - and + are diff -u things :-) ]

In the common case where size is a constant integer power of two, the
compiler will have no problem with this.  But why do so complicated?

Why are the casts there, btw?


Segher
