From: "John L. Utz III" <john.utz@dmx.com>
Subject: Where is simple mixer control "Surround" defined for
 ac97 or via82xx? I cant find it anywhere in ac97....
Date: Wed, 8 Aug 2007 15:04:29 -0700
Message-ID: <20070808150429.45d1abef@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id AB0AC24414
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Aug 2007 23:59:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

The Surround controls exists:

amixer sget Surround
Simple mixer control 'Surround',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono:
  Front Left: Playback 0 [0%] [-46.50dB] [off]
  Front Right: Playback 0 [0%] [-46.50dB] [off]

amixer controls | grep Surround
numid=20,iface=MIXER,name='Surround Playback Switch'
numid=21,iface=MIXER,name='Surround Playback Volume'

But for the life of me, i cant find the code that implements it!

There are many implementations inside of the hda directory, but those
dont have anything todo with non hda things, the only item in the ac97
directory is for AD18XX:

ac97_codec.c:958:AD18XX_PCM_VOLUME("Surround Playback Volume", 1)


This shouldnt have anything to do with VIA 1618 stuff, right?

tnx!

johnu
