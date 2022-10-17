Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B215C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 17 Oct 2022 18:37:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 470028683;
	Mon, 17 Oct 2022 20:36:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 470028683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666031861;
	bh=DvISbfS+hNL0OeZ4Z7A9YgJPC2YrHx5SRn04hy5l66s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rNf0bu06ZdQYx1zMTYG/gwX0utOE5/ThFw1jt4jfMqTAJ1AcGEOkCRTBL8DnSTn7n
	 TMmBQMUPFftizwgbBmYkGe1DRL5pY89k6TPzluLZxpodWFQh2Hp3IlupnhRD7RT3H0
	 phtErjxJkHix11kkYduCwUWFt1jwWZCdAZDDH0DM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED4BBF8025A;
	Mon, 17 Oct 2022 20:36:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 35B09F8025E; Mon, 17 Oct 2022 20:36:49 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id B2E58F80149
 for <alsa-devel@alsa-project.org>; Mon, 17 Oct 2022 20:36:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2E58F80149
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1666031805928993940-webhooks-bot@alsa-project.org>
References: <1666031805928993940-webhooks-bot@alsa-project.org>
Subject: controlC1 no longer show up after USBDEVFS_DISCONNECT
Message-Id: <20221017183649.35B09F8025E@alsa1.perex.cz>
Date: Mon, 17 Oct 2022 20:36:49 +0200 (CEST)
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

alsa-project/alsa-lib issue #276 was opened from robertwu1:

After running the following IOCTL on some MIDI devices, the control C1 device node is gone.

~~~
struct usbdevfs_ioctl ctl;

ctl.ifno = interface; // MIDI interface
ctl.ioctl_code = USBDEVFS_DISCONNECT;
ctl.data = NULL;
return ioctl(device->fd, USBDEVFS_IOCTL, &ctl);
~~~

Under /dev/snd, the following disappears: controlC1, midiC1D0, pcmC1D0c, pcmC1D0p.

MidiControl, AudioStreaming, and AudioControl are under separate interfaces. If some of these were to disappear, I expect only midiC1D0 to disappear.

I've tested the following devices:

/dev/snd looks the same after USBDEVFS_DISCONNECT: PreSonus AudioBox 96, Alesis iO4, Komplete Audio 6.

controlC1, midiC1D0, pcmC1D0c, pcmC1D0p are gone: PreSonus Studio 26c, Yamaha AG06.

Here is a public Android bug of users having issues of this on Android: https://issuetracker.google.com/issues/251050530

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/276
Repository URL: https://github.com/alsa-project/alsa-lib
