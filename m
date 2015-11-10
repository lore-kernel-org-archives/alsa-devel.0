From: Michael Pogrebinsky <michael.pogrebinsky@daqri.com>
Subject: ASoC Sound Driver I2S over LPE,
	Intel Baytrail SoC. MinnowBoard Max
Date: Mon, 9 Nov 2015 17:31:02 -0800
Message-ID: <CAGOuWmvw39beNdaLgdBGXk9rNWw9vwbFfQNSBw50KLYpGa_AHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f178.google.com (mail-ig0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 61603260509
 for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2015 02:31:04 +0100 (CET)
Received: by igbxm8 with SMTP id xm8so63685447igb.1
 for <alsa-devel@alsa-project.org>; Mon, 09 Nov 2015 17:31:03 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi all,
I have the MinnowBoard Max with Baytrail Atom (ValleyView) SoC.
I'm attempting to write an Alsa (ASoC) driver for my sound card to
work with this board.
PCM should work through I2S for this sound card I have.

>From my understanding Baytrail's I2S goes over LPE. I read this
thread:https://www.mail-archive.com/elinux-minnowboard@lists.elinux.org/msg01572.html

So I understand that I need the 3 components for my ASoC driver. However I
am having trouble at understanding how to communicate with the LPE to get
the I2S working.

Here is what I have done so far:
I am running Ubuntu 14.04 LTS, kernel : 4.3.0-040300rc4

First of all I downloaded the firmware fw_sst_0f28.bin-48kHz_i2s_master
fromhttps://kernel.googlesource.com/pub/scm/linux/kernel/git/firmware/linux-firmware/+/refs/heads/master/intel/fw_sst_0f28.bin-48kHz_i2s_master

And put it /lib/firmware/intel/.
Later I went to the Bios and enabled LPE in PCI mode. I do see the LPE
controller now, but it shows as UNCLAIMED.

Later I looked at the sound/soc/inte/baytrail/ and from my understanding
in order for me to get the I2S working I need to load this module so I did
modprobe snd-soc-sst-baytrail-pcm. Later I wrote a simple codec and machine
driver (looking at the example of sound/soc/intel/boards/byt_max98090)
however everytime I attempt to register the sound card with
snd_soc_register_card, I get the following error message in dmesg : "ASoC:
CPU DAI baytrail-pcm-audio not registered".

>From this I deduct that although I loaded the snd-soc-sst-baytrail-pcm
module, the driver has not actually been loaded.
I'm clueless on how to proceed from here.

I would highly appreciate your help.
