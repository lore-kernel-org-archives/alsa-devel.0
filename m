Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269FAC43334
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jun 2022 12:40:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4810B18DF;
	Thu,  9 Jun 2022 14:39:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4810B18DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654778399;
	bh=3ttDPYESbPhDkitRsjh6mOy4Zs31sxMdUKsBjJxwFRU=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uQrww66OGDndkBD/01rRsOlYkEQxKQjcj+Fq/te6jDRGwQswnxPot5topMJ3FJD9z
	 g/87vbXuAUUoIkTMk4z8NO5H6TM33N3qSAYYYwYXYsm2jRVXE94e2RfDJRwC01ZVfh
	 52qm1kxjQN8lwuD3j0ySmaICt99abDVQkDe9Cz0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C700CF800E9;
	Thu,  9 Jun 2022 14:39:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E287F8019D; Thu,  9 Jun 2022 14:39:07 +0200 (CEST)
Received: from cable.insite.cz (cable.insite.cz [84.242.75.189])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E437FF80116
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2022 14:39:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E437FF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="VXL00m+7"; 
 dkim=pass (1024-bit key) header.d=ivitera.com header.i=@ivitera.com
 header.b="gdszVqtj"
Received: from localhost (localhost [127.0.0.1])
 by cable.insite.cz (Postfix) with ESMTP id C6F6FA1A3D401
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2022 14:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1654778343; bh=3ttDPYESbPhDkitRsjh6mOy4Zs31sxMdUKsBjJxwFRU=;
 h=Date:To:From:Subject:From;
 b=VXL00m+7QS3AiLYodSUjZXtzhd+SfDKQy12+lk4wqeqzNUQcm4Mt8sy6+0OkxGKn/
 TcjuY0L+xdtrnVWQw+mrdVGRX5bkPnVMCmSP4ZMyenw/wA/M+IiZ3FBvnoDMS7bW2F
 Vsq+hJ+gLFYQJi7Ql7j3nE7wRUmahyRb399U1vds=
Received: from cable.insite.cz ([84.242.75.189])
 by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XTm3T5k5oHZ0 for <alsa-devel@alsa-project.org>;
 Thu,  9 Jun 2022 14:38:58 +0200 (CEST)
Received: from [192.168.105.22] (dustin.pilsfree.net [81.201.58.138])
 (Authenticated sender: pavel)
 by cable.insite.cz (Postfix) with ESMTPSA id A038CA1A3D400
 for <alsa-devel@alsa-project.org>; Thu,  9 Jun 2022 14:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ivitera.com; s=mail;
 t=1654778338; bh=3ttDPYESbPhDkitRsjh6mOy4Zs31sxMdUKsBjJxwFRU=;
 h=Date:To:From:Subject:From;
 b=gdszVqtjL0ub5vzsZAnYzhiJGy1E7oV2h1hWeG/2pqLK9ksTD9Jd677tG/+MJwjMb
 2bl92Ey9kNbD+dT2l68OLBngoLPxivJn3Fem9VeJarVKWeN1SdR2oHfQFXNJZN8gCw
 62bedyCEf2Yni+gP21fvRflaqs3N3iHSbLP0DMng=
Message-ID: <9892a324-a549-c411-9d2c-0a10c580422d@ivitera.com>
Date: Thu, 9 Jun 2022 14:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Enabling tstamp in proc status file externally
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

Hi,

Please is there any way to enable the tstamp in stream status without 
modifying the client calling the alsa-lib API? I wanted to measure 
samplerate ratio between soundcards using data in their status proc 
files (comparing advancement of tstamp vs. hw_ptr). The method seems to 
work quite good, but some clients enable the stream status tstamp (e.g. 
pulseaudio) and some don't (e.g. sox, aplay), resulting in zeros in the 
status proc file.

Thanks a lot for any help or hint.

Best regards,

Pavel.
