Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565CBC624DE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:05:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FBA460217;
	Fri,  4 Sep 2026 09:04:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FBA460217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788505507;
	bh=3tUZi3lxjcz/XregwVnnMT850Yc0VvCh330sIoemU6A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=CeotODF8S5owa2YnIiFMIRlBqxQ4+8wxRhMXPAkc4+KxdEKxN2DCJuC3P4WsFv+Ax
	 kUlc/35doha2LL4at43SJJyVLdkfK3V6j3nlONCcM+nhhrHLboxXPaQ4IfyjKxLS0F
	 9CbrsX+ERFcurtGoqp2Bl39B7X1VzPqtLGzgin74=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7722F80618; Fri,  4 Sep 2026 09:04:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E8DDF8061F;
	Fri,  4 Sep 2026 09:04:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13395F80604; Fri,  4 Sep 2026 09:04:24 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788505463;
	b=X0q53vOnBZTn3vqUCN8syCMwO2S6IkeVcbKytSSu+S2c56MQSrzRtp5Pf5P1hoY+IVVg
	 /Zr+kchi0krC7t48pg7N482cjRzpg11xlRBF0jZ2cRwVftkSvvx+GP7CJuljyi7E46z+8
	 VTkC/AOn0dSy+bfj2wyr/y8IgGQNeu3FAgCoafFYKzHylM1S/unXB+IeCpuhAOqNW90DE
	 Lehy+n6jU8goLCZl6fbGif0J4nCGAbEFwBq4SReQq5zk3UD/Kl+5NNjXxNZwS9oJ/wZI6
	 LgejQ8JwxKdiumkSxu33NJXGM32ACUOdlfY15pde59JiuVG3e6cwdMxIPLPkoxiMVhg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788505463;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3tUZi3lxjcz/XregwVnnMT850Yc0VvCh330sIoemU6A=;
	b=HCGz38W7dYZ9y4+Fq9QIr2m6xXWKv0uAwbPz3D5LQfsiJc3MJsS6fBe1wRo5gAd4mF+Y
	 tbuZcdQf2aTMEXmrCjDfT06w1zi8s08q+NAq+RlKiRw9b0gWc+myDdzafTmlOhlpIAex7
	 ujl7gZWOefmKUFZRHNV5JLU8KlpZ1Zj87OKeihHzRR1jQJKm7zylSkYs1AqtIPQa9U/4y
	 576qESzIR4fQ/5DK/zviR7h02k2K352jonTEluEDhQZ2Ht8L5q/PxzFPOz2gNM9iSejPo
	 cQujeCTOrSd7w/LSX5zAMGW3XVmwaMKuU6rAJynhIyrlajO0X61U4CwnD5Vz3FphL2w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=by47bbpr;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 097D7F80600
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 09:04:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 097D7F80600
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=by47bbpr
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C5C9341AB5;
	Fri,  4 Sep 2026 07:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728A81F00A3D;
	Fri,  4 Sep 2026 07:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788505460;
	bh=YawR6a3Oqrj+SrZGCK7xg+xT5B3C2EL27I20IxBfIhU=;
	h=From:To:Cc:Subject:Date;
	b=by47bbprErNXW9cHG8FaePD4+b3qDeK3qDk/sK4ZNundiQNRqXGbMuPaGfRYTR9/E
	 JoMdavWDWJjedPuq3Oo3kjg8Xjou3XHJlUS5p830Bsed3FpzpupSbjpOEPMKUILfoj
	 u55sWxDTkxpAHOCg69EAbrlwRNK5JmOZp48ATYDgcWaBpDGsAuu8zUeqxekUYVOaRM
	 vpUjAUk4fWDg8hKOEyGS955OUtCi1+P6BfXHYTGWoB8pFsSgjPFuALj05O45lalddu
	 S0QCM+SKDsMr/bptGN9hVBEfUgxzwK76/crBd/1Q/0FX8I0OyU7m8BMgmutSfWgovU
	 7mpVcWgSDUyMw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
Date: Fri,  4 Sep 2026 07:04:09 +0000
Message-ID: <20260904070409.80648-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LGUQHMRJBH3PB32OTM7FAA7E57O43YGU
X-Message-ID-Hash: LGUQHMRJBH3PB32OTM7FAA7E57O43YGU
X-MailFrom: tzungbi@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LGUQHMRJBH3PB32OTM7FAA7E57O43YGU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Commit 46397622a3fa ("ALSA: seq: Add UMP support") mistakenly removed
the `snd_seq_port_unlock(src_port)` call in deliver_to_subscribers().
As a result, every time an event is delivered to a subscriber, the
source port's `use_lock` atomic counter is increased but never
decreased.

The leak prevents ALSA sequencer ports from closing cleanly.  When the
client process exits or destroys the port, port_delete() hangs forever
at snd_use_lock_sync().  The process becomes stuck in an unkillable D
state, triggering the following warning:

    ALSA: seq_lock: waiting [1 left] in sound/core/seq/seq_ports.c:250

Restore the missing `snd_seq_port_unlock(src_port)`.

Note that commit 177ccf811df4 ("ALSA: seq: Support MIDI 2.0 UMP Endpoint
port") incidentally resolved this issue upstream when it refactored the
locking logic into a wrapper function.  However, since the commit
introduces a new feature and might not be suitable for stable release
branches, this targeted fix is necessary.

Fixes: 6389f2c13531 ("ALSA: seq: Add UMP support")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index f2feeb97765c..bd2d7a9fab5b 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -733,6 +733,7 @@ static int deliver_to_subscribers(struct snd_seq_client *client,
 		read_unlock(&grp->list_lock);
 	else
 		up_read(&grp->list_mutex);
+	snd_seq_port_unlock(src_port);
 	memcpy(event, &event_saved, saved_size);
 	return (result < 0) ? result : num_ev;
 }
-- 
2.55.0.979.g7e5102b832-goog

