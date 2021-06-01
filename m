Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B6DC47083
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:26:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD67610A1
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 14:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD67610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8A0516FF;
	Wed,  2 Jun 2021 16:25:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8A0516FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622643974;
	bh=MzlARME4PT7gZfBfOUguUEgshh64veA8ys2s2SbHRfM=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cl7IkFTNU58BR42uMgpXMT8KFKkWRYG1ZEYZvRcYFdDMgAbA1YVC6AHL9S1iZVuvP
	 2NCYrtbjpofxdKCmT/qv6abVrF0tPFahjlHz7wf9KHP89v48an+f5UWeN54Yi6KwAQ
	 6Gxz9qkvXt6BgtYIYTmxabnuxxxT/J7MsGw3BGQI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E168DF804D1;
	Wed,  2 Jun 2021 16:23:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45973F80254; Tue,  1 Jun 2021 11:31:14 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 98514F801DB
 for <alsa-devel@alsa-project.org>; Tue,  1 Jun 2021 11:31:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98514F801DB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="AGqWFUsJ"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6798C60233;
 Tue,  1 Jun 2021 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622539858;
 bh=MzlARME4PT7gZfBfOUguUEgshh64veA8ys2s2SbHRfM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=AGqWFUsJLkcVJZ4LIwG+zPi8RAXRzCZp6K3epM0/Vl7+RdYvCfNrdUu0tXtpBv1HU
 aEjLQMpLDljY3rnnuyLcEqTJpteSYW0J228pFQqE2Wer5K8NVY13c+E4qejYPmn0wZ
 ErR45tsnWiSJH+ZaBDbmgklFcvUBZK5XT3vZYtz0pa/Uq4L++Rf3byso6RBYtg8DhN
 dq17CLatmOoBmLgpSTpr+h3Ghi/6QulAf5+Mu1xrIDvH21ZEQHj8JrnpwJgtLYNEej
 b5Aegteov9mIPeQq0ZD/1m+4anggbpDae5h9ASMFMZk2ux4vG7fjWOIJHMiYtEtFd0
 Xo6Aydw1MUvOw==
Message-ID: <fac8428765f0ad2fdd49407b9d1187336e8cb618.camel@kernel.org>
Subject: Re: [PATCH v2 11/12] drm/vc4: hdmi: Remove redundant variables
From: nicolas saenz julienne <nsaenz@kernel.org>
To: Maxime Ripard <maxime@cerno.tech>, Jaroslav Kysela <perex@perex.cz>, 
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org, Daniel
 Vetter <daniel.vetter@intel.com>,  David Airlie <airlied@linux.ie>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai
 <tiwai@suse.com>
Date: Tue, 01 Jun 2021 11:30:50 +0200
In-Reply-To: <20210525132354.297468-12-maxime@cerno.tech>
References: <20210525132354.297468-1-maxime@cerno.tech>
 <20210525132354.297468-12-maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 02 Jun 2021 16:23:04 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Dom Cobley <dom@raspberrypi.com>, Tim Gover <tim.gover@raspberrypi.com>,
 linux-doc@vger.kernel.org, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>,
 bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>,
 Phil Elwell <phil@raspberrypi.com>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
 linux-rpi-kernel@lists.infradead.org
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

On Tue, 2021-05-25 at 15:23 +0200, Maxime Ripard wrote:
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Adding a commit message would've been nice. But I guess the patch is trivial
enough.

Other than that:

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

