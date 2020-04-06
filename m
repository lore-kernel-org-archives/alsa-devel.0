Return-Path: <SRS0=9St4=5W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222D6C2BA19
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:35:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E560206F8
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Apr 2020 09:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="h9KzEMg+";
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="vecXarLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E560206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E29B814E;
	Mon,  6 Apr 2020 11:34:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E29B814E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586165748;
	bh=ga2SXvp6LjJsSkRM6/PjQZeG9Gas1wC84xWLDV54xw4=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h9KzEMg+qXV5bbl8qlld1MKPpfjbcvY8l6qY2XUrTejXAPdkPYUdJRNlAJIwWZ7N8
	 PQ0Qwbxitt9A9TNbznundb8qiMNiNm63CMK9YTo60ntCiNAF55tXAAKJ0OEAEisc7P
	 WoGjXZP/Q5Pj8QT6RhU6Lc2qGyUmfM5+zyjTWSkI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 730CDF80142;
	Mon,  6 Apr 2020 11:34:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C435BF80143; Mon,  6 Apr 2020 11:34:55 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89340F800CC
 for <alsa-devel@alsa-project.org>; Mon,  6 Apr 2020 11:34:51 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 71FA3A003F;
 Mon,  6 Apr 2020 11:34:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 71FA3A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1586165691; bh=Ojw594Yllu3GBcEEaVMv6y5zcr3jdjIwZR1y8mcDRrc=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=vecXarLW8i7EtUFro63sG1+rfSrgashwThtVarKZnUpUZ6Cy4ZAHtt4rDMkZT6PM9
 jezCebn5FN/oYmy3Wl1CcWP70oZWbuEymxiY6+/E29dZpZp7wGHbm+EATZTIeFKYtX
 NO9c8N9de9JmWPqVuxlUI3Uf+6HOtPUEIMUnKePI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Mon,  6 Apr 2020 11:34:49 +0200 (CEST)
Subject: Re: [PATCH 5/5] cht-bsw-rt5672: Fix HiFi-stereo-dmic2 conf not
 loading / working
To: Hans de Goede <hdegoede@redhat.com>
References: <20200405183454.34515-1-hdegoede@redhat.com>
 <20200405183454.34515-5-hdegoede@redhat.com>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <1e466650-dc6f-4757-a36b-6f32639e99be@perex.cz>
Date: Mon, 6 Apr 2020 11:34:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405183454.34515-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

Dne 05. 04. 20 v 20:34 Hans de Goede napsal(a):
> Fix HiFi-stereo-dmic2 conf not loading because of references to
> non existing devices in the ConflictingDevices sections.
> 
> Stop playing Rename + Remove tricks with the output (Speaker2) and
> input (DMIC1) devices which we do not want to be part of this config,
> this does not work now that we only allow devices which are actually
> part of our config in the ConflictingDevices sections.

The Remove and Rename operations should also manage (remove and rename) 
devices in ConflictingDevices/SupportedDevices sections. What's the exact 
error you hit?

If I simulate this via ucm-validator I get this device structure:

  Verb: "HiFi"
     File: HiFi-stereo-dmic2.conf
     Device: "Headphones"
       ConflictingDevices.0 = Speaker
       Value.PlaybackPriority = 300
       Value.PlaybackPCM = 'hw:${CardId}'
       Value.JackControl = 'Headphone Jack'
     Device: "Headset"
       ConflictingDevices.0 = Mic
       Value.CapturePriority = 300
       Value.CapturePCM = 'hw:${CardId}'
       Value.JackControl = 'Headset Mic Jack'
     Device: "Speaker"
       ConflictingDevices.0 = Headphones
       Value.PlaybackPriority = 200
       Value.PlaybackPCM = 'hw:${CardId}'
     Device: "Mic"
       ConflictingDevices.0 = Headset
       Value.CapturePriority = 200
       Value.CapturePCM = 'hw:${CardId}'

It appears like an issue in alsa-lib.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
