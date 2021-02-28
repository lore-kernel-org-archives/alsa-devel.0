Return-Path: <SRS0=WtzT=H7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E62C433DB
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:49:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8F064DF1
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Mar 2021 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8F064DF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6DBC716D9;
	Mon,  1 Mar 2021 14:48:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6DBC716D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614606565;
	bh=CrBTcSesD3Y6tqQu8NDc7SrI20tjqQmPleCrH/tYecM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bEjNwVbnoQ1bfpdREI5Id7JCB+tFf4sDuDATLQ+wxx/3MkKAmGsH11RCWzAacgf37
	 pQXXZ9zB0dNENyw3uRHPY/3+51J208E6B8DFt6w9GyJIpvAAFeKGAMYcOdFdrIaUwa
	 LsjEm6a/+5taVhrSPiGl9GfhCGInEcCmVv7MdgI0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFF44F8053C;
	Mon,  1 Mar 2021 14:43:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4C35F8025B; Sun, 28 Feb 2021 08:08:46 +0100 (CET)
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com
 [210.131.2.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0EA7F800E0
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2021 08:08:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0EA7F800E0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com
 header.b="h4d8ogtK"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 11S785qX024046
 for <alsa-devel@alsa-project.org>; Sun, 28 Feb 2021 16:08:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 11S785qX024046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1614496086;
 bh=ldg+O7sE55to+alrJE10yp3zvi7BbH+3v1wNoAJS4q4=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=h4d8ogtKbASZlioSJs26+mk3ZZ8P/kcBPHikHcRD8o/S8bocxJ8sBKElt7O6aPcmn
 jHcH+K0AOTybhgwquGoefUOFUYS6LIWVrUfxaHE2WwmYk4/l3jtrbttUa4K4Lz31Le
 jlNtDmF3aPdJi5ad5wJRKz3yptrJSa5mpx7GojtTnCb7gqRlpi1YJI7lLIjDVrJ9r0
 yWOz2HdxJTTSHjtTlj9JyCCgu5pQdvx0y/B+IOszWDZMmvZlS/oTNRTEs5Z8SnaMZF
 dyJMMhZfiYE05///jQj6lv9CXCUF+iTzHCYC4UA5r8e2GexUr/3t41VedTd2XBDGb+
 voBwzQotefRAA==
X-Nifty-SrcIP: [209.85.214.173]
Received: by mail-pl1-f173.google.com with SMTP id b8so4829465plh.0
 for <alsa-devel@alsa-project.org>; Sat, 27 Feb 2021 23:08:06 -0800 (PST)
X-Gm-Message-State: AOAM533Bdtz4tLwnnFX7Lbpdshq94wX1p9SMF44W84Mc/d+cPrAfavxu
 Xv0PthzUo0ip6aD2s+4hyPBevDllG9kXgolzvpU=
X-Google-Smtp-Source: ABdhPJxnVdF9Cvtz3QuQ9Z55mLc0nR7ZPvYqUNLa1UMZMC9CH1qH9+VqVFfmtGZF/+QiECQmAdbbtJL43yO3rdbPYM4=
X-Received: by 2002:a17:90a:dc08:: with SMTP id
 i8mr10797186pjv.153.1614496085241; 
 Sat, 27 Feb 2021 23:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20210227183910.221873-1-masahiroy@kernel.org>
 <CAK7LNASL_X43_nMTz1CZQB+jiLCRAJbh-wQdc23QV0pWceL_Lw@mail.gmail.com>
 <20210228064936.zixrhxlthyy6fmid@24bbad8f3778>
 <20210228065254.GA30798@24bbad8f3778>
In-Reply-To: <20210228065254.GA30798@24bbad8f3778>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 28 Feb 2021 16:07:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmHU48mg4uh2H0VZDuhg6-Fwz=uF0rKSHuCJK-soZbUQ@mail.gmail.com>
Message-ID: <CAK7LNATmHU48mg4uh2H0VZDuhg6-Fwz=uF0rKSHuCJK-soZbUQ@mail.gmail.com>
Subject: Re: [PATCH RFC] x86: remove toolchain check for X32 ABI capability
To: Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 01 Mar 2021 14:43:22 +0100
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Peter Zijlstra <peterz@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>,
 Dmitry Safonov <0x7f454c46@gmail.com>,
 Dominik Brodowski <linux@dominikbrodowski.net>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Sasha Levin <sashal@kernel.org>, Fangrui Song <maskray@google.com>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 X86 ML <x86@kernel.org>, Jethro Beekman <jethro@fortanix.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 "H . J . Lu" <hjl.tools@gmail.com>, Kees Cook <keescook@chromium.org>,
 Arnd Bergmann <arnd@arndb.de>, Brian Gerst <brgerst@gmail.com>,
 "Chang S. Bae" <chang.seok.bae@intel.com>, Chao Yu <chao@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Sean Christopherson <seanjc@google.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Nick Desaulniers <ndesaulniers@google.com>,
 Takashi Iwai <tiwai@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-xfs <linux-xfs@vger.kernel.org>,
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
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

On Sun, Feb 28, 2021 at 3:53 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Sat, Feb 27, 2021 at 11:49:36PM -0700, Nathan Chancellor wrote:
> > On Sun, Feb 28, 2021 at 12:15:16PM +0900, Masahiro Yamada wrote:
> > > On Sun, Feb 28, 2021 at 3:41 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > This commit reverts 0bf6276392e9 ("x32: Warn and disable rather than
> > > > error if binutils too old").
> > > >
> > > > The help text in arch/x86/Kconfig says enabling the X32 ABI support
> > > > needs binutils 2.22 or later. This is met because the minimal binutils
> > > > version is 2.23 according to Documentation/process/changes.rst.
> > > >
> > > > I would not say I am not familiar with toolchain configuration, but
> > >
> > > I mean:
> > > I would not say I am familiar ...
> > > That is why I added RFC.
> > >
> > > I appreciate comments from people who are familiar
> > > with toolchains (binutils, llvm).
> > >
> > > If this change is not safe,
> > > we can move this check to Kconfig at least.
> >
> > Hi Masahiro,
> >
> > As Fangrui pointed out, there are two outstanding issues with x32 with
> > LLVM=1, both seemingly related to LLVM=1.
>                                     ^ llvm-objcopy
>
> Sigh, note to self, don't write emails while tired...
>

Fangrui, Nathan, thanks for your comments.

OK, then we still need to carry this toolchain check.


-- 
Best Regards
Masahiro Yamada
