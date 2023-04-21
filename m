Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3B9C77B75
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Apr 2023 10:54:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06DB2E77;
	Fri, 21 Apr 2023 12:53:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06DB2E77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1682074443;
	bh=nHx7QGgzCoQZcNEx9MiGqRBuSIxS/Of4no3PGY7HMTo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=u/BkVjaDTWhvubbz4OBxPKhD2sBuUiOjXuA/Q+vlXWz3yNNTewwIATW/lJctaGdT7
	 G/VGIK1QRbS3rJNF6fNT0Lx/BGiurW9K33GVG2F+S5wQNUhiNgx1YvL/JDRC7dG/5g
	 wvvIH51dxBp7GWkY1GAQwvV7rh+irqgPty3ELe14=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3612FF80053;
	Fri, 21 Apr 2023 12:52:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2BC1F80155; Fri, 21 Apr 2023 12:52:42 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 31DBFF800F8
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2023 12:52:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31DBFF800F8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1682074356280727386-webhooks-bot@alsa-project.org>
References: <1682074356280727386-webhooks-bot@alsa-project.org>
Subject: DAC not connecting after waking from suspend.
Message-Id: <20230421105242.D2BC1F80155@alsa1.perex.cz>
Date: Fri, 21 Apr 2023 12:52:42 +0200 (CEST)
Message-ID-Hash: E3WYCNAXQ4VK7WV5V42EX6MC3LEC5ZYO
X-Message-ID-Hash: E3WYCNAXQ4VK7WV5V42EX6MC3LEC5ZYO
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E3WYCNAXQ4VK7WV5V42EX6MC3LEC5ZYO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-lib issue #313 was opened from ad-on-is:

A strange issue started happening, with my USB connected DAC (fiio k3). After waking from sleep/suspend the DAC is not recognized anymore, unless I replug it.

```

alsa-lib.i686                                        1.2.8-3.fc38                        @fedora                                            
alsa-lib.x86_64                                      1.2.8-3.fc38                        @anaconda                                          
alsa-sof-firmware.noarch                             2.2.4-3.fc38                        @anaconda                                          
alsa-ucm.noarch                                      1.2.8-3.fc38                        @anaconda                                          
alsa-utils.x86_64                                    1.2.8-2.fc38                        @anaconda                                          
pipewire-alsa.i686                                   0.3.69-1.fc38                       @updates                                           
pipewire-alsa.x86_64                                 0.3.69-1.fc38                       @updates                                           
qemu-audio-alsa.x86_64                               2:7.2.0-6.fc38                      @anaconda                                          
wine-alsa.i686                                       8.5-1.fc38                          @updates                                           
wine-alsa.x86_64                                     8.5-1.fc38                          @updates    

```
```
when it's connected: cat /proc/asound/modules
   1    0 snd_usb_audio
   2    1 snd_hda_intel
   3    2 snd_usb_audio
   4    3 snd_hda_intel
   5    4 snd_usb_audio
   6    5 snd_usb_audio

after wakeup: cat /proc/asound/modules 
   1    0 snd_usb_audio
   2    1 snd_hda_intel
   3    2 snd_usb_audio
   4    3 snd_hda_intel
   5    4 snd_usb_audio
```

If you need any further info, let me know.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/313
Repository URL: https://github.com/alsa-project/alsa-lib
