Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3821C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Dec 2021 16:06:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 257892447;
	Wed,  1 Dec 2021 17:05:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 257892447
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638374794;
	bh=OkOvlHgv4qNCDgBCYXPJyInPzkQLG+aoKR8TDE5//Zs=;
	h=Date:From:To:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=amm0+xPCwbWxn7vSxTVrnf/lLMbpsOTXf4Idd26NiDe2a6XeakCa3RZnsIF8SW1Eb
	 QGujtUOFfekWqFXuwZ1Uk1ftUWUP+bZ01FAjX/SKvv3ezfgPgCT5bNPWwYZ67AFQ3f
	 BPjPk+Gmgo71CfsfdoZuK8K2UeEXYiTfaVJjwEGY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E92EF80240;
	Wed,  1 Dec 2021 17:05:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8D99CF80246; Wed,  1 Dec 2021 17:05:38 +0100 (CET)
Received: from disco.pogo.org.uk (disco.pogo.org.uk [93.93.128.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EA8EDF800EE
 for <alsa-devel@alsa-project.org>; Wed,  1 Dec 2021 17:05:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EA8EDF800EE
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=xwax.org header.i=@xwax.org
 header.b="tj4mWi91"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xwax.org;
 s=swing; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:
 Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rH75RfDa89bPU7aeW8Y7cnoTU5uKr1AcaJ6IRARZ4F0=; b=tj4mWi91pMwcEq1WZQhj45aBoP
 L5lGOyvwJKDLAs/7C8g4GxKWJEUFdagepPwioIHo/pU7YqGIlaq4ct6DvRQjlbgvlf/PpyzVTLUQO
 RTkYd0XHf+q8vwDXsCUOjKEWKLck94Tb/2vaJKa99x1APlLoH+n4PkZBO0Afg5zyjmgs=;
Received: from [2001:470:1d21:0:428d:5cff:fe1b:f3e5] (helo=stax)
 by disco.pogo.org.uk with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2 (FreeBSD)) (envelope-from <mark@xwax.org>)
 id 1msS6v-000LKI-UV
 for alsa-devel@alsa-project.org; Wed, 01 Dec 2021 16:05:33 +0000
Received: from localhost (stax.localdomain [local])
 by stax.localdomain (OpenSMTPD) with ESMTPA id 859429cf
 for <alsa-devel@alsa-project.org>;
 Wed, 1 Dec 2021 16:05:33 +0000 (UTC)
Date: Wed, 1 Dec 2021 16:05:33 +0000 (GMT)
From: Mark Hills <mark@xwax.org>
To: alsa-devel@alsa-project.org
Subject: What is "DMAR: PTE Read access is not set"?
Message-ID: <2111061231140.2448@stax.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Recently, seeing from the kernel when my audio device (Layla3G, PCI) is 
open:

  [ 2333.598177] DMAR: [DMA Read NO_PASID] Request device [0a:00.0] fault addr 0xfffe0000 [fault reason 0x06] PTE Read access is not set
  [ 2333.768836] DMAR: DRHD: handling fault status reg 3
  [ 2338.376854] dmar_fault: 80 callbacks suppressed

I'm not really sure where to begin here; does it mean that snd-echo3g 
should be making some up-front declaration of how it uses some DMA area?

Seems to have appeared in the 5.14.x series (currently 5.14.16) but also I 
did a BIOS update in that time for another issue. 5.15.6 (latest stable) 
is also still affected.

Audio plays fine; but my logs are full of these excess messages.

-- 
Mark
