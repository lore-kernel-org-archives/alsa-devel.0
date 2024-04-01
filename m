Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133B9CD1288
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Apr 2024 10:10:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4570C227E;
	Mon,  1 Apr 2024 12:10:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4570C227E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711966232;
	bh=Y25qGKh1Kh1VRLsyyRo5Clgw0Oj//q0xuohdKfr9hHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I90phEuHG5mJ7sjrVFQmkPrZFr564jDAo2lJQNPUTPlY0D+nKvh7BrPAZODixY1DV
	 VVi3CEdMWSQ8zh5f9u4jPzqzOMsgJcTaW2t2Ckvbx/wyBnAnDwotHjAhYaYuw9u8VK
	 3s9GP3xwA5G5uFUccyfLBymV31yiTLmalWq4EIIc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29605F805A1; Mon,  1 Apr 2024 12:09:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6841EF805AA;
	Mon,  1 Apr 2024 12:09:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E9C0AF8057D; Mon,  1 Apr 2024 12:09:01 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 406FEF80568
	for <alsa-devel@alsa-project.org>; Mon,  1 Apr 2024 12:07:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 406FEF80568
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=YGQptbZY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711966063; x=1712570863;
	i=oswald.buddenhagen@gmx.de;
	bh=YhQPRxRn3axvs5eoP6C+dAAGrMyhTu4iH/cIsd1W9zo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=YGQptbZYBMBpYAV3nyrQDr5aB1hzfYYl+hzNGn2Ew9F23i2/Ntt2obycwybjQl66
	 PP8C7P5Mp6qjiaeLAhD9FKegeX/SvT2cqva8RVB6I6/6puZonKp+5PIzO/pnv1OxD
	 vX029CHSGS9o4TkMXIlDd1ptp4W9tlwgewSciOxV17cnxQ8/Sw4PwNmXw5g3n1/Kf
	 DTtWYx9rVch8w+jAOEb6L6Wp6l6R/TV4wPz7nFzvraaGO/XiDnlmRoPPwcrHENX+c
	 uqG0zjpYmnJZFqfMf2FQhZ0uvyJjh0E3BxjpeWjXHkmRI5cBj+1fO7xMDsRPemiRy
	 cUlU6Y2ztmvGfUInPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.100]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8GMq-1svDGJ0pk0-0149Lb; Mon, 01
 Apr 2024 12:07:43 +0200
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rrEZq-7dz-00; Mon, 01 Apr 2024 12:07:42 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Subject: [PATCH 03/18] ALSA: emux: fix validation of snd_emux.num_ports
Date: Mon,  1 Apr 2024 12:07:27 +0200
Message-ID: <20240401100742.506001-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <20240401100742.506001-1-oswald.buddenhagen@gmx.de>
References: <20240401100742.506001-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jObIqgvKZ7AroiwqCzdjtcn21fxyqFAWtjTPaHUtl7+AjQjHLji
 Ml9nhVZ20JvUX/a6Y00fssN231cehJJUyXr7z+365gVT/mL/uhg/094DMC9sUIAZ5xZMxwp
 skCH07T7J399UF0jqVSAqYPae/XmiUL59iv//7mHJV+oD1TB30xDtu+Ltb6q/NbAOvUX1AO
 DbJ1YuG0DAvDXrIfzaQ1A==
UI-OutboundReport: notjunk:1;M01:P0:7vW0BtHI/dQ=;buIzqvy5FznymgyQnFYya9eKHFL
 EaMiWSpRo69IdGMMHpGHD8LNK3+zyYjv4DhNoMlbt8AS5zYvT7roQEcl2pgdw1yOUrSLoKzwi
 oaBJ07/U7JINPYxv2BZ7p3KNtVypyItoOWA9QUal/mVNBLeAchOjxlx30ZkHGrDi6Fnwu+qf5
 ghXjKPxaFIZ86Cg8Db4ZPFHQ3/Ox4u/Sxq+oCEGlH4DPbfRP9L2pqQDzOsYmaOA1W9jnMlvgS
 I/kSsqopee6j6BNrrwBbKq0V24QY4u7jz+MkQu1Vz3KtlPMiUQePDRdf6jfG4f2LFI6HuUHdh
 YyV5L3MxPmdr4t6VVYYJmq7QMd2iKuHMd7DuOYtMbel96X44LnQnFblhG68NZ8QLxOpgIi3nO
 1mW7CWRqBuqMZIJHH/kHfJ9/izICyMjgc/aMW7Zzt0QYwFlC1BMlEXM7HPY52UyJe+5hLBTDL
 JQDUOwWqKUmvXA5siI71PlT5dC6AtFDKfKLWQ2L9m+K/hIXVeyK5t5cPboCic72K7T3UPNX52
 YVvfCLKjwO/Nmx5we48zzDGOlHWKAwHGcK7M6SEHxFVWJ+2unaTdAjC8VzE5iV6XAABR73ZSt
 rLfsFL0HFcDgjp/MVvfgCpIVzxfph7XlyhCtWVSPiwvBJqYpGL9I2zrRfuM4XmG20/mmTbqjr
 GoBf9ObOhaMczqg2Cv5e0bd5/8sFv8w2ZnAvzn+AEpzazpMhHwaCZUCzQA7TVg3R2IPaQniHl
 6wOgTUNduSImhPIFZVyYIKMZSTaKnVABvqtvEeKYsh9UIGsMfmjlAQ6/iq0lbjIzlX1Lxwhn8
 RrXHr/KsECVg1sfDg4voMe5s6JHvMi8M5N4w5dg2N27Ks=
Message-ID-Hash: TBYJRTEZLH52NRHS5AYWJ3SS557QKE2D
X-Message-ID-Hash: TBYJRTEZLH52NRHS5AYWJ3SS557QKE2D
X-MailFrom: oswald.buddenhagen@gmx.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TBYJRTEZLH52NRHS5AYWJ3SS557QKE2D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Both bounds had off-by-one errors.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
=2D--
 sound/synth/emux/emux_seq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/synth/emux/emux_seq.c b/sound/synth/emux/emux_seq.c
index b227c7e0bc2a..1adaa75df2f6 100644
=2D-- a/sound/synth/emux/emux_seq.c
+++ b/sound/synth/emux/emux_seq.c
@@ -65,11 +65,11 @@ snd_emux_init_seq(struct snd_emux *emu, struct snd_car=
d *card, int index)
 		return -ENODEV;
 	}

-	if (emu->num_ports < 0) {
+	if (emu->num_ports <=3D 0) {
 		snd_printk(KERN_WARNING "seqports must be greater than zero\n");
 		emu->num_ports =3D 1;
-	} else if (emu->num_ports >=3D SNDRV_EMUX_MAX_PORTS) {
-		snd_printk(KERN_WARNING "too many ports."
+	} else if (emu->num_ports > SNDRV_EMUX_MAX_PORTS) {
+		snd_printk(KERN_WARNING "too many ports. "
 			   "limited max. ports %d\n", SNDRV_EMUX_MAX_PORTS);
 		emu->num_ports =3D SNDRV_EMUX_MAX_PORTS;
 	}
=2D-
2.42.0.419.g70bf8a5751

