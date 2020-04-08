Return-Path: <SRS0=n4Uk=5Y=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EB8C2D0EA
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:58:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F0A62082D
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2020 11:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="c94veSJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0A62082D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F1EB85D;
	Wed,  8 Apr 2020 13:57:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F1EB85D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1586347116;
	bh=LoloRUjmacsdJffsK/lHkMlJfFkseAeef5jE68tatSI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c94veSJf1RmGXknqUOZr15ttRGg3ND4SyltJZ/QAfJ50aCVA6kE9TDgqfwaoF9E/9
	 a820RcknDEMFhOs6Dw63y7ItgnWpI2NkE8wPhOkXusgifOBjNXk9fECPTncNnBvGRx
	 qt4rb37/wUgXg7VWH7PX97sRypMme2EQ6yxr+OT4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1FC71F80142;
	Wed,  8 Apr 2020 13:57:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B3A98F80143; Wed,  8 Apr 2020 13:57:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 2EBA0F80105
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2020 13:57:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2EBA0F80105
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1586347057450603962-webhooks-bot@alsa-project.org>
References: <1586347057450603962-webhooks-bot@alsa-project.org>
Subject: Error compiling alsatplg
Message-Id: <20200408115742.B3A98F80143@alsa1.perex.cz>
Date: Wed,  8 Apr 2020 13:57:42 +0200 (CEST)
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

alsa-project/alsa-utils issue #37 was opened from dbaluta:

With latest alsa-lib and alsa-utils sources I cannot compile alsatplg utility.

Steps followed:

# Compile alsa-lib 
1. ./gitcompile --prefix=$HOME/work/sof_dir/alsa-lib-bins/
2. make install #custom instalation to be later used by alsa-utils.

# Compile alsa-utils
1. /gitcompile --with-alsa-inc-prefix=$HOME/work/sof_dir/alsa-lib-bins/include/  --with-alsa-prefix=$HOME/work/sof_dir/alsa-lib-bins/lib
2. I get the following errors:

```
-ldl -lpthread
topology.o: In function `load_topology':
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:135: undefined reference to `snd_tplg_create'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:141: undefined reference to `snd_tplg_load'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:145: undefined reference to `snd_tplg_free'
topology.o: In function `version':
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:63: undefined reference to `snd_tplg_version'
topology.o: In function `dump':
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:218: undefined reference to `snd_tplg_save'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:219: undefined reference to `snd_tplg_free'
topology.o: In function `compile':
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:245: undefined reference to `snd_tplg_build_bin'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:246: undefined reference to `snd_tplg_free'
topology.o: In function `decode':
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:268: undefined reference to `snd_tplg_create'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:273: undefined reference to `snd_tplg_decode'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:281: undefined reference to `snd_tplg_save'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:282: undefined reference to `snd_tplg_free'
/home/nxf25322/work/sof_dir/alsa-utils/topology/topology.c:276: undefined reference to `snd_tplg_free'
collect2: error: ld returned 1 exit status
Makefile:433: recipe for target 'alsatplg' failed

```
Similar with https://github.com/alsa-project/alsa-utils/issues/33

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/37
Repository URL: https://github.com/alsa-project/alsa-utils
