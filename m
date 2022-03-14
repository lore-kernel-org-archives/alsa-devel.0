Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB804C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Mar 2022 00:11:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1310316A2;
	Mon, 14 Mar 2022 01:11:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1310316A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1647216710;
	bh=xUYs/BzvyWWFZdilJKX+4nDMKP2LjDNmh58ErHGR+y8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dc4hnYqSid6j+QwZZNMHu69qD7mduO1AoycLeoYHkFH5lvjJKmdQlgxfcPUtRKR6Z
	 iZCx9Mgua0UY4KmRq1Hmny6LUoHDMVV6Kjvi3NsKgStR2o8y/DV2oUwrUbHqZzO05Y
	 jMnf/2mLtu1emkK7Jd59WA/u3dtIoXsyVi486Cqg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 99562F80165;
	Mon, 14 Mar 2022 01:10:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 754D4F80310; Mon, 14 Mar 2022 01:10:57 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9EBFCF8011C
 for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2022 01:10:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9EBFCF8011C
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1647216653874943972-webhooks-bot@alsa-project.org>
References: <1647216653874943972-webhooks-bot@alsa-project.org>
Subject: USB audio not detected with kernels 5.15.02 and 5.16.0;
 snd_usb_audio and snd_usbmidi_lib not loaded.
Message-Id: <20220314001057.754D4F80310@alsa1.perex.cz>
Date: Mon, 14 Mar 2022 01:10:57 +0100 (CET)
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

alsa-project/alsa-lib issue #216 was opened from stevesr0:

System running antiX linux Sid version (based on antiX-19).

Using Pipewire on top of ALSA, both internal card and usb headset detected and play with kernel 5.10.88 (antiX nosystemd kernel).

With Debian 5.15.5 and 5.16.0 kernels, the usb card is not noted in aplay -l or with /proc/asound/cards.

Comparison of loaded modules for working kernel and non working kernel: 
      --Working kernel has both snd_usb_audio and snd_usbmidi_lib loaded.
      --Non working kernel has NEITHER of these.  Instead usbcore and usb_common are loaded.

I am seeking advice about fixing the nonworking kernels.  Not sure if this is a bug in the kernels, but both nonworking kernels have identical outputs in /proc/asound/cards and pactl list cards.

Thanks.

Happy to provide files as suggested; not sure what data would be useful.

Steve Rinsler

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/216
Repository URL: https://github.com/alsa-project/alsa-lib
