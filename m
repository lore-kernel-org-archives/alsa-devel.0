Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463D4C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jun 2022 16:00:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE7841EEE;
	Fri, 17 Jun 2022 17:59:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE7841EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655481617;
	bh=qW8HfvDAZawQaEfKWSAaJHCSDpNX7Y7e/4vXtWde3To=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=iQpzYnRAG+sN0wNPFxaFIQf/xuY7CChFVDwgHombOwgtIA96LYv1xEBqdlTxHKKUm
	 0lTAyZNjmf39EEVAlCNHW1br7RWYTKiBzGd98eEwm430cg3IPbvATl/pURIlvyI885
	 T2OMWPArVX6W5ApaBHM3ePMDVcmcyMNltU7PVrWc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DE1DF8051F;
	Fri, 17 Jun 2022 17:59:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C13DF8051F; Fri, 17 Jun 2022 17:59:25 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A240AF804BC
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 17:59:18 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E6ADCA003F
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 17:59:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E6ADCA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1655481557; bh=izjBi7AVFDBIxGTgudPJ02d25Z/+2rTu3NWE3knxBkQ=;
 h=Date:To:From:Subject:From;
 b=YvpNR7F57TlUG3Br+hLDQRaNbVak4LpAaiU++yVFww6LIPyaX1lX1OK7/AG69cLqv
 2IeOVcSRAcSPPQPd31CmKN0mVGQPersbYeRt/2+3zjaSB1GzBLpQgbm9M7uZMXfO4I
 kz38C4Tv17E3wXI7lLDmtUaRKhtQREMn16okvPKY=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 17:59:16 +0200 (CEST)
Message-ID: <31c3cc9c-a4db-d97b-6b55-c5d471f9f6d8@perex.cz>
Date: Fri, 17 Jun 2022 17:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA 1.2.7.1 release
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hello all,

        new ALSA userspace packages were released. You may download them from
the ALSA website http://www.alsa-project.org or directly:

        HTTP: https://www.alsa-project.org/files/pub
        FTP:  ftp://ftp.alsa-project.org/pub

Released packages:

        alsa-lib
        alsa-ucm-conf
        alsa-plugins

Full list of changes:

        https://www.alsa-project.org/wiki/Changes_v1.2.7_v1.2.7.1

The fingerprint of the public signing key is:

        F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
