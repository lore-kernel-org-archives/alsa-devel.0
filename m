Return-Path: <SRS0=Yvqk=7V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9549C433DF
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:07:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44BD3206D5
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="mgo4c02u";
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="AND0CpYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44BD3206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rere.qmqm.pl
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE5FB15E2;
	Mon,  8 Jun 2020 12:06:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE5FB15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591610852;
	bh=CDrLC2kySs5OBNJvqoPu46VZEBqI3bBc1GI8m0d56kY=;
	h=Date:In-Reply-To:References:From:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mgo4c02uDGqIp1EBL14fdj+zIqZ0xytZhzhzZR0cKkWUHzh4v4IfpeULWvIPqM56y
	 II6sA8H1zUmFn5PMf9q4UQXjxYTOAlR3pKiZVSamY1HJ8ouoaxWqRRjuoznksDMDpl
	 zBwdc12Kq2k3z06kjehTWmVlcoEz4fJbFV+wlc4s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A549F801F7;
	Mon,  8 Jun 2020 12:06:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72E02F8024A; Mon,  8 Jun 2020 12:06:40 +0200 (CEST)
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 793FEF801F7
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2020 12:06:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 793FEF801F7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl
 header.b="AND0CpYe"
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with ESMTPSA id 49gTRs19bxzY4;
 Mon,  8 Jun 2020 12:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1591610793; bh=CDrLC2kySs5OBNJvqoPu46VZEBqI3bBc1GI8m0d56kY=;
 h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
 b=AND0CpYeEW677MDFgvTIx8zReIBMkD6olRKBzvkZOdeyRXBwmQTvOWiGG/iBeA7BS
 yX8DP+UguZnDbIuxjkyajal9FqWaBgxqph/knGrmulPBWffp38IYQXNa+8Eyrs2QOT
 NiAbq3Jsu+A9w3670L59ZP33sK2Y5CnpiPZoXyAvuu7GA6GsqC2v8qltNdO1cKlkzr
 bKsQ2v33ERBu5+zVjsyp6hZpSvWcgm4Y5pfZ3Z0EfC2ez9HSTQWz+dlBAfx0wsfHGb
 a401+jf5+fn4MHv3268WB6TYdDLlI5e07znuu+kblHpbo7wWoBxUFw9sPNHXyvC948
 w4BOzftnZDgNQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date: Mon, 08 Jun 2020 12:06:32 +0200
Message-Id: <37252c65941e58473b1219ca9fab03d48f47e3e3.1591610330.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
References: <cover.1591610329.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] ALSA: pcm: fix snd_pcm_link() lockdep splat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

Add and use snd_pcm_stream_lock_nested() in snd_pcm_link/unlink
implementation.  The code is fine, but generates a lockdep complaint:

============================================
WARNING: possible recursive locking detected
5.7.1mq+ #381 Tainted: G           O
--------------------------------------------
pulseaudio/4180 is trying to acquire lock:
ffff888402d6f508 (&group->lock){-...}-{2:2}, at: snd_pcm_common_ioctl+0xda8/0xee0 [snd_pcm]

but task is already holding lock:
ffff8883f7a8cf18 (&group->lock){-...}-{2:2}, at: snd_pcm_common_ioctl+0xe4e/0xee0 [snd_pcm]

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&group->lock);
  lock(&group->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by pulseaudio/4180:
 #0: ffffffffa1a05190 (snd_pcm_link_rwsem){++++}-{3:3}, at: snd_pcm_common_ioctl+0xca0/0xee0 [snd_pcm]
 #1: ffff8883f7a8cf18 (&group->lock){-...}-{2:2}, at: snd_pcm_common_ioctl+0xe4e/0xee0 [snd_pcm]
[...]

Cc: stable@vger.kernel.org
Fixes: f57f3df03a8e ("ALSA: pcm: More fine-grained PCM link locking")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 sound/core/pcm_native.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 3ad399cb6f30..5b36881f7095 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -138,6 +138,16 @@ void snd_pcm_stream_lock_irq(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock_irq);
 
+static void snd_pcm_stream_lock_nested(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_group *group = &substream->self_group;
+
+	if (substream->pcm->nonatomic)
+		mutex_lock_nested(&group->mutex, SINGLE_DEPTH_NESTING);
+	else
+		spin_lock_nested(&group->lock, SINGLE_DEPTH_NESTING);
+}
+
 /**
  * snd_pcm_stream_unlock_irq - Unlock the PCM stream
  * @substream: PCM substream
@@ -2200,7 +2210,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 	snd_pcm_stream_unlock_irq(substream);
 
 	snd_pcm_group_lock_irq(target_group, nonatomic);
-	snd_pcm_stream_lock(substream1);
+	snd_pcm_stream_lock_nested(substream1);
 	snd_pcm_group_assign(substream1, target_group);
 	refcount_inc(&target_group->refs);
 	snd_pcm_stream_unlock(substream1);
@@ -2216,7 +2226,7 @@ static int snd_pcm_link(struct snd_pcm_substream *substream, int fd)
 
 static void relink_to_local(struct snd_pcm_substream *substream)
 {
-	snd_pcm_stream_lock(substream);
+	snd_pcm_stream_lock_nested(substream);
 	snd_pcm_group_assign(substream, &substream->self_group);
 	snd_pcm_stream_unlock(substream);
 }
-- 
2.20.1

