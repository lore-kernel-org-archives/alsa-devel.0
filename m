Return-Path: <SRS0=DopR=5S=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358A7C43331
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:55:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D9E206F8
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="T7Bzr6nF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBH8YNES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D9E206F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C6981679;
	Thu,  2 Apr 2020 20:54:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C6981679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585853745;
	bh=cZyWnj7MJ4YGtBRlooZ5Tf6rEuyW3nWvSF5qDw2F0cU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T7Bzr6nF3+tEg+saAkamqktRiyo9U6lUzADX9R/83tf8iM0kygtcC5AMxX0bJLGtd
	 At/8wZPgowPyMQj1F07U5eZdf0YDIEzh3y1KOt8YixGq7N1WJbKVe0Dh4vkpqX6MA3
	 6pSvNivboy3RTmB5anYhx4A6OwLHOdUO+g+ZTg3M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0320F80264;
	Thu,  2 Apr 2020 20:54:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A0E6F8028F; Thu,  2 Apr 2020 20:54:15 +0200 (CEST)
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 61C11F8028C
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2020 20:54:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61C11F8028C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="jBH8YNES"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585853651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cZyWnj7MJ4YGtBRlooZ5Tf6rEuyW3nWvSF5qDw2F0cU=;
 b=jBH8YNESk7yP6GdXXYitg9dW2U0DY7J38Cys/VZTnLzwDEJbdePFRexdM6irj2Oo/EeVAM
 097Ip7hQH2FKaccDlQR1fDVlm4re7EUcgAe24yMYxJ+KaOcTNX5IeeLUA7KvKW7m6YAtZC
 Vgqp018gj1ewkISlPQIyh4NksT6072M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-ptPiimFPNomp_QQ3rfnAlA-1; Thu, 02 Apr 2020 14:54:09 -0400
X-MC-Unique: ptPiimFPNomp_QQ3rfnAlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0878110CE78A;
 Thu,  2 Apr 2020 18:54:07 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-45.ams2.redhat.com [10.36.112.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F02C21001B28;
 Thu,  2 Apr 2020 18:54:03 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>,
 flove@realtek.com, shumingf@realtek.com,
 Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH 2/3] ASoC: Intel: atom: Check drv->lock is locked in
 sst_fill_and_send_cmd_unlocked
Date: Thu,  2 Apr 2020 20:53:58 +0200
Message-Id: <20200402185359.3424-2-hdegoede@redhat.com>
In-Reply-To: <20200402185359.3424-1-hdegoede@redhat.com>
References: <20200402185359.3424-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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

sst_fill_and_send_cmd_unlocked must be called with the drv->lock mutex
locked already. In the past there have been cases where this was not the
case, add a WARN_ON to check for drv->lock being locked.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/ato=
m/sst-atom-controls.c
index 2c3798034b1d..5bd2c2ec177b 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -50,6 +50,8 @@ static int sst_fill_and_send_cmd_unlocked(struct sst_data=
 *drv,
 {
 =09int ret =3D 0;
=20
+=09WARN_ON(!mutex_is_locked(&drv->lock));
+
 =09ret =3D sst_fill_byte_control(drv, ipc_msg,
 =09=09=09=09block, task_id, pipe_id, len, cmd_data);
 =09if (ret < 0)
--=20
2.26.0

