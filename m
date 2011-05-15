From: Jeremy Bush <contractfrombelow@gmail.com>
Subject: ALC892 Support (Intel HDA) - HDMI
Date: Sun, 15 May 2011 14:07:03 -0500
Message-ID: <F8FDC04B-B0AC-48F8-A6FB-E533F1931DC7@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4678224402
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 21:07:07 +0200 (CEST)
Received: by iym7 with SMTP id 7so3748200iym.38
	for <alsa-devel@alsa-project.org>; Sun, 15 May 2011 12:07:06 -0700 (PDT)
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

Hello-

I'm trying to get my Realtek ALC892 chip to work according to it's specifications over HDMI. The manufacturers site say it should be able to do 7.1+2 channels, 24bit audio and 192Khz sample rate. However, it seems that the ALSA drivers (even the ones from the realtek website) limit the output to 2 channels, 16bit, 88.2KHz.

Here is my system information that you can see these results:

http://www.alsa-project.org/db/?f=5b55a63fea6580dfcbf1a85c7c734f977df798f1

I see the ALC892 as being supported in the ALSA changelog, but I don't see any model options in Documentation/HD-Audio-Models.txt. I'm currently using "options snd-hda-intel model=6stack-digout" (as I have 6-jack with a SPDIF out on the motherboard) but I'm not sure that is actually doing anything.

What's the *actual* support of this chipset? Is what I'm getting now the best I should expect over HDMI? I saw support in ALSA and bought the motherboard expecting it to be fully supported since the changelogs say support was added.

I also tried with an ALC887 chipset as well, and got basically the same results.

Any help getting this to work would be appreciated. Let me know if there's any other information required.

Thank you-
Jeremy
