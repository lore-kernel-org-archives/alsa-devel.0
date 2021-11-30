Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B35C3C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Nov 2021 14:53:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D730D212B;
	Tue, 30 Nov 2021 15:52:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D730D212B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638284025;
	bh=3xYbkZoidA/SdAusJW58QQS+flHpRnGXxkykZr45L/I=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CEv6IIdwxzPeMAwQmkH+sw3Bf6GRf62iXHpv558BDv1nXLOnjpy/OOqlZi+VyHuRX
	 LnqLLxtDtjLUp8Vrc8OQiUDnnH0+zP1eWT+eFB4QLki0uM2KgRH99WffYkS2afK72L
	 hB4temwqmeRohIk3hW/zAE71+ThvD9iYHZX4+byc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6FAA1F8028D;
	Tue, 30 Nov 2021 15:49:25 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0DDD7F80290; Tue, 30 Nov 2021 15:49:25 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5AF62F8020D
 for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2021 15:49:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5AF62F8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="hHLIkpgD"
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 01FC1B81A21;
 Tue, 30 Nov 2021 14:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC208C53FD3;
 Tue, 30 Nov 2021 14:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283757;
 bh=3xYbkZoidA/SdAusJW58QQS+flHpRnGXxkykZr45L/I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hHLIkpgDpbuCtmAfYqY+aJw2qvSEFto0IZY/Mon9MWpn7MR8HxgzeXPlkwdx7F1lw
 6FVG+XEFodUL46L0hPX4IbXI5O8vRg8mSS7OJ1qQGIWySh8XKIw9XDdXFgMiuijcFA
 5ujEam71zNV4ZLLsdRMhueRbr7ZEbOBYd3pEwg0uG48AAY9LhHsZ3n1WERQQPsh1gD
 jIUoq7i1WNbYQ3NhfoVbJpwiW2dOUMc1kIX9NkL9sBRiDM7kmxdKIQM/iqzChoVCqV
 izot/lqCXrgDzDff9Ql9/TkBCFQ2WUTKAWR8MqOinu5ESEhU+V02ZmO3MOKo61Xzbl
 fGJM2N153djKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 52/68] xen: flag xen_snd_front to be not
 essential for system boot
Date: Tue, 30 Nov 2021 09:46:48 -0500
Message-Id: <20211130144707.944580-52-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130144707.944580-1-sashal@kernel.org>
References: <20211130144707.944580-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Juergen Gross <jgross@suse.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, tiwai@suse.com,
 xen-devel@lists.xenproject.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>
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

From: Juergen Gross <jgross@suse.com>

[ Upstream commit de6da33e6cb79abd4a5721b65b9a7dbed24378f8 ]

The Xen pv sound driver is not essential for booting. Set the respective
flag.

[boris: replace semicolon with comma]

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Link: https://lore.kernel.org/r/20211022064800.14978-6-jgross@suse.com
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/xen/xen_snd_front.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/xen/xen_snd_front.c b/sound/xen/xen_snd_front.c
index 2cb0a19be2b85..4041748c12e51 100644
--- a/sound/xen/xen_snd_front.c
+++ b/sound/xen/xen_snd_front.c
@@ -358,6 +358,7 @@ static struct xenbus_driver xen_driver = {
 	.probe = xen_drv_probe,
 	.remove = xen_drv_remove,
 	.otherend_changed = sndback_changed,
+	.not_essential = true,
 };
 
 static int __init xen_drv_init(void)
-- 
2.33.0

