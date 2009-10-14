From: Sreekanth W <w.sreekanth@gmail.com>
Subject: Mic/Line-in record is not working with wm9713 AC97
Date: Wed, 14 Oct 2009 15:39:23 +0530
Message-ID: <8aea34270910140309o2a4ad31cpe33904244d3b103d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
	[209.85.211.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F8111038E7
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Oct 2009 12:09:24 +0200 (CEST)
Received: by ywh33 with SMTP id 33so4836831ywh.23
	for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2009 03:09:23 -0700 (PDT)
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

Hi,

I am trying to record a wav file using mic/line-in with wm9713 driver.
The Wav file is created, only header is created but almost there is no
data. This is seen using CoolEdit/Vim editor.
If I try to play the recorded file, there is no sound.
But, playing works for other existing files, able to using aplay.

I am issuing the following command to record
# ./arecord =96t wav =96c 1 =96r 8000 =96d 10 =96f S16_LE test.wav

The below is the dump of /sys/devices/platform/soc-audio/dapm_widget,
while "arecord" is running (using mic):

# cat /sys/devices/platform/soc-audio/dapm_widget
Mic Bias: Off
Mic B Pre Amp: Off
Mic A Pre Amp: On
Mic B PGA: Off
Mic A PGA: Off
Mono In: Off
Right Line In: Off
Left Line In: Off
Mono Out: Off
Out 4: Off
Out 3: Off
Right Speaker: Off
Left Speaker: Off
Right Headphone: Off
Left Headphone: Off
Right Voice ADC: Off
Left Voice ADC: Off
Right HiFi ADC: On
Left HiFi ADC: On
Right ADC: On
Left ADC: On
Aux DAC: Off
Voice DAC: Off
Capture Mixer: Off
Line Mixer: Off
HP Mixer: Off
AC97 Mixer: Off
Right DAC: Off
Left DAC: Off
Speaker Mixer: Off
Mono Mixer: Off
Right HP Mixer: Off
Left HP Mixer: Off
PM State: On

I'm using DMA for data transfer, and getting the callback function
after DMA completed.
Also I'm printing the number of Bytes transfered.

Any idea why record is  not working? Anything wrong with these settings?

Regards,
Sreekanth
