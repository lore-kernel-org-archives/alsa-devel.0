Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE684C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Dec 2021 19:06:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 685281F8A;
	Fri, 17 Dec 2021 20:05:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 685281F8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639767988;
	bh=unhBEWV4DcZoycnlM3h/64RBzpPjl1/hXf+Q0t0KeB4=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WmGZLuFnKVlnNfN1FO9T+eMhj1yyMTGpOoFsVFv0dRzMpvKrsdpXhhUiXRcP0U3OF
	 12xQiqU8z85LR/1wQ6+C85AsVFTRcMatos4QKUcZIRUAaRmPmL0pWG/f0Ea5jpcwjR
	 JpZQpXkFpg4/76Gb43/TA97jxC/nD8gG0rHMShC0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E6CB6F80161;
	Fri, 17 Dec 2021 20:05:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F3E91F80163; Fri, 17 Dec 2021 20:05:35 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3CD52F800AB
 for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2021 20:05:30 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 3D9D7A003F
 for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2021 20:05:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 3D9D7A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1639767929; bh=mXQYfAvXHUX0EFlyWpRQc3EkEgkXK5Kz+pTouNoSTYM=;
 h=Date:To:From:Subject:From;
 b=CjFka23DZQRg2qtqXYKDIc1Fg7b8vDJ7jQ1M9/GmotZokvNQUGmIpryrXZN6seb0z
 zJNGocJDBwgvK4JbIFmlH9dxHErED9u96PrwsN9ZOxu6lD3zZW2WdUIkSRZLq8ZvPC
 CKWA8gMQlheXH8qvrrNHlS/QfML9sOQWjrTfWIhQ=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2021 20:05:28 +0100 (CET)
Message-ID: <fd194310-29c7-3de9-6813-056dc6780537@perex.cz>
Date: Fri, 17 Dec 2021 20:05:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA 1.2.6.3 release
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

         new ALSA userspace packages were released. This is third bugfix
release. You may download them from the ALSA website
http://www.alsa-project.org or directly:

         HTTP: https://www.alsa-project.org/files/pub
         FTP:  ftp://ftp.alsa-project.org/pub

Released packages:

         alsa-ucm-conf

Full list of changes:

         https://www.alsa-project.org/wiki/Changes_v1.2.6.2_v1.2.6.3

The fingerprint of the public signing key is:

         F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
