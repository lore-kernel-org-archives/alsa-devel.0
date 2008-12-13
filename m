From: "Alexander Chemeris" <Alexander.Chemeris@sipez.com>
Subject: "No codecs found" on Intel HDA + AD1988A
Date: Sat, 13 Dec 2008 21:57:04 +0300
Message-ID: <3d032e5d0812131057g71773bcam4b8a5832ea3bbba8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 0948C103807
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 19:57:05 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id w1so1127724mue.2
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 10:57:05 -0800 (PST)
Content-Disposition: inline
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

I have Asus P5B-V motherboard with integrated Intel HDA
audio and AD1988A codec (I see the chip on the board).
About half a year ago or so it used to work, but now when
snd-hda-intel module is loaded it claims it can't find a codec:

$ dmesg | grep -i hda
[   13.648205] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level,
low) -> IRQ 22
[   13.648236] HDA Intel 0000:00:1b.0: setting latency timer to 64
[   13.680537] hda-intel: no codecs found!
[   13.680589] HDA Intel 0000:00:1b.0: PCI INT A disabled

I tried different recent versions of ALSA to no avail.
So far I've tried:

* 1.0.17 with Ubuntu patches
* 1.0.18 with Ubuntu patches
* 1.0.18a downloaded half an hour ago from here:
  ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz

I also tried to compile 1.0.16, but seems it is not compatible
with the kernel:

$ uname -a
Linux nidus 2.6.27-10-generic #1 SMP Fri Nov 21 19:19:18 UTC 2008
x86_64 GNU/Linux

When I tried 1.0.18a, I also manually loaded snd-hda-codec_analog before
loading snd-hda-intel without any success. And yeah, when I just
run `modprobe snd-hda-intel` only following modules are loaded:

$ lsmod | grep snd
snd_hda_intel          37864  0
snd_hda_codec          86784  1 snd_hda_intel
snd_hwdep              17160  1 snd_hda_codec
snd_pcm_oss            52256  0
snd_mixer_oss          25088  1 snd_pcm_oss
snd_pcm                98824  3 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_seq_oss            43776  0
snd_seq_midi_event     16768  1 snd_seq_oss
snd_seq                67744  4 snd_seq_oss,snd_seq_midi_event
snd_timer              33424  2 snd_pcm,snd_seq
snd_seq_device         16788  2 snd_seq_oss,snd_seq
snd                    83144  10
snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_seq,snd_timer,snd_seq_device
soundcore              16800  1 snd
snd_page_alloc         18576  2 snd_hda_intel,snd_pcm

What can I do to help get my audio working again?
I don't want to install different kernel or restart computer
(well, as a last resort, may be...), but I easily can
test different any patches, etc.

PS I don't think it matters, but I use Ubuntu 8.10 x64.

-- 
Regards,
Alexander Chemeris.

SIPez LLC.
SIP VoIP, IM and Presence Consulting
http://www.SIPez.com
tel: +1 (617) 273-4000
