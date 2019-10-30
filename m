Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF067CA9EC5
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:41:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2452087E
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jyd3yaA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2452087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=argudo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 300D622E0;
	Wed, 30 Oct 2019 10:40:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 300D622E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572428474;
	bh=R9GLDXFOHJ664iDfwB/e9n0wtXAl4WOb5ndw7E5ZzK8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jyd3yaA4kQhmorO3BqJ+gY/7xdWEWU+HX/L3vQFa+j6IkePKXSjpks3DE5++L+pGV
	 ucfhTdhXYCiVrJdw+8W4xBtcxovUgGqgb1Ne6WUlQoPWagbaqSbHSu8dS3a1p3/WTI
	 1FyXuw+72TzIGsz16HPdnKppiPsz0zdepPPKqxaY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B74C0F802BD;
	Wed, 30 Oct 2019 10:40:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4854F80361; Wed, 30 Oct 2019 10:40:22 +0100 (CET)
Received: from heaven.argudo.org (heaven.argudo.org [195.154.250.235])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84EE1F802A1
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 10:40:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84EE1F802A1
Received: by heaven.argudo.org (Postfix, from userid 1008)
 id A50A21502373; Wed, 30 Oct 2019 10:40:19 +0100 (CET)
Received: from deiphobe (maison [78.229.44.71]) (Authenticated sender: jpa)
 by heaven.argudo.org (Postfix) with ESMTPSA id 12C1E1500276;
 Wed, 30 Oct 2019 10:40:19 +0100 (CET)
Message-ID: <ad6f8c036538aa755017efe976ac223bb7c90be3.camel@argudo.org>
From: Jean-Paul Argudo <jpa@argudo.org>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Wed, 30 Oct 2019 10:40:18 +0100
In-Reply-To: <20191030091540.GA1856@workstation>
References: <769b9f5dae864cf1eb433ab84eed385a161931c8.camel@argudo.org>
 <20191030091540.GA1856@workstation>
Organization: PostgreSQL Fr
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] snd-bebob : from kernel 4.13 to 5.3.19 and .20
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Dear Takashi,

Le mercredi 30 octobre 2019 =E0 18:15 +0900, Takashi Sakamoto a =E9crit :
> [...]
> > =

> > First, I hope I report this the best way, really not sure here.
> =

>  =

> This list is for this purpose. Thanks for your report and I apologize
> your inconvenience.

Don't apologize, bugs happens. =


I thank you very much for this fast answer.

> =

> > If not, please tell me what to bring (files? logs?) and where (on
> > this
> > list? elsewhere?).
> > =

> > I have spare time to investigate anything that could help here.
> =

> The messages in syslog means that your Focusrite Saffire LE
> transfers isochronous packet to your system with discontinued
> sequence number.

OK.

> But subtraction of the counter (e.g. 0x20 and 0x60 in the
> last line) always results 0x40. The former(=3D0x20) is expected
> but the isochronous packet includes the latter(=3D0x60). I think
> it's any possible bug of ALSA IEC 61883-1/6 packet streaming
> engine and check it. =


OK.

> I'll install Eoan kernel and test my devices.
> (but I don't have Saffire and Saffire LE...) I'd like you to wait
> for my test report.

What I can say is that with kernel 4.13 under Ubunto Disco everything
was fine :-(

I can say too I never had to plug external power, the power by the
firewire cable has allways been enough for it. And this is still
working on Windows 10 (I have dualboot on my computer, but only do
audio things on linux, mostly with Ardour).

> =

> Thanks

Thanks to you !!

I'll be waiting for your tests. Be sure to ping my anytime you need
info, log files or whatever. =


I'm "jpa" on irc.freenode.net, connected worktime (~9am ~8pm UTC+1)

Cheers, =



> =

> Takashi Sakamoto

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
