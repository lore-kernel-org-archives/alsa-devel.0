Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70499C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Feb 2022 07:53:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB4D71708;
	Thu,  3 Feb 2022 08:53:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB4D71708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1643874837;
	bh=MZQg0BhQ2X5lyo+vb9hKHTpGuhxDyRTigg6qKvVhiA0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OXYgIzGeaE8h8D4XOQY+adk+oH3HDTeE58cldpHsH/8VgqT7kdN37rwwNsgbomTMI
	 D0BhpPz2hbZydbhpJP1k5wfVQ63L8bR16lttprvizK4tSwscaHfQIoBoACaN1Jt4su
	 0QHiilsFlOg0Wo4pxx2uBAyJvoZC4V6I7cVvQg0o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CE38F80171;
	Thu,  3 Feb 2022 08:53:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07637F8027C; Thu,  3 Feb 2022 08:53:05 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B225CF80163
 for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2022 08:53:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B225CF80163
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1643874782027947903-webhooks-bot@alsa-project.org>
References: <1643874782027947903-webhooks-bot@alsa-project.org>
Subject: `alsatplg` compile error `undefined source widget/stream` and
 `undefined sink widget/stream`
Message-Id: <20220203075305.07637F8027C@alsa1.perex.cz>
Date: Thu,  3 Feb 2022 08:53:05 +0100 (CET)
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

alsa-project/alsa-utils issue #142 was opened from LazyGeniusMan:

Hi, I'm trying to do enable HDA+DMIC in my Kabylake R laptop using a guide[^1]. It's said to compile hda-dsp in  [alsa-topology-conf](https://github.com/alsa-project/alsa-topology-conf), but I got this error:
```
[lazygeniusman@archlinux hda-dsp]$ alsatplg -c skl_hda_dsp_generic-tplg.conf -o skl_hda_dsp_generic-tplg.bin
ALSA lib dapm.c:247:(tplg_build_routes) undefined source widget/stream 'hda-dsp-analog-playback'
ALSA lib dapm.c:247:(tplg_build_routes) undefined source widget/stream 'hda-dsp-digital-playback'
ALSA lib dapm.c:247:(tplg_build_routes) undefined source widget/stream 'hda-dsp-alt-analog-playback'
ALSA lib dapm.c:225:(tplg_build_routes) undefined sink widget/stream 'hda-dsp-audio-analog-capture'
ALSA lib dapm.c:225:(tplg_build_routes) undefined sink widget/stream 'hda-dsp-audio-digital-capture'
ALSA lib dapm.c:225:(tplg_build_routes) undefined sink widget/stream 'hda-dsp-audio-alt-analog-capture'
ALSA lib dapm.c:247:(tplg_build_routes) undefined source widget/stream 'HDMI1 Playback'
ALSA lib dapm.c:247:(tplg_build_routes) undefined source widget/stream 'HDMI2 Playback'
ALSA lib dapm.c:247:(tplg_build_routes) undefined source widget/stream 'HDMI3 Playback'
ALSA lib dapm.c:225:(tplg_build_routes) undefined sink widget/stream 'DMIC-Capture'
Unable to open output file 'skl_hda_dsp_generic-tplg.bin.new': Unknown error -13
```
it's also have same error when I run `make firmware` in the repo root dir

Could someone help me solve it?

[^1]: https://gist.github.com/crojewsk/4e6382bfb0dbfaaf60513174211f29cb#topology

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/142
Repository URL: https://github.com/alsa-project/alsa-utils
