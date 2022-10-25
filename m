Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D1FC04A95
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Oct 2022 06:57:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D6135ADC;
	Tue, 25 Oct 2022 08:56:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D6135ADC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666681036;
	bh=e2DQ47Rq1pBmGfTstR1nZfpLsCOeH9IAVRaWzpuzoxg=;
	h=Date:To:From:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RuWsw2WVDVvw/koTF8KVrEKHtfnry5KixfF0FURDouMRtyhMnQpjwjo/MnsS0RNhr
	 5hSSam0hY1XIQWm+DBnnb+t6DKHMUDi6uSpcPhLH6RbdxBunlxhdKbiX9kFdxtawr0
	 s/lBgj+DT6eahvVu78XOIXiy2B2oDWRjkj2GEZ4Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EBB45F80100;
	Tue, 25 Oct 2022 08:56:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2C9C5F80431; Tue, 25 Oct 2022 08:56:24 +0200 (CEST)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D608F80100
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 08:56:17 +0200 (CEST)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id C1F38A0040
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 08:56:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz C1F38A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1666680976; bh=SEnxBOmsMmfrU2T+yyc5L5xJ3Z/FFBvlTye2V4IhGt8=;
 h=Date:To:From:Subject:From;
 b=ZY/TeKB/4X1oq+ab9Q+NiGGIKPAMueuQADVX+8K8KFj4fzRDoZ9MJR3xcwzgTwNrj
 dcfEI8f6cZzaCTAjrG8lp9pv9GKpwo20DJaOQfiwldQiAfMpnA2OJQYKYztINItKr8
 7VwMQxCoTiWhqDmihB2CJLn1QtxnozCUV2xFOZLs=
Received: from [192.168.100.98] (unknown [192.168.100.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 08:56:15 +0200 (CEST)
Message-ID: <042e2b9f-6e1c-b821-0b30-d317ea771172@perex.cz>
Date: Tue, 25 Oct 2022 08:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
Subject: ALSA 1.2.8 release
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
	tinycompress

Full list of changes:

	https://www.alsa-project.org/wiki/Changes_v1.2.7.2_v1.2.8

The fingerprint of the public signing key is:

	F04D F507 37AC 1A88 4C4B 3D71 8380 596D A6E5 9C91

				Have fun,
					Jaroslav
-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
