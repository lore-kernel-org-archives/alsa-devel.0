Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133E5C3F2D1
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:27:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9368521739
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 15:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n9uIhk2p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="QqKvq68y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9368521739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=perex.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D22731655;
	Wed,  4 Mar 2020 16:26:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D22731655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583335620;
	bh=9rXQvKAQVTQNiz8aLIx1L4CJNnzKfuj0cKZPeiF7ASI=;
	h=To:From:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n9uIhk2pZlz/8SF53rJv/YjUgpWao8ocjHY7czCfeORfQHaIg+YsHBG5ozZePqJKK
	 aokmKRdFcP1O8o5aXfmOnNDpb7V0LpFG1H7kRCZbv1+YTGjqInphEK4QxBoEixjDM9
	 Y+Judr0RvbgLfvKXMOZTqW4+MKVN/EyNjvYxqMII=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58E72F801EC;
	Wed,  4 Mar 2020 16:26:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BB61AF801ED; Wed,  4 Mar 2020 16:26:08 +0100 (CET)
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CB6F9F8012D
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 16:26:04 +0100 (CET)
Received: from mail1.perex.cz (localhost [127.0.0.1])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 4A606A003F;
 Wed,  4 Mar 2020 16:26:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 4A606A003F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
 t=1583335561; bh=fxtx+XqNIX08h6ygcDl8/zsAP2qz/FDotYgnmDnXe8Q=;
 h=To:Cc:From:Subject:Date:From;
 b=QqKvq68ypRbWiXJ0nKIEjxfek+EKnuAiKDSfJG9UehcMt6vqCrSVRCyPy7cohOdRu
 DMzOie2rV6amQfdJoLSY8VypML4tk3EQ9MgwUMnnvDnOhHexNB4kaeX5wUUsOqa/GP
 tVpvW5hzGDNojrpw7X1Pmya7o4JPJrF/7N4o8BmE=
Received: from p50.perex-int.cz (unknown [192.168.100.94])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: perex)
 by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
 Wed,  4 Mar 2020 16:25:55 +0100 (CET)
To: stable@vger.kernel.org
From: Jaroslav Kysela <perex@perex.cz>
Subject: 5.5.y - apply "ASoC: intel/skl/hda - export number of digital
 microphones via control components"
Message-ID: <147efa37-eb57-7f17-b9eb-84a9fe5ad475@perex.cz>
Date: Wed, 4 Mar 2020 16:25:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Sasha Levin <sashal@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 ALSA development <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
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

   could we cherry-pick patch 8cd9956f61c65022209ce6d1e55ed12aea12357d to the 
5.5 stable tree?

8cd9956f61c65022209ce6d1e55ed12aea12357d :
  "ASoC: intel/skl/hda - export number of digital microphones via control 
components"

   Rerefences:

https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/817

				Thank you,
					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
