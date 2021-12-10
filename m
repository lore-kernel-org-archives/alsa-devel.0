Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E055C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Dec 2021 13:36:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A65D1F46;
	Fri, 10 Dec 2021 14:35:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A65D1F46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639143409;
	bh=+la3FfHfnZ4xI0LfWqESGnQlpYCMpIWIStFnv5Ck5SE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FvBBmTBVanl/fhWRld4c3D1vJmDxef/vfyRYgORfkaom0WTkSXqu2ckjkC9Zn7Ymf
	 pckNp++k4hfe+vUHLz6cPmVgyYxrAJ0EEyi+iNWL342aKOUBW8+ktu7eT3hzXWM3sS
	 Ugy3VU/QHkvu6y45j7Rexz9p8ZJi5i3xC8cIL0qo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F409F804E6;
	Fri, 10 Dec 2021 14:35:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BE98F804EC; Fri, 10 Dec 2021 14:35:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9A5C9F804E5
 for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2021 14:35:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A5C9F804E5
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639143353802089930-webhooks-bot@alsa-project.org>
References: <1639143353802089930-webhooks-bot@alsa-project.org>
Subject: Add UCM support for SDM845 based Lenovo yoga c630
Message-Id: <20211210133557.2BE98F804EC@alsa1.perex.cz>
Date: Fri, 10 Dec 2021 14:35:57 +0100 (CET)
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

alsa-project/alsa-ucm-conf pull request #88 was edited from Srinivas-Kandagatla:

One of the Lenovo YOGA C360 variant is based off Qualcomm SDM845  SoC. This PR adds support to On Board Speakers and Headset. 
This PR also has a small change to the codec Headphone sequences to be inline with other Sequences.

thanks,
srini

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/88
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/88.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
