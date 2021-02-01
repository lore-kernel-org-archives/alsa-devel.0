Return-Path: <SRS0=YhdC=HD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8740FC433E6
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 11:44:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06EED64E95
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Feb 2021 11:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06EED64E95
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72E2F174A;
	Mon,  1 Feb 2021 12:43:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72E2F174A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612179845;
	bh=A7vlBzlrqSTE8f/WVYSqtS1aIw63TJCvoTj6tk6bHeo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gkWBOetda7gQ2T+o5nLVmMOBa5dzK3FvZhm7GEvbvGurXO7JD95rUgxfh0nGg0lEo
	 dm0uIHrNmThnLOHJpG1co2aCoFt6T9TEw5OLya1+FMfViQidQdtr4d4h3XQazisU+I
	 fBi8CtjsS3FckLwoi3ByESQeDJZo1/CIxJJGgFTE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00F84F80152;
	Mon,  1 Feb 2021 12:43:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C848FF80153; Mon,  1 Feb 2021 12:43:13 +0100 (CET)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B7E21F80151
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 12:43:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B7E21F80151
Received: by mail-oi1-f181.google.com with SMTP id w124so18452151oia.6
 for <alsa-devel@alsa-project.org>; Mon, 01 Feb 2021 03:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uZn7ZnnuCBX/W22GeRC16TXeNlhza967RHxAmFxVnzU=;
 b=EM22+I2JXqdjze/vTIpZhFkT73dsJgYTY4D2XKyeK7bAE6lv2VVOgrr1UEFlUdm0Dq
 KVxQqOE+RSCFqjQgn+SsnHZKYSattckcRh+u13IJaTEbL4jeCCuXuF4wWLkso6JDWRie
 rJA1pmSh68tJ2EE/3sp808AgcDdab6tQh77AwBOgf3cxDFVkPzZu/gWf6x9OoHyfLZGr
 HAR3lamRk9seDbX7bUWhnxGhvP0YvN1RJ/yIXdxzS9vDBBmU9+wcrDODPHzk3KUEoqRS
 4S3dbrLcr7ywJtYAebz4UhZXdIIomo0qL3n5uc4+/71Vm/sWjLsy3GSLpTk8YeJnrxFw
 R1IQ==
X-Gm-Message-State: AOAM530/IYHzgFBHyvlZp0Jw0FBfF7j7XsJycXiMBt0KdaRqgfYd2zy5
 0AZ6SDK29irDvPLf44sVZPWY3eNxyfvVDZhwjpo=
X-Google-Smtp-Source: ABdhPJwQnP3u+qOoXMxYe6YhYqIR6+9UKvF8rIWwtA83rZ95dumube+bnWK+S3cxixTLoNX1L1XuYy6tcwYgDyB6RSY=
X-Received: by 2002:aca:d14:: with SMTP id 20mr11071141oin.157.1612179787831; 
 Mon, 01 Feb 2021 03:43:07 -0800 (PST)
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
In-Reply-To: <CA+GA0_u8NA90GmMSDO-Ejg-C2YEXCn8rnVZpk-_+eXcDm7XRpg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Feb 2021 12:42:53 +0100
Message-ID: <CAJZ5v0hqHihRdad16Djo+R1ezjFHt2YffgDg59TYYKJSSjmA4Q@mail.gmail.com>
Subject: Re: Crash in acpi_ns_validate_handle triggered by soundwire on Linux
 5.10
To: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Erik Kaneda <erik.kaneda@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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

On Fri, Jan 29, 2021 at 9:03 PM Marcin =C5=9Alusarz <marcin.slusarz@gmail.c=
om> wrote:
>
> pt., 29 sty 2021 o 19:59 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> n=
apisa=C5=82(a):
> >
> > czw., 28 sty 2021 o 15:32 Marcin =C5=9Alusarz <marcin.slusarz@gmail.com=
> napisa=C5=82(a):
> > >
> > > czw., 28 sty 2021 o 13:39 Rafael J. Wysocki <rafael@kernel.org> napis=
a=C5=82(a):
> > > > The only explanation for that I can think about (and which does not
> > > > involve supernatural intervention so to speak) is a stack corruptio=
n
> > > > occurring between these two calls in sdw_intel_acpi_cb().  IOW,
> > > > something scribbles on the handle in the meantime, but ATM I have n=
o
> > > > idea what that can be.
> > >
> > > I tried KASAN but it didn't find anything and kernel actually booted
> > > successfully.
> >
> > I investigated this and it looks like a compiler bug (or something nast=
ier),
> > but I can't find where exactly registers get corrupted because if I add=
 printks
> > the corruption seems on the printk side, but if I don't add them it see=
ms
> > the value gets corrupted earlier.
> (...)
> > I'm using gcc 10.2.1 from Debian testing.
>
> Someone on IRC, after hearing only that "gcc miscompiles the kernel",
> suggested disabling CONFIG_STACKPROTECTOR_STRONG.
> It helped indeed and it matches my observations, so it's quite likely it
> is the culprit.
>
> What do we do now?

Figure out why the stack protection kicks in, I suppose.

The target object is not on the stack, so if the pointer to it is
valid (we need to verify somehow that it is indeed), dereferencing it
shouldn't cause the stack protection to trigger.
