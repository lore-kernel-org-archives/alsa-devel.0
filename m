From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: AC97 Playback Volume and Mic Boost (+20dB)
Date: Wed, 27 Apr 2011 12:00:59 +0800
Message-ID: <BANLkTinH+UY-e4kVsiRzYz+Vb0fFUmwVDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DC4AA10385E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 06:01:00 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1027420fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2011 21:00:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Should alsactl init change "AC97 Playback Volume" and "AC97 Playback Switch"
only for aureon ?


pci/ice1712/aureon.c:        .name = "AC97 Playback Volume",


 CTL{reset}="mixer"
 CTL{name}="AC97 Playback Volume",CTL{do_search}=="1", \
 CTL{values}="100%"
 CTL{name}="AC97 Playback Switch",CTL{do_search}=="1", \
 CTL{values}="on"


Refer to Documentation/SB-Live-mixer.txt ,

The alternative way may be remove these two controls if there are no
practical usage ?


name='AC97 Playback Volume',index=0

This control is used to attenuate samples for left and right front ADC PCM
slots
of the AC97 codec. The result samples are forwarded to the front DAC PCM
slots of the AC97 codec.
********************************************************************************
*** Note: This control should be zero for the standard operations, otherwise
***
*** a digital loopback is activated.
***
********************************************************************************

name='AC97 Capture Volume',index=0

This control is used to attenuate samples for left and right front ADC PCM
slots
of the AC97 codec. The result is forwarded to the ADC capture FIFO (thus to
the standard capture PCM device).
********************************************************************************
*** Note: This control should be 100 (maximal value), otherwise no analog
***
*** inputs of the AC97 codec can be captured (recorded).
***
********************************************************************************





BTW , why alsa-lib regard "Mic Boost (+20dB)" switch as a playback switch  ?
it seem that "20dB Boost " have effect on both playback and capture


Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined penum
  Playback channels: Mono
  Mono: Playback [off]
