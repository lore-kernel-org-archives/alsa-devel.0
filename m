Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B65E71094
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Sep 2023 16:42:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5E687E9D;
	Thu, 21 Sep 2023 18:41:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5E687E9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695314558;
	bh=qDw3Z3ZGntfm7KS2hx62YhHcpq1EVaho9BXN99AIHO0=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=fkW/Gl8OkPaeqErXz3Ewj38dcUSAsxuhjdRD9RRbW6t8OlPjnuUlMegzdUOmuZ09V
	 tzF8ZbYqIgHstFOMHwku/756ut1vY2l/Niqtll/K9wEjsD/A2FauVQtTfon0a6hj5B
	 XMzcllAlfV5nPzLf4D05JTE11ka9j2eFHRh0WE7U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74B62F80558; Thu, 21 Sep 2023 18:41:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 105D9F8025A;
	Thu, 21 Sep 2023 18:41:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07F61F8025A; Thu, 21 Sep 2023 18:41:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 957BFF80124
	for <alsa-devel@alsa-project.org>; Thu, 21 Sep 2023 18:41:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 957BFF80124
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1695314472824420929-webhooks-bot@alsa-project.org>
References: <1695314472824420929-webhooks-bot@alsa-project.org>
Subject: UCM doesn't set mixer for speaker if it fails to set mixer for
 microphones
Message-Id: <20230921164116.07F61F8025A@alsa1.perex.cz>
Date: Thu, 21 Sep 2023 18:41:16 +0200 (CEST)
Message-ID-Hash: SEJHZGP3NVEJF4UM3O3EN2H63QMMEJPN
X-Message-ID-Hash: SEJHZGP3NVEJF4UM3O3EN2H63QMMEJPN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SEJHZGP3NVEJF4UM3O3EN2H63QMMEJPN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #356 was opened from halobarrlets:

I have laptop Dell XPS 17 9720 SKU 0AFE which has microphones and webcam on top of the display connected to motherboard with cable. I need to have webcam and microphones disabled so I've disconnected the cable from motherboard.
Because microphones are disconnected firmware fails to initialize them but speakers are initialized properly.
With pulseaudio disabled and manually setting amixer I can play audio with speakers using aplay:
```
user@user:~$ amixer -c0 cset name='Speaker Switch' 1
numid=38,iface=MIXER,name='Speaker Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
user@user:~$ amixer -c0 cset name='rt1316-1 DAC Switch' 
numid=75,iface=MIXER,name='rt1316-1 DAC Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
user@user:~$ amixer -c0 cset name='rt1316-2 DAC Switch' 1
numid=76,iface=MIXER,name='rt1316-2 DAC Switch'
  ; type=BOOLEAN,access=rw------,values=2
  : values=on,on
user@user:~$ aplay -Dhw:0,2 test.wav
```
But with pulseaudio enabled it fails to load mixer because of missing microphones:
`systemctl --user status pulseaudio`
```
systemd[1160]: Starting pulseaudio.service - Sound Service...
pulseaudio[1176]: Failed to get the verb HiFi
pulseaudio[1176]: No UCM verb is valid for hw:0
pulseaudio[1176]: Unable to load mixer: Invalid argument
systemd[1160]: Started pulseaudio.service - Sound Service.
```
Thanks to @bardliao the problem was narrowed down to the problem with UCM from this issue https://github.com/thesofproject/linux/issues/4580#issuecomment-1723432549 so I'm reporting this issue here.
Is it possible to fix this issue so UCM won't fail completely if one of the audio devices (microphones) is missing and will still initialize the available devices (speaker, jack output)? So that I can use speakers even without microphones?

I'm using Debian unstable with latest kernel 6.5.0-rc6+ from https://github.com/thesofproject/linux and firmware-sof-signed 2.2.6-1.
Here are the logs:
[alsa-info.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12688962/alsa-info.txt)
[dmesg-cable-connected.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12688964/dmesg-cable-connected.txt)
[dmesg-cable-disconnected.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12688965/dmesg-cable-disconnected.txt)
`amixer contents -c0`
[amixer-contents-cable-connected.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12688993/amixer-contents-cable-connected.txt)
[amixer-contents-cable-disconnected.txt](https://github.com/alsa-project/alsa-ucm-conf/files/12688994/amixer-contents-cable-disconnected.txt)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/356
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
