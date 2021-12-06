Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125A8C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Dec 2021 14:05:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 693C91929;
	Mon,  6 Dec 2021 15:04:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 693C91929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638799537;
	bh=B2//pyhOGeeX+AchdMUdPjEyKETmOMRsUsdsKq+VSO0=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=V+GJMXC0gB53XrcpApvE9dX91eCpOzFXO+HaMUG1bgcTHplkm+M5dxrAAPSeCIe2U
	 1LwKOu4pq8ojl+rll9T195a10Zhn/wwDFHpAeqQtvDqWf00s623A+TnbTaoSF8mCB9
	 ooup4lAa+11apiEA6t7enYTZT2IDzUZultFiKwm4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6B14F804E4;
	Mon,  6 Dec 2021 15:04:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3CF9DF804EC; Mon,  6 Dec 2021 15:04:45 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 332E6F804E4
 for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2021 15:04:36 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 977CCA003F
 for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2021 15:04:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 977CCA003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1638799475; bh=Pt2QopUzEHjuVBtEUwwEQrzM5DNkl0AGLvUvjJsRF8M=;
 h=Date:To:From:Subject:From;
 b=3RgbVGWv/eactExsebIZdLQH8Nlh1ldkCgzzrxfk8//ExK37j0pXAJHcK4dgFcY3J
 bEyNH3C0joaOhrdv2LgvhkmFctwdi/I/JVzHGhuQo1riUzRItnkdwvKQ6P1ZCJkMd4
 NMAijJ2Fu2+NbcNgD3lbxSbJ+lasgCKbBcesNqng=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Mon,  6 Dec 2021 15:04:34 +0100 (CET)
Message-ID: <0c540952-d18b-ba38-47d9-4a809ef401d9@perex.cz>
Date: Mon, 6 Dec 2021 15:04:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA 1.2.6 release
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
      alsa-utils
      alsa-plugins
      alsa-ucm-conf
      pyalsa

Full list of changes:

      https://www.alsa-project.org/wiki/Changes_v1.2.5.1_v1.2.6

The fingerprint of the public signing key is:

      F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
