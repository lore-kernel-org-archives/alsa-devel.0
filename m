From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Capture Source/Input Souce of Alsa sound cards and
	pulseaudio source
Date: Thu, 31 Mar 2011 16:47:14 +0800
Message-ID: <AANLkTiknyOEgDHrXvwvrx6UkbYLW171Q2n5wQLckHAeo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 00D8710380A
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 10:47:16 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1794618fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2011 01:47:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

There are 4 Capture Volume/Switch (Front, Surround, Synth and Wave) and
Capture source of ac97 codec contain 8 input sources (Mic, CD, Video , Aux,
Line, Stereo Mix, Mono Mix and Phone) on SB Live! Platinum

How can ALSA application know whether all 12 sources can be selected for
device 0 ?

card 1: Live [SB Live! Platinum [CT4760P]], device 0: emu10k1 [ADC
Capture/Standard PCM Playback]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Live [SB Live! Platinum [CT4760P]], device 1: emu10k1 mic [Mic
Capture]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: Live [SB Live! Platinum [CT4760P]], device 2: emu10k1 efx
[Multichannel Capture/PT Playback]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
