Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A1FC433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 10:42:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 715D41FB3;
	Tue, 30 Nov 2021 11:41:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 715D41FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638268921;
	bh=OvyDFqGcfb14+NhJl8YaPAaT/QVhbo05jVvHVYDkzSQ=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dK9nptaZ87I/6h1hX1SOxdGaI0nGk8ljQhG/vWriKnTzTAqP5EuLOrCixCmvaFafg
	 nj7cGorcqcm9IeSdQ4NcTDNs8VY2dbZYSTc/7AFjDcRH3bxEq32k0AMoptbS7WuFoX
	 ShNz/+z/mObzFi9xP1YYk/sEoODLw/DAoMgLhOn8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F124DF8028D;
	Tue, 30 Nov 2021 11:41:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8FB3F80290; Tue, 30 Nov 2021 11:41:08 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4576EF80113
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 11:41:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4576EF80113
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1638268865471919060-webhooks-bot@alsa-project.org>
References: <1638268865471919060-webhooks-bot@alsa-project.org>
Subject: Channel distortion when converting S16_LE -> S32_LE ('plug' plugin)
Message-Id: <20211130104108.E8FB3F80290@alsa1.perex.cz>
Date: Tue, 30 Nov 2021 11:41:08 +0100 (CET)
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

alsa-project/alsa-lib issue #195 was opened from dh1dm:

When using a Terretec EWX2496 (ICE1712) a sample format conversion
is required in some cases as S32_LE is the only supported format.
This can be done by using the 'plug' plugin (e.g. 'plughw:0,0').
However, the left audio channel is distorted in a varying intensity,
it sounds like a resolution loss in the lower bits.
Applications with native S32_LE support (e.g. Audacity) do not show this
effect.
I'd suppose that the responsible code is in 'alsa-lib/src/pcm/pcm_plug.c',
but up to now I could not track down this issue.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/195
Repository URL: https://github.com/alsa-project/alsa-lib
