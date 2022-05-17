Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3B4C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 17 May 2022 03:08:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CAE8715F2;
	Tue, 17 May 2022 05:07:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CAE8715F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652756910;
	bh=gkLunz/wkIiUfLBMENteZ7GSTBjOBBSNWPW0Wq8mnI4=;
	h=Date:To:From:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=WGwGKVYuWpr4wZKbprH/glGUYZhA3m97+8kYNtA/3KqMilPPRv98gcGjThlGwepbe
	 4+YslObw4XKD8JFoO9BhrAzuukQU+Qw/sOGI/IIKd+oIcUACrPZDu3L+404aLpxNZM
	 CxPGmKNv9Ccw2Yu/6hdOVR84gu0Q42bgaSsR3+vI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53F1FF801D8;
	Tue, 17 May 2022 05:07:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 31E0AF802DB; Tue, 17 May 2022 05:07:38 +0200 (CEST)
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 636F3F800D8
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2022 05:07:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 636F3F800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com
 header.b="IEtmubtN"
Date: Tue, 17 May 2022 03:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail2; t=1652756849;
 bh=gkLunz/wkIiUfLBMENteZ7GSTBjOBBSNWPW0Wq8mnI4=;
 h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
 References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
 Feedback-ID:Message-ID;
 b=IEtmubtNVWqJPZ/e8kZ/4W31pKL0Myd6LsJN3XpH5W//Jl+VlEe86lM7rEyqfMr71
 YMRDIPVqtuUBxEMI5koh88EATVfgPEQ/ygA9Gn66YSSuYpnlE9wLm+rBq1uKFFYJ1O
 LK84gkkj33KLTakW1V5JPHId4KDZQggYX/P26l/lnbi3zgOsCR0wtoU3nA+1PN7Wc/
 VG9LMjD3SY3MjN/02JMeWlKfrOIrqByfR8wlE9cHRSsetYiNFaXe8VLsffbQbLz8BP
 IEUfzNZUST4zSZGzPd4taRk9N+lEpEXunS8jB9rgpxMcu95iwt0CSPOHzMPk33xoaN
 ul2JCHxkvXtsg==
To: Jaroslav Kysela <perex@perex.cz>
From: Peter Wedder <pwedder@protonmail.com>
Subject: Re: UCM2 configuration guide
Message-ID: <xQsDJDUXWHuq4il0ax5D8UaE0mQXEutgvMK72KFbIx0JnNAFd07UonE_LLnyFHn2m5DsqzFWDjxjUEK_CzioRfcd72Maf2J3GuQyYvDHWfs=@protonmail.com>
In-Reply-To: <7d2feff6-e84f-3512-0bcf-f331b5a807a9@perex.cz>
References: <VwoP3j4nu98HV-5itWgDOdFuspSQQHQI_W_SS_WSy25y82ZLj0VupitgOTUv0AmrvI1q7Xx6gJHtm-g68W8QJWgpndDFrd_f-SA8pNp0qp0=@protonmail.com>
 <7d2feff6-e84f-3512-0bcf-f331b5a807a9@perex.cz>
Feedback-ID: 42199824:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Cc: ALSA development <alsa-devel@alsa-project.org>
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
Reply-To: Peter Wedder <pwedder@protonmail.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Sounds good!

I am also open to reworking the guide into a part of ALSA documentation, if=
 that suits you better.

I must confess I don't exactly understand what you mean by splitting channe=
ls "inside app" (what app?), though. Do you mean some kind of tool to avoid=
 having to write configuration by hand? In any case, I will update the guid=
e accordingly if changes are made to the process.

- Peter



------- Original Message -------
On Monday, May 16th, 2022 at 19:31, Jaroslav Kysela <perex@perex.cz> wrote:


>
>
> On 14. 05. 22 19:43, Peter Wedder wrote:
>
> > Hello,
> >
> > I have been working on an article to describe the process of writing UC=
M2 configuration to split multi-channel devices into smaller devices, parti=
cularly in the context of USB audio interfaces. This is a common problem wi=
th enthusiast/studio USB audio interfaces and it happens to be a pet peeve =
of mine.
> >
> > I recently contributed a profile for the Behringer UMC204HD (https://gi=
thub.com/alsa-project/alsa-ucm-conf/pull/128) and found the process to be a=
 little intimidating, but with a lot of help from Perexg I managed to get i=
t working. I would like to help other potential contributors out by explain=
ing the process step by step.
>
>
> It's because many things are work-in-progress and there's a tight relatio=
n
> between UCM and the alsa-lib's configuration.
>
> > I was considering posting the article to the Fedora Magazine (https://f=
edoramagazine.org/), since that's the distro I use. However, I wanted to ch=
eck with you, the ALSA maintainers, first, because the intent of the articl=
e is to encourage readers to contribute UCM configurations for their own ca=
rds, and I thought perhaps a potential surge of contributions is not someth=
ing you want at the moment.
>
>
> At the time there's a lot of USB cards configs waiting for the merge, but=
 I'd
> like to clean the configs at first. The per card configurations should no=
t
> bother so much with the alsa-lib configurations. Also, I'd like to suppor=
t the
> channel management (split) by the applications. The implementation may be
> completely hidden in the included common blocks.
>
> > Let me know what you think -- is this a welcome idea or should I forget=
 it? I have a draft of the article available here: https://gist.github.com/=
brndd/ccec98a575f7c0422d50402937439227
>
>
> Thank you for this work. The document looks nice for users dealing with t=
he
> support for this type of hardware. Please, wait a moment to complete this
> support. I will be happy to co-operate with you to finish this.
>
> I created an issue #154
> (https://github.com/alsa-project/alsa-ucm-conf/issues/154) and I'll try t=
o
> update it until this is finished.
>
> Jaroslav
>
> BTW: perexg =3D me
>
> --
> Jaroslav Kysela perex@perex.cz
>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
