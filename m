Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8EC5ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Sep 2022 21:27:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09CA8827;
	Mon, 19 Sep 2022 23:27:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09CA8827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663622875;
	bh=CUjutaUfYMICXNtEUo/heYUtEXYNi5cOyexQn2zZOWI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q2jVRdASAEr14nPAkjWrMawLJ4fs8ttAeh0in92oWzlykxc6/srGlSDoNLPMQOrmW
	 pueHWkfqiGhzgRT+nrImloK2Q7+zWbxN4Dl2sKJRJCnPELe/oHDUMNQdb0DT6qcWgS
	 cebonjKu18sZe/gxyHaoVlOtQ6taihW/YlhbP78Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84CDEF800C9;
	Mon, 19 Sep 2022 23:27:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E40AAF8023A; Mon, 19 Sep 2022 23:27:02 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 4C7C1F800C9
 for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2022 23:26:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C7C1F800C9
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1663622819808568954-webhooks-bot@alsa-project.org>
References: <1663622819808568954-webhooks-bot@alsa-project.org>
Subject: Alsa - has invalid interface number
Message-Id: <20220919212702.E40AAF8023A@alsa1.perex.cz>
Date: Mon, 19 Sep 2022 23:27:02 +0200 (CEST)
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

alsa-project/alsa-lib issue #271 was edited from smangels:

hi,
I'm running the latest ArchLinux installation using a Behringer Flow8 as my main audio interface. Today I'm running into an issue where the USB audio hardware can not be loaded successfully.

```
[ 1690.797522] usb 1-3.1.1.4: new high-speed USB device number 14 using xhci_hcd
[ 1690.891936] usb 1-3.1.1.4: config 1 has an invalid interface number: 7 but max is 5
[ 1690.891940] usb 1-3.1.1.4: config 1 has no interface number 5
[ 1690.892620] usb 1-3.1.1.4: New USB device found, idVendor=1397, idProduct=050d, bcdDevice= 2.10
[ 1690.892624] usb 1-3.1.1.4: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[ 1690.892627] usb 1-3.1.1.4: Product: FLOW 8
[ 1690.892628] usb 1-3.1.1.4: Manufacturer: Behringer
[ 1690.892630] usb 1-3.1.1.4: SerialNumber: 18-04-ED-FB-BE-A0
```
The following Alsa related packages have been upgraded.

```
[2022-09-19T18:22:14+0200] [ALPM] upgraded alsa-card-profiles (1:0.3.57-1 -> 1:0.3.58-1)
[2022-09-19T18:22:15+0200] [ALPM] upgraded pipewire-alsa (1:0.3.57-1 -> 1:0.3.58-1)
[2022-09-19T23:07:36+0200] [PACMAN] Running 'pacman -Sy alsa-tools'
[2022-09-19T23:07:38+0200] [ALPM] installed alsa-tools (1.2.5-1)
```
Kernel and UDEV version
`Linux archlinux 5.19.9-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 15 Sep 2022 16:08:26 +0000 x86_64 GNU/Linux`
`udev version 251`

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/271
Repository URL: https://github.com/alsa-project/alsa-lib
