Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82094C001B0
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 07:23:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B212826;
	Fri, 11 Aug 2023 09:22:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B212826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691738589;
	bh=da54FdS0rtDEYkl03vZtrdhkyVjTb8y9My98MLqX5VY=;
	h=Subject:From:To:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=r3xiXbmPS+k4XZKQyRP2cWrRktWVGXMbqZZYZv90Ld6jAeBPYH8bJRzQvuOomrjwJ
	 MtUqvWpPpQh1yllhWgSbvzbHxK5jaMN24dN7dli6yVFUxQ5pe1qpeR+Fd/5Ic5NA8p
	 0eAAYfQ4EJwMRkE1fZI5bEzV1mKyOUTk6rgGH/p8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5199CF80551; Fri, 11 Aug 2023 09:21:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DDAD3F800EE;
	Fri, 11 Aug 2023 09:21:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4B6CF8016E; Fri, 11 Aug 2023 09:21:44 +0200 (CEST)
Received: from mailman-web.alsa-project.org (mailman-web.alsa-project.org
 [10.254.200.11])
	by alsa1.perex.cz (Postfix) with ESMTP id DCA67F800EE
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 09:21:44 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] -- fix Boss MS-3 midi-usb communication
From: john_candlish@mail.candlish.net
To: alsa-devel@alsa-project.org
Date: Fri, 11 Aug 2023 07:21:44 -0000
Message-ID: 
 <169173850488.20.12963803837559965998@mailman-web.alsa-project.org>
User-Agent: HyperKitty on https://mailman.alsa-project.org/
Message-ID-Hash: JTFOLHU5NNCPNQ4VSAWXIJRD3VXSW26D
X-Message-ID-Hash: JTFOLHU5NNCPNQ4VSAWXIJRD3VXSW26D
X-MailFrom: john_candlish@mail.candlish.net
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SIDDZZ5OCDF2WMOUMCH3OJ6NQVZO5YU7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This one line change gets MIDI communication flowing between ALSA and the Boss MS-3 multi-effect switcher.

/////
*** sound/usb/midi.c    2023-08-10 22:46:31.016346930 +0200
--- sound/usb/midi.c-orig   2023-07-19 16:37:03.000000000 +0200
***************
*** 2106,2113 ****
    struct usb_endpoint_descriptor *epd;
    int i, out_eps = 0, in_eps = 0;

!   if (USB_ID_VENDOR(umidi->usb_id) == 0x0582 &&
!       USB_ID_PRODUCT(umidi->usb_id) != 0x01f5)
        snd_usbmidi_switch_roland_altsetting(umidi);

if (endpoint[0].out_ep || endpoint[0].in_ep)
--- 2106,2112 ----
    struct usb_endpoint_descriptor *epd;
    int i, out_eps = 0, in_eps = 0;

!   if (USB_ID_VENDOR(umidi->usb_id) == 0x0582)
        snd_usbmidi_switch_roland_altsetting(umidi);

if (endpoint[0].out_ep || endpoint[0].in_ep)

/////

There are doubtless other Roland/Boss USB_ID_PRODUCT id's that are effected and it would be nice to make the  USB_ID_PRODUCT value a tunable, but that is beyond my competence.
