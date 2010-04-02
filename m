From: "Nicolo' Chieffo" <nicolo.chieffo@gmail.com>
Subject: Re: wrong decibel data?
Date: Fri, 2 Apr 2010 22:25:08 +0200
Message-ID: <q2t98391a7b1004021325jbc9e7ddal26063e490fe69254@mail.gmail.com>
References: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id C3EF71038CF
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Apr 2010 22:25:28 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 4so207679eyg.16
	for <alsa-devel@alsa-project.org>; Fri, 02 Apr 2010 13:25:28 -0700 (PDT)
In-Reply-To: <q2s98391a7b1004021121sde36d074m8a70acc142f95d93@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I just had a discussion with pulseaudio developers in which they told
me that if the speakers don't emit any audio when the ALSA volume is
0%, then the correct gain value should be -inf dB (a value lower than
-200 for pulseaudio means mute). Unfortunately my card has -48 dB.

They also said that if with -47.25 dB (which is what I get with ALSA
volume set to 2%) I can hear audio even if it's very very low, at -48
dB I should still be able to hear something (the scale is
logarithmic).

Their request is to change to -200 the gain reported from my card
driver when the ALSA volume is set to 0%.
Thanks
