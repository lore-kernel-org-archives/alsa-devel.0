Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC7AC433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Dec 2021 22:05:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09DE01AD1;
	Thu,  9 Dec 2021 23:04:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09DE01AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639087547;
	bh=16ja2IKOPsfNJhL8W80bhoh4mI9C+Im6AIYwEO4T2aA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y4eVJ+lfU03OxUaPEk4GYaK8T53VHqfYnSmqGO7YcqxkRARwbbn7MhY6IIf2XqeVu
	 9yPsqfERVQEqFR1VpNUTSOsiHF2mOrcVeLc8m0DjNOboCxD43xT4v7Agy81cOVx8eK
	 ETvTRQQqsJzds6K7dDcBq+2xsxAMHKfrJmmBhriI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B1BCF80431;
	Thu,  9 Dec 2021 23:04:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D4F9F804AE; Thu,  9 Dec 2021 23:04:54 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 6D346F8028D
 for <alsa-devel@alsa-project.org>; Thu,  9 Dec 2021 23:04:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D346F8028D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1639087486438345909-webhooks-bot@alsa-project.org>
References: <1639087486438345909-webhooks-bot@alsa-project.org>
Subject: microphone disappeared on alsa-ucm-conf 1.2.6.1
Message-Id: <20211209220454.9D4F9F804AE@alsa1.perex.cz>
Date: Thu,  9 Dec 2021 23:04:54 +0100 (CET)
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

alsa-project/alsa-lib issue #200 was edited from galibozek:

after upgrade alsa-ucm-conf 1.2.5.1-1 to 1.2.6.1-1 (arch linux) my microphone disappeared on lenovo t14 gen2i

Similar to: https://bugs.archlinux.org/task/71180

lspci:
00:1f.3 Audio device: Intel Corporation Tiger Lake-LP Smart Sound Technology Audio Controller (rev 20)

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/200
Repository URL: https://github.com/alsa-project/alsa-lib
