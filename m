Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14AA0C433FE
	for <alsa-devel@archiver.kernel.org>; Tue, 18 Oct 2022 15:27:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D4FAC9F99;
	Tue, 18 Oct 2022 17:26:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D4FAC9F99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666106865;
	bh=r7/pfOWPdnLH1mg7KeSs885/HcR6WaO2U9RHtE1f/R4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k564iWuVaMtnrpFOnyhlrDGx4EyWxbskJd3u24P1u/13F4uEwoecFCZ0CV59lQ0dl
	 ZHSRTVeEzFQTZYUPzFRw5AZ7wZPKLCKsmyfTiTKsH1ZPHQ62UJhROnxw+z1R6Pi15N
	 4VOvow061HdzfINPP8DqagWiCbnlfG6eCIDgVS+U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 83DE5F800E5;
	Tue, 18 Oct 2022 17:26:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3D3D0F8024C; Tue, 18 Oct 2022 17:26:55 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 06D0FF800AB
 for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2022 17:26:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06D0FF800AB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1666106811577478886-webhooks-bot@alsa-project.org>
References: <1666106811577478886-webhooks-bot@alsa-project.org>
Subject: sof-es8336.conf
Message-Id: <20221018152655.3D3D0F8024C@alsa1.perex.cz>
Date: Tue, 18 Oct 2022 17:26:55 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #231 was edited from junocomp:

The only way for the `Headphone Mixer Volume` to be enabled at startup the following commands needs to be added.

`sset Headphone 3`


When adding this to `sof-essx8336.conf` and reload alsa I get the following error

```
sudo alsaucm reload
ALSA lib parser.c:1194:(parse_sequence) error: sequence command 'sset' is ignored
ALSA lib parser.c:1045:(parse_sequence) error: string type is expected for sequence command
ALSA lib parser.c:2289:(parse_controls_boot) Unable to parse BootSequence
ALSA lib main.c:1541:(snd_use_case_mgr_open) error: failed to import hw:0 use case configuration -22
alsaucm: error failed to open sound card hw:0: Invalid argument
```

When running `amixer -c 0 sset Headphone 3` manually it works fine

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/231
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
