From: Howard Mitchell <hm@hmbedded.co.uk>
Subject: pcm512x driver: Mixer control naming issue
Date: Fri, 13 Mar 2015 12:41:05 +0000
Message-ID: <5502DAE1.30609@hmbedded.co.uk>
References: <5500DE5B.2020401@hmbedded.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avasout02.plus.net (avasout02.plus.net [212.159.14.17])
 by alsa0.perex.cz (Postfix) with ESMTP id 29150260469
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 13:41:08 +0100 (CET)
In-Reply-To: <5500DE5B.2020401@hmbedded.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Gordon Garrity <gordon.garrity@gmail.com>, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

As you may be aware the Raspbian distribution for the RaspberryPi has 
recently been upgraded to kernel version 3.18. It was previously at 
version 3.12. This has had the unfortunate side effect that users of the 
PCM5122 DAC have found that the output volume has been significantly 
reduced. The issue is related to this commit 
<https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/sound/soc/codecs/pcm512x.c?id=5be2fc20b101b5138c4f54a584dc11790ef16598> 
which adds support for a couple of analogue gain controls. One control 
(Playback Volume) sets a gain of either 0db or -6dB and is intended to 
set the full scale output at 2Vrms or 1Vrms respectively. The other 
(Playback Boost Volume) provides a boost of +0.8dB. The hardware reset 
value of both of these gain controls is 0dB, however, in the Raspbian 
distribution 'Playback Volume' is being defaulted to -6dB.

After some investigation I figured out that this was caused by the alsa 
restore mechanism. If '/var/lib/alsa/asound.state' doesn't exist or 
there is no saved state for a particular control then the defaults in 
'/usr/share/alsa/init/default' are used. In this file the default for a 
control named 'Playback Volume' is -20dB which is forcing the control to 
it's minimum value of -6dB. This seems like incorrect behaviour for 
something that is essentially an implementation detail, i.e. a choice 
that should be made by the board designer not the end user. Therefore 
I'd like to see what you think of the following suggestions (which I'd 
be more than happy to implement and submit patches for):

  * Either change the names of these controls to something that's not
    affected by the alsa restore mechanism,
  * or remove them as mixer controls, but make them accessible some
    other way - e.g. device tree.

Howard Mitchell
