From: Geoffrey McRae <geoff@spacevs.com>
Subject: ASUS Phoebus (CMI8888) HDA Support
Date: Wed, 4 Dec 2013 21:36:13 +1100
Message-ID: <20131204213613.31b9a9c9@sarah.home.spacevs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.spacevs.com (mail1.spacevs.com [202.174.111.252])
 by alsa0.perex.cz (Postfix) with ESMTP id C9C24261A84
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 11:36:48 +0100 (CET)
Received: from localhost (mail1.spacevs.com [127.0.0.1])
 by mail1.spacevs.com (Postfix) with ESMTP id AFA2B70233
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 21:36:45 +1100 (EST)
Received: from mail1.spacevs.com ([127.0.0.1])
 by localhost (mail1.spacevs.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oYg4uY7BDQxe for <alsa-devel@alsa-project.org>;
 Wed,  4 Dec 2013 21:36:45 +1100 (EST)
Received: from sarah.home.spacevs.com (122-149-209-199.static.dsl.dodo.com.au
 [122.149.209.199])
 by mail1.spacevs.com (Postfix) with ESMTPSA id 0FA7970232
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 21:36:44 +1100 (EST)
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

Hi,

I have spent the better part of the last two days trying to add support
to the hda-intel driver for this card and I have finally got it
functional, not through any extra code though :(

To get it going I added the extra device info into the device list and
specified it as a generic device with no msi and LPIB position fix.

Initially this did not work, probing for codec info failed, the
interrupt was getting received, but the DMA address contained no data
(all 0x0).

After messing around a heap trying to find out why there was no DMA
data, I discovered that if I forced the device into single_cmd mode it
would operate, with very nasty scratchy audio, seems the IRQs were
not getting through and the circular buffer was under running. If I
made did something involving IRQs such as cat /proc/interrupts, it
would briefly fix the problem... if I wrote a while loop to do just
that, I would get mostly clean audio.

There is another thread in this mailing list where someone else has
tried all of this and ended up with the same output.

I decided to try to identify why the device was not returning RIRB data
in the DMA responses, and out of desperation setup a KVM with windows
to try to perform mmio tracing to identify where the hda-intel driver
was going wrong. This did not work, windows would not detect the codecs
attached to the device, I think it is due to a lack of MSI support for
passthrough devices. A positive thing did come out of this though, to
do this I enabled MMIO in my BIOS, which instantly fixed the missing
RIRB DMA data issue... I do not know enough about MMIO to understand
why this fixed this.

The device now detects the codec without single_cmd mode, but alas,
still no audio, but also no errors... further experimentation I found
that if I started the device in single_cmd mode and then went back to
normal, I would get perfect audio now.

Since I did this, I get perfect audio even without entering single_cmd
mode. I have dumped the registers under windows and can confirm that
during its initialization of the HDA device it does indeed use
single_cmd mode before switching over to IRQ/DMA mode, there might be
some standard init the driver is missing here.

So, to make this card work, very little extra code will be required,
just need to understand why enabling MMIO fixed the DMA issue as this
is not a viable fix for the problem, not everyone has MMIO.

Here is playback of a stereo stream while the device is working:

[   66.697114] hda_intel: Disabling MSI
[   66.697116] ALSA hda_intel.c:2553 Using LPIB position fix
[   66.697146] snd_hda_intel 0000:06:00.0: setting latency timer to 64
[   66.697151] ALSA hda_intel.c:2796 chipset global capabilities =
0x4300
[   66.697159] ALSA hda_intel.c:1175 Clearing TCSEL
[   66.724049] ALSA hda_intel.c:1031 codec_mask = 0x2
[   66.724181] ALSA hda_intel.c:1484 codec #1 probed OK
[   66.734419] ALSA hda_generic.c:586 AUD_IN = 8
[   66.734422] ALSA hda_generic.c:239 UNMUTE IN: NID=0x8 IDX=0x0
[   66.734879] ALSA hda_generic.c:239 UNMUTE IN: NID=0x12 IDX=0x0
[   66.735565] ALSA hda_generic.c:619 [Capture Source] NID=0x8, #SRC=1
[   66.735567] ALSA hda_generic.c:622   [Front Mic] IDX=0x0
[   66.735568] ALSA hda_generic.c:291 AUD_OUT found 2
[   66.735570] ALSA hda_generic.c:239 UNMUTE IN: NID=0xc IDX=0x0
[   66.735903] ALSA hda_generic.c:224 UNMUTE OUT: NID=0xc
[   66.736136] ALSA hda_generic.c:224 UNMUTE OUT: NID=0xc
[   66.736139] ALSA hda_generic.c:291 AUD_OUT found 6
[   66.736569] ALSA hda_generic.c:254 CONNECT: NID=0x8 IDX=0x0
[   66.736572] ALSA hda_generic.c:699 [Capture Switch] NID=0x8, DIR=IN,
IDX=0x0
[   66.736575] ALSA hda_generic.c:725 [Capture Volume] NID=0x8, DIR=IN,
IDX=0x0
[   66.736578] ALSA hda_generic.c:710 [Master Playback Switch] NID=0x2,
DIR=OUT
[   66.736580] ALSA hda_generic.c:734 [Master Playback Volume] NID=0x2,
DIR=OUT
[   76.125606] ALSA hda_intel.c:1848 azx_pcm_prepare: bufsize=0x10000,
format=0x31
[   76.125615] ALSA hda_codec.c:1414 hda_codec_setup_stream: NID=0x2,
stream=0x7, channel=0, format=0x31
[   93.308666] ALSA hda_codec.c:1477 hda_codec_cleanup_stream: NID=0x2

-
Geoffrey McRae
