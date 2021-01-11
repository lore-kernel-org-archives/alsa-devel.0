Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E17C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 19:01:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E8922A84
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 19:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E8922A84
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91160173B;
	Mon, 11 Jan 2021 20:00:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91160173B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610391706;
	bh=BsDslaC8+CnH3vrVfwaZrumH+bZiSCeWdaePHlaWe1Y=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JjIdutDCpN/IPC3uoxCuvcIbjbcdFEbVBT//7GiN3HhrwiXT151lL93QMZPLLZnz+
	 euyGga76Wj5ErCDRnIYLg5gGJU9uN8koyNc9vyIfT+90KivDepgUztR4k5LEYZxTcG
	 zL3IHv65Km6AEbNxbxHkFRv8O2ZEVNZQuod1BWFE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2F6A6F8013D;
	Mon, 11 Jan 2021 20:00:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EBD6CF8026B; Mon, 11 Jan 2021 20:00:17 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A6B5BF80254
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 20:00:11 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3B8EEA003F;
 Mon, 11 Jan 2021 20:00:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3B8EEA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1610391606; bh=ziYQCPC8cskXBVMPMfw8xQ6rH6S6XxzJ7iO2j2KoDYs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dddB8tHMuS7AGGY3xNF2O0WymT1Vrc7yB1JZ2rplJwJT5G4i/zAmRyIpPmbC2lAj4
 DS4h97KwubWSKVanvxx3dSSSGTvfmE6PggLB62DEYD3USTGE/cazLrNNsGzGyKoAzQ
 1+NMfcXi14Fcv7cKzSKfpm9zxsq/WWzbV0I8yauA=
Received: from p1gen2.localdomain (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon, 11 Jan 2021 20:00:03 +0100 (CET)
Subject: Re: [PATCH alsa-ucm-conf 2/2] rt5640: Move standard DAC setup to
 EnableSeq.conf
To: Hans de Goede <hdegoede@redhat.com>
References: <20210109210252.159162-1-hdegoede@redhat.com>
 <20210109210252.159162-2-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <4e16c283-bc57-f527-2703-0efa347e8ad2@perex.cz>
Date: Mon, 11 Jan 2021 20:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210109210252.159162-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Dne 09. 01. 21 v 22:02 Hans de Goede napsal(a):
> No matter which output is used, we always need to setup the standard
> DAC config. Move this to the shared EnableSeq.conf to avoid having
> to duplicate it in various places.

Applied to the ucm repo. Thank you.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
