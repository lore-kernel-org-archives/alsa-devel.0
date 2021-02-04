Return-Path: <SRS0=grW5=HG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D97C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 12:50:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8F264F58
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Feb 2021 12:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8F264F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1665816DF;
	Thu,  4 Feb 2021 13:49:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1665816DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612443022;
	bh=30jGrZYa9MezEYuWeMxIRcmp7CSRP1ppA+0VtgBMJWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Iul7sekLu5gCAnZtxIxbixXaqge8b+Ff9gXQv2JNG+Pa3v0yVLSZ7wb811Vr9a05L
	 tCHt3LrCADPCh2XaAjm9sJWLDmompMKr7Gc7ieSQfa7BXBFTtON1fTu0FCreBld0Sv
	 phC+bTBMJxL6HJMAyrLYEA+nvI2nBKpxNTl5wsvA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9907EF80155;
	Thu,  4 Feb 2021 13:49:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 928BEF80154; Thu,  4 Feb 2021 13:49:29 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 111ADF80154
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2021 13:49:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 111ADF80154
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="leiudJNw"
Received: by mail-wm1-x334.google.com with SMTP id u14so2880676wmq.4
 for <alsa-devel@alsa-project.org>; Thu, 04 Feb 2021 04:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fEUlv+xghuMoX85SLZ/8Eet91YOqowydbDYODhOPyBg=;
 b=leiudJNw729oJ/3GOpEWm5v8k2wpSvhpcQuu1RZopYgJh/IULWpJQ9qKFx7gVlBSHx
 W9tn5uNRm5AxIW98Usq4UGFPGeefKL8OXVA0toqK5JL5gBA1/XH1mRZ8e44H1e2bmu2U
 BIfcjZaolr2kqFkN0wHGoz+d+4qncSpr2syGcGDGLUeGMXF1CPpoCxbC5KTVyOZBp1Ub
 8CdePw1fMP7eSajdwQ7558rXi2R8jEfMCp+ITyg0TKbqXX7VgGQrq/JzhhhIJ0k84fAc
 WBHXMKL94wrZWeZa0GMGkeiVkynb3pLC/6axKXu0Z8ZiwwleZLBRtl2TExHLURBFDEg+
 M4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fEUlv+xghuMoX85SLZ/8Eet91YOqowydbDYODhOPyBg=;
 b=dmYzToAf6uI7VXNW0+op4fSlMnYGNFysFSUI1Q7Fm4KfB4L91Hb/vVgmQJOx84JcQK
 S/zeNZ770jCRY1S6plw4GPfUomHweTBOzBTX9KNDLHdoibVDv49k+Lm2Zj/hXMQWdte0
 2aO6aI4tJ/4eT2CycJW21nrrhJFS1DAVuUZai+SPeZqdIpcQ3/ouULwXLZFBhtHcreLb
 E0w1hi7yoZYAVMj9Ghvu/8E5DdHlWRmC8Jq1/49dtEEZQ6pQpL0XzuVHCSvOGI389l5h
 nepZJ7pmdFnXa1aJ5AAjPCqUb7VjrBYXZwWRXzJ/UqSYzvpRJPkTi6kS+wOJGgIXd22s
 NnRg==
X-Gm-Message-State: AOAM531fy75umWgT258wf6MXlhhtWK2a86EWY9uYCt/889eqN3tjesPs
 i2xJUve6Z0S6ZXXi76+B4HzoIkUwo5ZhFF1viEc=
X-Google-Smtp-Source: ABdhPJxyVqmUGkpHtUNgbE1wuFIvJVT/WDButLa0nCuI2mCCu1otJP+HKlXCVTIBWc0HS7CtcmuaZ9gxWcaYLHXS5iM=
X-Received: by 2002:a05:600c:35ce:: with SMTP id
 r14mr7434530wmq.136.1612442961064; 
 Thu, 04 Feb 2021 04:49:21 -0800 (PST)
MIME-Version: 1.0
References: <CA+GA0_sPC3rp5K4qwZm-u+W1C=+2Y2p-dbF4DMdHkKaTpeKKkg@mail.gmail.com>
 <CAJZ5v0iapmc8ywuySwexwTagKr89Hj7TPXkAvd_HXMhdLoyyQQ@mail.gmail.com>
 <1f0f7273-597e-cdf0-87d1-908e56c13133@linux.intel.com>
 <CA+GA0_v3JUWS3G3=R4XuQ=OW91cpwiBP1Rp=uzYOF8c9TUJ46w@mail.gmail.com>
 <CA+GA0_sCdowanpZmg==c+xVqqNxG5whLGsKHaCfSmpERBhqMzA@mail.gmail.com>
 <1dc2639a-ecbc-c554-eaf6-930256dcda96@linux.intel.com>
 <CA+GA0_sZm2pqOfA3LsNQowb930QS_g5CiCCGthzsS=vAjB9Rjg@mail.gmail.com>
 <CAJZ5v0h+Kwn5u293QO+H2rfGx-ZMBr18tMCLB7jHKHWWRaovOw@mail.gmail.com>
 <CAJZ5v0h8abkdrdN97RHouzxynPBFXBoAuMSb7Zy56+-sTXkPKQ@mail.gmail.com>
 <CA+GA0_vYdxFj_SPWgdkufo04VaOuWqcNTSck6gvnMfN07ZdO_Q@mail.gmail.com>
 <CA+GA0_vKyJZSQZ9bA6_BSDeGfRZ_nz86gj2aVHaOoy1h57CMzA@mail.gmail.com>
 <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
 <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
 <CA+GA0_s7atD4O_DP0NXwVUVvdia2NWwSEfW2Mcw-UoJ9effPvg@mail.gmail.com>
 <CA+GA0_sZQXACjuzYYvrJq-vF-mmjaq82SJ=kifqo4Utv45s5Yg@mail.gmail.com>
In-Reply-To: <CA+GA0_sZQXACjuzYYvrJq-vF-mmjaq82SJ=kifqo4Utv45s5Yg@mail.gmail.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Thu, 4 Feb 2021 13:48:54 +0100
Message-ID: <CA+GA0_vSA51NbyTDtW-2A4aCCp+xXN_BtJfPFAJesRYM0eo9WQ@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To: "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Erik Kaneda <erik.kaneda@intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Len Brown <lenb@kernel.org>
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

czw., 4 lut 2021 o 13:11 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> nap=
isa=C5=82(a):
>
> pon., 1 lut 2021 o 13:16 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> n=
apisa=C5=82(a):
> >
> > pon., 1 lut 2021 o 12:43 Rafael J. Wysocki <rafael@kernel.org> napisa=
=C5=82(a):
> > >
> > > On Fri, Jan 29, 2021 at 9:03 PM Marcin =C5=9Alusarz <marcin.slusarz@g=
mail.com> wrote:
> > > >
> > > > pt., 29 sty 2021 o 19:59 Marcin =C5=9Alusarz <marcin.slusarz@gmail.=
com> napisa=C5=82(a):
> > > > >
> > > > > czw., 28 sty 2021 o 15:32 Marcin =C5=9Alusarz <marcin.slusarz@gma=
il.com> napisa=C5=82(a):
> > > > > >
> > > > > > czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org>=
 napisa=C5=82(a):
> > > > > > > The only explanation for that I can think about (and which do=
es not
> > > > > > > involve supernatural intervention so to speak) is a stack cor=
ruption
> > > > > > > occurring between these two calls in sdw_intel_acpi_cb().  IO=
W,
> > > > > > > something scribbles on the handle in the meantime, but ATM I =
have no
> > > > > > > idea what that can be.
> > > > > >
> > > > > > I tried KASAN but it didn't find anything and kernel actually b=
ooted
> > > > > > successfully.
> > > > >
> > > > > I investigated this and it looks like a compiler bug (or somethin=
g nastier),
> > > > > but I can't find where exactly registers get corrupted because if=
 I add printks
> > > > > the corruption seems on the printk side, but if I don't add them =
it seems
> > > > > the value gets corrupted earlier.
> > > > (...)
> > > > > I'm using gcc 10.2.1 from Debian testing.
> > > >
> > > > Someone on IRC, after hearing only that "gcc miscompiles the kernel=
",
> > > > suggested disabling CONFIG_STACKPROTECTOR_STRONG.
> > > > It helped indeed and it matches my observations, so it's quite like=
ly it
> > > > is the culprit.
> > > >
> > > > What do we do now?
> > >
> > > Figure out why the stack protection kicks in, I suppose.
> > >
> > > The target object is not on the stack, so if the pointer to it is
> > > valid (we need to verify somehow that it is indeed), dereferencing it
> > > shouldn't cause the stack protection to trigger.
> >
> > Well, the problem is not that stack protector finds something, but
> > the feature itself corrupts some registers.
>
> I retract this statement.
>
> Originally I based it on this piece of code:
>    0xffffffff815781f0 <+35>:    mov    %r12,%rdx
>    0xffffffff815781f3 <+38>:    mov    $0xffffffff81eca4c0,%rsi
>    0xffffffff815781fa <+45>:    mov    $0xffffffff82146d46,%rdi
>    0xffffffff81578201 <+52>:    call   0xffffffff818909f1 <printk>
>    0xffffffff81578206 <+57>:    cmpb   $0xf,0x8(%r12)
> where crash is on the last line and I supposedly could see the message
> printed by printk with the correct value of %r12.
> However, after attaching kgdb+kgdboe (it's so much pain...) to the kernel
> I discovered that someting corrupts memory so much that the formatting
> string becomes "", which means that I don't actually see the output of pr=
intk.

Oh crap, I can't reproduce it anymore. I might have tried this before
I disabled KALSR, which would explain why I've seen "" as a formatting
string. (because 0xffffffff82146d46 would not be the real address of it)
