From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: alsamixer - Mute AC97 "PCM Playback Switch" also mute
 "Master Playback Switch" and "Surround Playback Switch"
Date: Wed, 20 Jun 2012 10:39:52 +0800
Message-ID: <CAN8cciZ2Qj71geH=HQi2ZS8tcW6X4j2L+=KhECm0W_wQDyh45w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F6EC2417E
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2012 04:39:53 +0200 (CEST)
Received: by wibhr14 with SMTP id hr14so2940130wib.2
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2012 19:39:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org
Cc: tiwai@suse.de, fajwilson@gmail.com, avagin@gmail.com
List-Id: alsa-devel@alsa-project.org

Tested on Ubuntu 12.04 and Fedora 17 Live CD

When PA server is running , using alsamixer -c0 to mute AC97 's "PCM
Playback Switch" also mute "Master Playback Switch" and "Surround
Playback Switch"

but unmute "PCM Playback Switch" does not unmute "Master Playback
Switch" and "Surround Playback Switch" of stac9708

alsamixer behave normally when shutdown PA server by

echo "autospwan=off" > .pulse/client.conf and pulseaudio -k

Why pulseaudio server behave in this way ?
