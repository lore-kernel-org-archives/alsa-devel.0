Return-Path: <SRS0=RrJr=FN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DD6C4361B
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 12:45:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3972B23BCD
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Dec 2020 12:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3972B23BCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E17516B1;
	Wed,  9 Dec 2020 13:44:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E17516B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607517900;
	bh=dQxUHy60joV0nvWIcQWxf0WsJLWTquAXr+1S+1Y0qi8=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Sx+TeyYnXjBmetrtYpx4atjyap9Sz835GCAkonqHgmKegfwQnNfttLl9RW8TAT7UI
	 vkGJ5qrd3es+utmMXd0XMVXsTovVW41p7cFLrVGu5UWEnBnNhCTVVD9hg/F9472wlv
	 PNwqFoJliDfrUzKE+vTeNHSxUKWxFCyxIZ3y1Rpo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50600F80217;
	Wed,  9 Dec 2020 13:44:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27774F80217; Wed,  9 Dec 2020 13:44:07 +0100 (CET)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 77656F8012C
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2020 13:43:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 77656F8012C
Received: from [123.114.42.209] (helo=localhost.localdomain)
 by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <hui.wang@canonical.com>)
 id 1kmyp3-0003Vb-Uw; Wed, 09 Dec 2020 12:43:58 +0000
From: Hui Wang <hui.wang@canonical.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [RFC][PATCH 0/2] design a way to change audio Jack state by software
Date: Wed,  9 Dec 2020 20:43:42 +0800
Message-Id: <20201209124344.219158-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

After we change sth in the userspace audio stack like alsa-ucm or
pulseaudio, we want to perform remote audio auto test to verify if the
change introduce the regression or not, some of the tests are about
the defaut_sink/default_source or active_port switching, this needs
the audio jack state to be changed to trigger the userspace's audio
device switching.

So far, there is no software ways to change the audio jack state, this
block the auto test.

My design is adding a sysfs interface for each sound card if the card
has audio jack, then users could echo different values to sysfs to
change the jack state (Phantom jack is not controlled by injection).
And once the users enable the jack injection via sysfs, this jack's
state will not be controlled by hw events anymore until users disable
the jack injection.

Of course, this could not 100% simulate the plugin or plugout triggered
by hw events, with the hw triggered plugin or plugout, the audio driver
will set codec or does sth else, so the software injection is just
changing the jack state and notify the userspace, it is just for
testing userspace part.

Here is an example to change jack state via sysfs:

After booting up:
/* cd to the jack injection folder for sound card0 in the sysfs */
$cd /sys/devices/pci0000:00/0000:00:1f.3/skl_hda_dsp_generic/sound/card0/jack

/* check file nodes in this folder */
$ls
jackin_inject  sw_inject_enable

/* check all jack's software injection enable status, all disabled now */
$ cat sw_inject_enable 
Jack: Mic  0
Jack: Headphone  0
Jack: HDMI/DP,pcm=3  0
Jack: HDMI/DP,pcm=4  0
Jack: HDMI/DP,pcm=5  0

/* enable software injection for Jack Headphone */
$ sudo sh -c "echo Headphone 1 > sw_inject_enable"

/* check all jack's software injection enable status again, now Headphone is enabled */
$ cat sw_inject_enable 
Jack: Mic  0
Jack: Headphone  1
Jack: HDMI/DP,pcm=3  0
Jack: HDMI/DP,pcm=4  0
Jack: HDMI/DP,pcm=5  0

/* trigger plugin to Jack Headphone */
$sudo sh -c "echo Headphone 1 > jackin_inject"

/* check if Jack Headphone is plugged in */
$ sudo amixer contents | grep "Headphone Jack" -3
numid=30,iface=CARD,name='HDMI/DP,pcm=5 Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=17,iface=CARD,name='Headphone Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=on
numid=14,iface=CARD,name='Mic Jack'

/* trigger plugout to Jack Headphone */
$ sudo sh -c "echo Headphone 0 > jackin_inject"

/* check if Jack Headphone is plugged out */
$ sudo amixer contents | grep "Headphone Jack" -3
numid=30,iface=CARD,name='HDMI/DP,pcm=5 Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=17,iface=CARD,name='Headphone Jack'
  ; type=BOOLEAN,access=r-------,values=1
  : values=off
numid=14,iface=CARD,name='Mic Jack'

/* disable Jack Headphone software injection, this will return the control to non-injection ways */
$ sudo sh -c "echo Headphone 0 > sw_inject_enable"

/* check if the Jack Headphone software injection is disabled, it is disabled now */
$ cat sw_inject_enable 
Jack: Mic  0
Jack: Headphone  0
Jack: HDMI/DP,pcm=3  0
Jack: HDMI/DP,pcm=4  0
Jack: HDMI/DP,pcm=5  0

Hui Wang (2):
  alsa: jack: expand snd_jack_report parameter for jack sw_inject
  alsa: jack: adding support for software jack in or out injection

 include/sound/core.h            |   1 +
 include/sound/jack.h            |   5 +-
 sound/core/jack.c               | 129 +++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_jack.c        |   6 +-
 sound/pci/hda/patch_hdmi.c      |   2 +-
 sound/pci/oxygen/xonar_wm87x6.c |   2 +-
 sound/soc/soc-jack.c            |   2 +-
 sound/x86/intel_hdmi_audio.c    |   4 +-
 8 files changed, 140 insertions(+), 11 deletions(-)

-- 
2.25.1

