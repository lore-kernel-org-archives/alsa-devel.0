Return-Path: <SRS0=+StP=ZM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B32DC432C0
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:05:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B02FB2243E
	for <alsa-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="YkXp9zdu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="av21nwp/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B02FB2243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8CDC7168F;
	Wed, 20 Nov 2019 11:04:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8CDC7168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574244337;
	bh=FbLYBEcdhTtXsDbGR9aWW2d11aQ2fVe2SP/WA2xF/44=;
	h=To:From:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=YkXp9zduq2tVhspMrpTWS8VODeuTrkpM83MqFa5jb3uiaPOgTtt8byJc3HfE37rGZ
	 wmj71EaEx8Il+P7z8lTwizjAUqFNEafYixEDCbQgwjwyvKZSh8HfsP1TG/AJYgyzxN
	 ptny5iW7DopQ8qB59b/VEP4XL5C26KWJDeE7RBMw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00684F8013C;
	Wed, 20 Nov 2019 11:04:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00589F8013D; Wed, 20 Nov 2019 11:04:45 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7324DF800F0
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2019 11:04:43 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 79A21A0040;
 Wed, 20 Nov 2019 11:04:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 79A21A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1574244282; bh=BSHvK6tIqXMEFRi+cVoL/OXQLJYHtpTBptTqHOkmCf0=;
 h=To:Cc:From:Subject:Date:From;
 b=av21nwp/h5LmZUsx/T3B1T7kbjhYrebfQk1sSg603GROSeSwyN0Xwk+j010Qrit8A
 jisFcz02VV42VyE3c8wTrYaBwBVsrw3VH1Ax/Ox81TEORGGK73u3FhP9nNpTPJBsVQ
 eLXd1Pfus2ToQruEUTHEixX6A4n4NfZa61QYccJI=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed, 20 Nov 2019 11:04:38 +0100 (CET)
To: ALSA development <alsa-devel@alsa-project.org>
From: Jaroslav Kysela <perex@perex.cz>
Message-ID: <ef29c9d6-b359-a9df-f8fa-d547b02bc8d2@perex.cz>
Date: Wed, 20 Nov 2019 11:04:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] ASoC, DMI and UCM
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi all,

	I would like to discuss the way we use DMI information for the board 
identification in ASoC for the user space (long card name). It's a bit 
redundant information, because DMI is already exposed through 
/sys/class/dmi/id/ to the user space nowadays.

	My idea is to add 'DMI:sysfs' ctl info component string for the appropriate 
ASoC driver to detect the existence of this dmi interface. Then I can add the 
sysfs support to the ucm2 conditions.

	But it's really a quick idea. I'd like to have comments.

				Thank you,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
