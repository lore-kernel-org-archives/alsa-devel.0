Return-Path: <SRS0=75ci=BI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E09C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:13:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697552075D
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 22:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="RENeCIhf";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja3dDLHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697552075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A7EF11724;
	Thu, 30 Jul 2020 00:12:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A7EF11724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596060811;
	bh=uuWR9RWRb4B0cH6RJkoUD/WtjpUMu5kNVDOG1H0bw2A=;
	h=Date:From:To:Subject:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RENeCIhfauvgvAhqi2amZdcjEB5fJuTjYM10Kqguf6BrVAM6/KXnlV2J8XiLCNPlc
	 kSZL36xmd6iHmUFoEZIhcUy9fD6FsEHXvtIzqKw6uy80518/I+nmJFsP6fGOkal6/Z
	 u2PEA6UGcAAWLLNz4hS43KPx+BH9gzWwOfuUuAqE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CA3CF80171;
	Thu, 30 Jul 2020 00:12:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC695F801A3; Thu, 30 Jul 2020 00:12:39 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4EFD0F8012F
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2020 00:12:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4EFD0F8012F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ja3dDLHm"
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62A212075D;
 Wed, 29 Jul 2020 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596060750;
 bh=uuWR9RWRb4B0cH6RJkoUD/WtjpUMu5kNVDOG1H0bw2A=;
 h=Date:From:To:Cc:Subject:From;
 b=ja3dDLHmzZ18TqbJR1kw1hok45YfyoAI24ku9snZTjIk8Jn3IFFUt3ts6co3e8EV/
 0Cq710zV2Hds7hx3wXtFxzEVHGmGyDaZt9iRhRiKZRpWCNAqZ/v+RZMYal8A18ufxO
 b2BU4E8xuNogYO8vdvOpEYRYLYNgiYnQqUQa+55s=
Date: Wed, 29 Jul 2020 17:18:29 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH][next] ALSA: vmaster: Use flex_array_size() helper in memcpy()
Message-ID: <20200729221829.GA10623@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
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

Make use of the flex_array_size() helper to calculate the size of a
flexible array member within an enclosing structure.

This helper offers defense-in-depth against potential integer overflows
and makes it explicitly clear that we are dealing with a flexible array
member.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 sound/core/vmaster.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/vmaster.c b/sound/core/vmaster.c
index ab36f9898711..21ce4082cb5f 100644
--- a/sound/core/vmaster.c
+++ b/sound/core/vmaster.c
@@ -262,7 +262,8 @@ int _snd_ctl_add_follower(struct snd_kcontrol *master,
 		return -ENOMEM;
 	srec->kctl = follower;
 	srec->follower = *follower;
-	memcpy(srec->follower.vd, follower->vd, follower->count * sizeof(*follower->vd));
+	memcpy(srec->follower.vd, follower->vd, flex_array_size(srec, follower.vd,
+								srec->follower.count));
 	srec->master = master_link;
 	srec->flags = flags;
 
-- 
2.27.0

