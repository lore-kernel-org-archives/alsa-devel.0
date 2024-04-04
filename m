Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447C5CD1292
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Apr 2024 10:03:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33ADE2C70;
	Thu,  4 Apr 2024 12:02:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33ADE2C70
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1712224980;
	bh=Y25qGKh1Kh1VRLsyyRo5Clgw0Oj//q0xuohdKfr9hHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HH0Gh90eulhH3Zp8ABCNeiGi57mPB4gKfvXJ+F1/ykzUl3FStALmDz0Kx6qGG/9v6
	 NY1ue5AZv8wBixwL3X3dqQb7XTeC79MeC65UoEEu3C8DeQtzvHvCxkMvzQAzhuoNnr
	 JwmVxaLix0bz7CME0C4OkXDNm0IU80X7uYHUYsuQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FCF3F805B3; Thu,  4 Apr 2024 12:02:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6D87F805D5;
	Thu,  4 Apr 2024 12:02:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0396F80578; Thu,  4 Apr 2024 12:01:06 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 57BADF80114
	for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2024 12:00:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 57BADF80114
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=JmZQoUwV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1712224852; x=1712829652;
	i=oswald.buddenhagen@gmx.de;
	bh=YhQPRxRn3axvs5eoP6C+dAAGrMyhTu4iH/cIsd1W9zo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=JmZQoUwVNq9aDMvNrbqeRtEHOvb8UCI7xgm+cJRUIFj/eXpSuIoM8EYGkdGvvusx
	 1JaYG5w/aAgJwUxckivZq3QYXnSXOiceXRGbx87PLc2idsBBS9DdVIfBVfjeP87lI
	 qoShQJ8a1RJwP0dLeGVCfO2+eL6km52QlNMCo7dmfMGM7HmqU+7C/xEBoMoh850Ym
	 84CdsyIip6p3vCbCZOocKWMaRmm4ag+Wx5+OBjtO0Y+fxkFNTy7XRukxhTV+7nzHQ
	 yH0PMvLsbrD2fOhV8f/w5BDE2yae7t7F43MqKf7iNn89fI316BHzStZ1rd9RNcD/V
	 jABPirg53G9ic1jBvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.126]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrQEn-1sdQpT3MIR-00oUbU; Thu, 04
 Apr 2024 12:00:51 +0200
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1rsJto-RFD-00; Thu, 04 Apr 2024 12:00:48 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Subject: [PATCH v2 03/17] ALSA: emux: fix validation of snd_emux.num_ports
Date: Thu,  4 Apr 2024 12:00:34 +0200
Message-ID: <20240404100048.819674-4-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <20240404100048.819674-1-oswald.buddenhagen@gmx.de>
References: <20240404100048.819674-1-oswald.buddenhagen@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ofl7FRD9w5YwtxG2PkkRrgGEivTzakky3Nzp3n22Gug5BtoijAX
 pDia57PTqgLPCysnUAtWCKYKKlNb2XefIBpmnarUj+GCxIeFMwyk3w/YKe6uaapcz7gQjWf
 tu5bG0fy7xI8eV11suMSHaEhusOzhOJo8JUJVy6Li7p/ij2qhzb4XmODyqgfvxKGezmki6T
 xe85VKQYEDXVUPO0mqtKQ==
UI-OutboundReport: notjunk:1;M01:P0:3W9YbSAhzqQ=;nryRaPlu7frZjWpJ79LKpVnt6L4
 cgUwAdA/Q/OxMamKlC+YYf9WG2qds/W0jrv6CgKTB4r4XB6/LArsRxPbyHui+5IPoIiVbel8o
 ufwd4GwmwNjcWsm6p6PAZxOS/iESIYaWb7BBkYgeW9az3sum8I3nDoF8ZCz6v4B7gzPyERMmG
 xByiTJ7m8PBY8Z8XDLeNUza9/bups1+iq7KHSF3FJT6hZbtE3zKwEWtFVDcpLej+tfaDlyxiB
 nfZofS/1Qq9zQrMQeNfVFZ8Dkt+9lYhkxLY9cihOH7DTzlsRWJwZZEiw0LYwOl4P894k93716
 kf150QAY58gHSpKbTZTuaqhRgIDCTiUTHL9I7UGB8+CanynbO1zwElwibR3E09rpJn3uQLFWs
 V2gPxIqHDmeXle/zTtdx9RSlZf183dW9qqX2MojYMUxiUsBn25PJDcrvTYtF4EbnM4ZIMjCQ0
 IbkvlGhHDQ1YhK+GFwGw2xQWnBb+Ba2bZTWaeJg0bnm7reeJx9pubqsh+ifZoKE8TZaVXUy74
 /PGk8MsMPBQw7o6D7ZssEZwb+tX5haKaSrjMgiEUjIw4H1yxaKCCN2LGK4mRLA7sWfJr1AYa3
 v+IAp0CTwsPoZoYAkLdREqbx+CU+2KZOwBxSAur8G/m339udxx7+TGJ++fovMHN996VZPMkxT
 2HYA8lpOlsp2KV+jX6GoQa0zJiaZZOdFqw4Xef8l5KoDrfca5mCrgAF5WWN6AgQtGQtqEZ72q
 Ba0LQeL4HvbMZhd1gRhUjVKpL4efYLftQ==
Message-ID-Hash: KKFBYRN4GLYONPJIJ7ZAEDJQTKX6GN6I
X-Message-ID-Hash: KKFBYRN4GLYONPJIJ7ZAEDJQTKX6GN6I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KKFBYRN4GLYONPJIJ7ZAEDJQTKX6GN6I/>
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

