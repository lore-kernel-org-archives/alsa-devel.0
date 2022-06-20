Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D836C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 11:58:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B6D61906;
	Mon, 20 Jun 2022 13:57:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B6D61906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655726329;
	bh=Az5ZJVMflNgvYw5qO8iOVQ0jp16GeLI4VTIHcWDeWyY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b7NtB7WFToikdJ6fEmDkPBoAGJnffu4hPLevJv/nSEhju6+B8Ie10nF1guNwF6Gz+
	 Dsr6VCKINpBbPBSIYyGtPbFZtGw+UN+PxQ4FC6rsYcZk9tDVe4MQfS/V3c9XSPVQtM
	 bQrCoCB6ztqJazWynFjIQ4m9s3qZTdbkIcmo6b60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01E2EF804CF;
	Mon, 20 Jun 2022 13:57:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A625F800FB; Mon, 20 Jun 2022 13:57:56 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 75ECCF800FB
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 13:57:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75ECCF800FB
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1655726269741192102-webhooks-bot@alsa-project.org>
References: <1655726269741192102-webhooks-bot@alsa-project.org>
Subject: No sound on main speaker : Zenbook UX3402/ALC294/Fedora 36
Message-Id: <20220620115756.8A625F800FB@alsa1.perex.cz>
Date: Mon, 20 Jun 2022 13:57:56 +0200 (CEST)
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

alsa-project/alsa-ucm-conf issue #174 was opened from hereblur:

My laptop has no sound on main speakers. 3.5mm jack and bluetooth  is working fine. 

Asus Zenbook UX3402
ALC294
Fedora 36

Here is my `alsaucm -c hw:0 dump text` and `alsa-info.sh` output

[https://paste.debian.net/1244631/](https://paste.debian.net/1244631/)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/174
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
