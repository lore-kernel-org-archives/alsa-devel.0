Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D48C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:15:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA58720B1F
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 10:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KBzJoRG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA58720B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=reaktanz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10231173D;
	Thu, 18 Jun 2020 12:14:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10231173D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592475347;
	bh=pvqbrENaPF1edZkV4uAwuNKVBxUkOy8J4eNXtWgmc2Y=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KBzJoRG1Q64+eDZzPuhFkXjGOrdnWcM7EvLvARyNQdJtmV91GOkJEN5mZiL5UxtZR
	 zhemr4UBcREVzzv3NYXLrq9QSnHIcDcm/KMTWdtQyCDWKNYa2JUt1rERO9rytEKowE
	 oDUqQETi1WJPmsfgexseiHmaBtSOXdPYx5GbQhuk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9495AF8010E;
	Thu, 18 Jun 2020 12:14:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AB18CF80116; Thu, 18 Jun 2020 12:14:54 +0200 (CEST)
Received: from smtprelay03.ispgateway.de (smtprelay03.ispgateway.de
 [80.67.31.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF45FF80101
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 12:14:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF45FF80101
Received: from [87.123.35.171] (helo=yrla.localnet)
 by smtprelay03.ispgateway.de with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <alsa@reaktanz.de>)
 id 1jlrZH-0003ll-H0; Thu, 18 Jun 2020 12:14:47 +0200
From: "m.eik michalke" <alsa@reaktanz.de>
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: presonus StudioLive 24.4.2
Date: Thu, 18 Jun 2020 12:14:41 +0200
Message-ID: <4447737.uXMYkMNjJ4@yrla>
Organization: https://reaktanz.de
X-Face: :Fk?kfw3:=Vz)np%nh,d4^[#)-y,9IYe:y,; }P|%`fw>/.msl.f=*6j*-f$vL09$qopvp6
 Ox|(^ge<|+0iS]{&|\<0>i7r'@'k+i=eB5y8*pO$#xT+$2uq=`
In-Reply-To: <20200617233213.GA281450@workstation>
References: <1859294.RmyynjnHiM@meadow> <1950143.FVrUTiCnyk@yrla>
 <20200617233213.GA281450@workstation>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Df-Sender: MmRXRmFlNmlha21wWFBSNnA5Y1lAYWQuZ2VsZHVudGVyZ2FuZy5iaXo=
Cc: alsa-devel@alsa-project.org
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

hi,

Am Donnerstag, 18. Juni 2020, 01:32:13 CEST schrieb Takashi Sakamoto:
> > ok, could a hack like this also help me out?
> >=20
> >   http://www.jrigg.co.uk/linuxaudio/ice1712multi.html
>=20
> Yep, the PCM multi plugin in alsa-lib seems to be available as well.

that's encouraging. now i only have to figure that out ;) never had to deal=
=20
with .asoundrc before (which is testament to the hard work of all of you,=20
thx!).

> From my curiousity, would I ask you extra check in system log (like
> journalctl -k)? ALSA Dice driver supports TCAT protocol extension, and
> it firstly attempts to detect it for all of devices without explicit
> flags (in your case). If the device doesn't support the extension, the
> attempt fails and we can see below log:
>=20
> ```
> kernel: snd_dice fw1.0: transaction failed: timeout
> ```

here's what i see in journalctl -k when the device is being plugged in:

kernel: firewire_ohci 0000:05:00.0: isochronous cycle inconsistent
kernel: firewire_core 0000:05:00.0: created device fw1: GUID 000a920404af77=
44,=20
S400
kernel: firewire_core 0000:05:00.0: phy config: new root=3Dffc1, gap_count=
=3D5
kernel: firewire_core 0000:05:00.0: IRM is not 1394a compliant, making loca=
l=20
node (ffc0) root
kernel: firewire_core 0000:05:00.0: phy config: new root=3Dffc0, gap_count=
=3D5
kernel: snd_dice fw1.0: transaction failed: address error

let me know if you need anything else.


viele gr=FC=DFe :: m.eik



