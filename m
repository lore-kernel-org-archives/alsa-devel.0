Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF66C624DE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:04:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28A7960203;
	Fri,  4 Sep 2026 09:04:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28A7960203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788505495;
	bh=m8Vq14wjGEle04nPXsdB4QEY1+8wvsxldq81mjFlg2c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=erVMUtQyJa/WlxerqUWfS7TT6Em3M9QqUVM8g1rZ+Lk9ftVrry5OwbUtrfTtL0y7a
	 R1Q9c++z9sh8knHO2fv/fzn3GGdf27Vn9faI6aaDO2W3/ZNK+o2mA6upnoCMtfJBNz
	 yDgjJybosDHmhxn1FFHdji79W8gEslrnG5rY1gaE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7033EF805FA; Fri,  4 Sep 2026 09:04:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3105F805FC;
	Fri,  4 Sep 2026 09:04:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26B5EF8049C; Fri,  4 Sep 2026 09:04:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788505450;
	b=XBfn404/xa26D7hDw/OHIzywppzW0Ck1AqdGoM2TE/FJxI8swE+d08TkJvyTMefd8Rp2
	 Z0g0W4wRiZpRmmV8fsBYZb3yZkD1dNWlF9QzK3Xgz235ZlOSbMQNHV7+x6t9p/+oV3Dkw
	 aAJHHYTfRuEGM/w1fJzJjQ+rDF3sN0HghMGh0eNyffBVerZFDTKUWxiz2swGHZHswn/ys
	 jmPXuvtjn4awv2Gp/HPNwlTyTtHWHkX56sLoAhTpdXA5AfjmVRi863EUsNw8deg1l5A+m
	 VHtM+mZDYfg9YOlArPpbcwIde3xWnhAwK0J33HO/fd3ih6otj+Bd4K+d73aGhFnAU7g==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788505450;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m8Vq14wjGEle04nPXsdB4QEY1+8wvsxldq81mjFlg2c=;
	b=mZ0Qb479Cat8L61XzIbzXoMjoY1I+jd3Lvsv4+NgUMfx0r7/mln44INdHohqibmmks/K
	 uKoLrdjN1yoBVYjex2Ct4yS5jAccGmD/WIg4kxfcf54/AiZlZt16AHAxLUg86G8t6h4Yf
	 wmSVObUWXYcV1JnJX3hrEEd2SYJXlLAZViruDvw+afMO/IEXCi/XrrlSBa8SMYiVG8U3E
	 m5wz2twL8mtyHqjMZeGmquqYY1Vz2NwcYgdAouHheh8BEpqDW7mE7AGvUZ0OlxuZQFHNM
	 uFXQX4aF8AztsnJrLZVXYVmtkN3yvrjZwShTpC1JwBYQC75xDWG2Pj3fXeRaVpM0UEg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hSVw5txk;
	arc=none smtp.remote-ip=172.234.252.31
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C01FDF8027B
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 09:04:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C01FDF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=hSVw5txk
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DBA4640F32;
	Fri,  4 Sep 2026 07:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818231F00A3D;
	Fri,  4 Sep 2026 07:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788505445;
	bh=iBXF5v1VOSzvxor8PqmVy7xN/iYE8cXe4jVbYbzgvRg=;
	h=From:To:Cc:Subject:Date;
	b=hSVw5txkdUb6t10+1fBJEidf3szXKlD/yKG7dT2Yi8chQzFdZW6c8w0EzXCuZprUh
	 ugfcnZKsfYu9IxxEP3iS4QfJ0+Mg8sHvBn0DLgcxTSOd2ciViKG02KPyizGCaSaCa4
	 5zoBZkBu18MROvb2MxlPPtHbXJOtyV71euyieULA4wsihrx3F+XR7vSlQGkfm/VzgF
	 rDdkAMJDzKXJ+V7ifL9s+NyBvFtuVX2V0YnJRB71dIGxlI+O5znRBqBe4U/8uNKnPf
	 tJbZFWoKTfjXu+uuBILtxJfTLGQnaVGNz0MH0siz9SHUZz/VlWwe8KHmxbflNP0H4o
	 O9/3AL/gXSBEw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: tzungbi@kernel.org,
	alsa-devel@alsa-project.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1.y] ALSA: seq: Fix port lock leak in
 deliver_to_subscribers()
Date: Fri,  4 Sep 2026 07:03:49 +0000
Message-ID: <20260904070349.80497-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AXHP7DXH4G5CD5MT7XA2ZBBIHPXO5MOL
X-Message-ID-Hash: AXHP7DXH4G5CD5MT7XA2ZBBIHPXO5MOL
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AXHP7DXH4G5CD5MT7XA2ZBBIHPXO5MOL/>
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

Fixes: d7e2ce72833b ("ALSA: seq: Add UMP support")
Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 sound/core/seq/seq_clientmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 9b82fccd959c..37930d74e394 100644
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

