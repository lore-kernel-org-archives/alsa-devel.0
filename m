From: Andrew Mahone <andrew.mahone@gmail.com>
Subject: Clevo P170HM / Sager NP8170 audio
Date: Sat, 20 Aug 2011 03:33:51 -0400
Message-ID: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f171.google.com (mail-iy0-f171.google.com
	[209.85.210.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A33E2477C
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Aug 2011 09:33:52 +0200 (CEST)
Received: by iyf13 with SMTP id 13so4984807iyf.2
	for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2011 00:33:51 -0700 (PDT)
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

This laptop is detected as ALC892 audio (and by the codec ID this
seems to be valid), but none of the configurations for it quite match
this device. I've been working on documenting the connections with HDA
Analyzer.

alsa-info output:
http://www.alsa-project.org/db/?f=b86e4c6447867fbd129a36d8a63e2f5caa836c52

The laptop has built-in 5.1, and 5.1 or 7.1 output via jacks.

DAC NIDs:
0x02 front
0x03 rear
0x04 clfe
0x05 side

internal mixers:
0x0c front
0x0d rear
0x0e clfe
0x0f side

internal speaker pins:
0x14 front
0x15 "rear" (front of laptop)
0x16 clfe

external ports:
fixed route:
0x17 side

can select any output:
0x18 mic / output
0x1a line-in / output
0x1b headphone

I've been experimenting with patch_realtek.c to add the extra DAC NID,
and have had some success with a 6-channel mode for the built-in
speakers and an 8-channel mode that mutes all internal speakers and
sets the jacks up for output. I still need to manually connect pins
0x18, 0x1a, 0x1b to the correct internal mixers for 7.1 to work, and
headphone plugin does not mute internal speakers in 5.1 mode. I have
not added a plain stereo mode for internal speakers, although it
appears that i can probably configure the codec to mix the front
channels to center and LFE.

Are there any suggestions for what to do next? My current state as a
patch against the linux-3.0.y repository is at
http://pastie.org/2400649

-- 
Andrew Mahone
andrew DOT mahone AT gmail DOT com

Q: How many voters does it take to change a lightbulb?
A: None - if voting could change anything they'd make it illegal
