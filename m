Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01FEDC19F2D
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Aug 2022 14:45:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 084DE1E2;
	Tue,  9 Aug 2022 16:44:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 084DE1E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660056323;
	bh=TPaQQ4+qc61L/X5GoX/Bfb8qpI1MgbuITTkAHve9x3w=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fiHR0emNFviQ5aS1/iytT3SwNo/oxwZl3rUEcP1lziGgNUKPEYs+Umzp1DhyOlZao
	 lUdJUO1kV1J+fnz1wOszzLI0x3CxSkA53XCe/H8R59sT/l+Q7dhXFB4UChHqsA9381
	 bls1JmesqmC/sLZqeF8vkqZVTp0wXQGRVRt9mqs4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93D6BF8012A;
	Tue,  9 Aug 2022 16:44:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90A7CF8016C; Tue,  9 Aug 2022 16:44:31 +0200 (CEST)
Received: from w1.tutanota.de (w1.tutanota.de [81.3.6.162])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E225F8012A
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2022 16:44:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E225F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=tutanota.com header.i=@tutanota.com
 header.b="1PdFuitB"
Received: from w3.tutanota.de (unknown [192.168.1.164])
 by w1.tutanota.de (Postfix) with ESMTP id 5C845FBF3B2
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2022 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1660056263; 
 s=s1; d=tutanota.com;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=TPaQQ4+qc61L/X5GoX/Bfb8qpI1MgbuITTkAHve9x3w=;
 b=1PdFuitBMMBJWf8uxnUwMR0JNp4ikvpnR/ewh8ETW2KlP82h7wNgxJUjUBveBmnF
 FOQz770OTS5DYeWA2oEWBGycvF+P9fxBaKYOV8p5A/86BczVNWjROixDLh8U6sgmLJO
 gjuK2dhKE/DKZKZVZLOe706RQt/1c88j44bAzgLUu3DhTcNRFlGA5LQ8xBggS4mnGKc
 yj/R0aGpA7E66LQDR2OQmxO3VCic0rGqIssw+rmPFpaggOL1wkYCmN79+Phqji0VJuL
 T+JZQIan0cqXRGQlaCGnQETr1lKnSErhutICBJNer00H7seDjKFsw7kQUMeoSRDa29j
 iHkjWT4VWg==
Date: Tue, 9 Aug 2022 16:44:23 +0200 (CEST)
From: forevernoob@tutanota.com
To: Alsa Devel <alsa-devel@alsa-project.org>
Message-ID: <N9213zQ--3-2@tutanota.com>
Subject: How trivial would it be to port the DICE driver from FFADO?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

Hello,

I'm new to these kinds of mailing lists so please forgive me if I'm doing s=
omething dumb.

I would love to see Allen & Heath Zed R16 as well as Midas Venice F32 suppo=
rt in ALSA.

Currently (at least according to libffado-2.4.4/configuration), they are su=
pported via the DICE driver:

{ # Allen and Heath Zed R16.=C2=A0 Information from Brendan Pike.
=C2=A0=C2=A0=C2=A0 vendorid=C2=A0=C2=A0=C2=A0 =3D 0x000004C4;
=C2=A0=C2=A0=C2=A0 modelid=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000000;
=C2=A0=C2=A0=C2=A0 vendorname=C2=A0 =3D "Allen and Heath";
=C2=A0=C2=A0=C2=A0 modelname=C2=A0=C2=A0 =3D "Zed R16";
=C2=A0=C2=A0=C2=A0 driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "DICE";
=C2=A0=C2=A0=C2=A0 mixer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "Generic_D=
ice_EAP";
},
{ # Midas Venice F32.=C2=A0 Information from Jano Svitok.
=C2=A0=C2=A0=C2=A0 vendorid=C2=A0=C2=A0=C2=A0 =3D 0x0010C73F;
=C2=A0=C2=A0=C2=A0 modelid=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0x00000001;
=C2=A0=C2=A0=C2=A0 vendorname=C2=A0 =3D "Midas";
=C2=A0=C2=A0=C2=A0 modelname=C2=A0=C2=A0 =3D "Venice F32";
=C2=A0=C2=A0=C2=A0 driver=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "DICE";
=C2=A0=C2=A0=C2=A0 mixer=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D "Generic_D=
ice_EAP";
},

In their source code I think it's this file: http://subversion.ffado.org/br=
owser/branches/2.4.x/libffado/src/dice/dice_eap.cpp

So my question would be: How difficult would it be to port this driver (mor=
e specifically: Port it sufficiently enough to support the aforementioned d=
evices) ?

Are we talking trivial enough for someone with minimal C experience, a dedi=
cated team of ALSA devs or something else?

Thanks in advance,
FN
