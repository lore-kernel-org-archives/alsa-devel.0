Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A991C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 31 May 2022 18:57:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 848A717E2;
	Tue, 31 May 2022 20:56:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 848A717E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654023444;
	bh=aJvvi+DOrp2Wy8MzGzce1dmFaJBMrtd4lTSOucZNNSE=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CXFwKlQvhQKrJNAEVILlUxEWIzJpkaGjvZqjsNNG8gzXGFUI69wPapT61tdx4NVsu
	 47OAb4hBk+KtqRRCgQ+PLUTb6VWPx8dGCj/ZxB8AZwzJfjJLX1lrkdvrfAw1DpPTJk
	 HOzdc/8Qium+nkxe/W+zth9znF932mcW4k0PJT/o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BA0EF804C3;
	Tue, 31 May 2022 20:56:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 867DAF8014D; Tue, 31 May 2022 20:56:32 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A737CF8014D
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2022 20:56:26 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id E8EA6A003F
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2022 20:56:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz E8EA6A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1654023385; bh=71uo0YTIFlxKJHXlUyo722ovi25Hc77FFyC/Mg5tp6Y=;
 h=Date:To:From:Subject:From;
 b=pdO9h654GqJ/kk0LL3W645iC3zlswhlDGCT7XbKRbWWb8Uv5gQr36CFb85NbdzGaW
 /WyPGLFO/+AN4mny2f8HHU3gaIdmM7rcjgt7WSwdUuAca0nYh93C2lW/adOGPYrY7l
 e58pynZd1q7/+julnJwyfFNlEYvu9rfUK7ak/5/0=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2022 20:56:24 +0200 (CEST)
Message-ID: <a65aa065-f6d2-332e-2625-ea88be1b38cf@perex.cz>
Date: Tue, 31 May 2022 20:56:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA 1.2.7 release
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
       alsa-ucm-conf
       pyalsa

Full list of changes:

       https://www.alsa-project.org/wiki/Changes_v1.2.6.3_v1.2.7

The fingerprint of the public signing key is:

       F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
