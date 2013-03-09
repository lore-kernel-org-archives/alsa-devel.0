From: Doug McLain <doug@nostar.net>
Subject: Re: plans for fireworks driver
Date: Sat, 09 Mar 2013 15:52:36 -0500
Message-ID: <513BA114.3000305@nostar.net>
References: <513A5CF4.9090803@nostar.net> <513B2B62.9040307@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020409070901050503040004"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f44.google.com (mail-qa0-f44.google.com
 [209.85.216.44])
 by alsa0.perex.cz (Postfix) with ESMTP id E5BD926505E
 for <alsa-devel@alsa-project.org>; Sat,  9 Mar 2013 21:52:44 +0100 (CET)
Received: by mail-qa0-f44.google.com with SMTP id bv4so380329qab.3
 for <alsa-devel@alsa-project.org>; Sat, 09 Mar 2013 12:52:43 -0800 (PST)
In-Reply-To: <513B2B62.9040307@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020409070901050503040004
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Attached is a patch of my hack to build your source of Fedora 18 with=20
kernel 3.8.  As I mentioned in the last email, I have had to do various=20
little hacks to the other snd-fireworks module source over the past few=20
years as chnages were made to the kernel API.  The latest change, which=20
prompted me to write this email in the first place, was the removal of=20
__devinit and friends from kernel 3.8.  So now its built, installed, and=20
running.  It discovers the AF2, but not the AF12.  Here is the log from=20
the AF12:

Mar  9 15:47:06 iggy kernel: [63129.761604] firewire_core 0000:01:0b.0:=20
phy config: new root=3Dffc2, gap_count=3D7
Mar  9 15:47:11 iggy kernel: [63134.769274] ALSA fireworks_command.c:313=20
EFC Failed [0/1]: 0
Mar  9 15:47:11 iggy kernel: [63134.769289] snd-fireworks: probe of=20
fw2.0 failed with error -5
Mar  9 15:47:11 iggy kernel: [63134.769293] firewire_core 0000:01:0b.0:=20
created device fw2: GUID 0014860fc44a84a6, S400


...and the AF2
$ cat /proc/asound/card0/efc_hardware
flags: 0xA1
guid_hi: 0x148606
guid_lo: 0x9D5BD6CA
type: 0xAF2
version: 0x0
vendor_name: Echo Digital Audio
model_name: AudioFire2
supported_clock: 0x9
nb_1394_playback_channels: 0x6
nb_1394_capture_channels: 0x4
nb_phys_audio_out: 0x6
nb_phys_audio_in: 0x4
nb_out_groups: 0x3
out_group[0x0]: type 0x0, count 0x2
out_group[0x1]: type 0x5, count 0x2
out_group[0x2]: type 0x1, count 0x2
out_group[0x3]: type 0x0, count 0x0
out_group[0x4]: type 0x0, count 0x0
out_group[0x5]: type 0x0, count 0x0
out_group[0x6]: type 0x0, count 0x0
out_group[0x7]: type 0x0, count 0x0
nb_in_groups: 0x2
out_group[0x0]: type 0x0, count 0x2
out_group[0x1]: type 0x5, count 0x2
out_group[0x2]: type 0x1, count 0x2
out_group[0x3]: type 0x0, count 0x0
out_group[0x4]: type 0x0, count 0x0
out_group[0x5]: type 0x0, count 0x0
out_group[0x6]: type 0x0, count 0x0
out_group[0x7]: type 0x0, count 0x0
nb_midi_out: 0x1
nb_midi_in: 0x1
max_sample_rate: 0x17700
min_sample_rate: 0x7D00
dsp_version: 0x0
arm_version: 0x4080000
mixer_playback_channels: 0x6
mixer_capture_channels: 0x4
fpga_version: 0x3000200
nb_1394_playback_channels_2x: 0x6
nb_1394_capture_channels_2x: 0x4
nb_1394_playback_channels_4x: 0x6
nb_1394_capture_channels_4x: 0x4

-D

On 03/09/2013 07:30 AM, Takashi Sakamoto wrote:
> Dear Doug,
>
> I'm a newcomer of ALSA project and currently working for snd-fireworks.
> Then I have a favour of you.
> (My first name is the same one that ALSA core developer has. But I'm
> newcomer Takashi)
>
> Unfortunatelly my post isn't delivered by mailman of
> alsa-devel@alsa-project.org. But I'm not a professional for mailman or
> SMTP so it takes a bit time that I debut in alsa-devel...
>
> Well, my source is here.
> https://github.com/takaswie/snd-firewire-improve
>
> It's a bit worse to you because current source has a lack of some
> functions that Clemens' snd-fireworks has.
>
>   - playback is available, capture is not. Additionally 2ch are
> available (under investigating...)
>   - MIDI is not available
>
> The reason is snd-firewire-lib.ko has these functions. Currently I'm
> working for them.
>
> But the implementation of hardware control is almost done:
>   - Hardware metering/monitoring/mixing are visible via procfs, but not
> configurable
>   - sampling rate, digital mode, digital format and clock source are
> changeable via alsamixer
>
> Hardware metering/monitoring/mixing will also be available via alsamixe=
r
> after I've investigated the suitable way in ALSA's control component AP=
I.
>
> My favor of you is "building and installing my module and give me
> hardware information of your AF2 and AF12". I'm working with Ubuntu and
> utilize DKMS for debugging my module. You can see an instruction in REA=
DME.
>
> If your Fireworks is identified by your system, there is
> /proc/asound/cardX/efc_hardware. If you "cat" this file, my module
> submit a command to your device to get hardware information and print
> the value. My module decide available functions refering it so it's ver=
y
> important.
>
> This is the output of my device, for your information:
> $ cat /proc/asound/card2/efc_hardware
> flags: 0x625
> guid_hi: 0x14860A
> guid_lo: 0x5B6BDB9B
> type: 0xAF9
> version: 0x0
> vendor_name: Echo Digital Audio
> model_name: AudioFirePre8
> supported_clock: 0x1D
> nb_1394_playback_channels: 0x10
> nb_1394_capture_channels: 0x10
> nb_phys_audio_out: 0x10
> nb_phys_audio_in: 0x10
> nb_out_groups: 0x2
> out_group[0x0]: type 0x0, count 0x8
> out_group[0x1]: type 0x3, count 0x8
> out_group[0x2]: type 0x0, count 0x0
> out_group[0x3]: type 0x0, count 0x0
> out_group[0x4]: type 0x0, count 0x0
> out_group[0x5]: type 0x0, count 0x0
> out_group[0x6]: type 0x0, count 0x0
> out_group[0x7]: type 0x0, count 0x0
> nb_in_groups: 0x2
> out_group[0x0]: type 0x0, count 0x8
> out_group[0x1]: type 0x3, count 0x8
> out_group[0x2]: type 0x0, count 0x0
> out_group[0x3]: type 0x0, count 0x0
> out_group[0x4]: type 0x0, count 0x0
> out_group[0x5]: type 0x0, count 0x0
> out_group[0x6]: type 0x0, count 0x0
> out_group[0x7]: type 0x0, count 0x0
> nb_midi_out: 0x1
> nb_midi_in: 0x1
> max_sample_rate: 0x17700
> min_sample_rate: 0x7D00
> dsp_version: 0x0
> arm_version: 0x5050000
> mixer_playback_channels: 0x10
> mixer_capture_channels: 0x10
> fpga_version: 0x4010100
> nb_1394_playback_channels_2x: 0xC
> nb_1394_capture_channels_2x: 0xC
> nb_1394_playback_channels_4x: 0xA
> nb_1394_capture_channels_4x: 0xA
>
> Kind Regards
>
>
> Takashi Sakamoto
> o-takashi@sakamocchi.jp
>
> (2013=E5=B9=B403=E6=9C=8809=E6=97=A5 06:49), Doug McLain wrote:
>> I have been building and using the fireworks driver from
>> alsa-kprivate/fireworks for a few years now with my AF2 and AF12.  The
>> driver works great for me, although every so often after a kernel
>> update, compilation breaks and I have to hack at it a little bit to ge=
t
>> it to build again.
>>
>> Are there any plans to include this driver into the kernel?
>

--------------020409070901050503040004
Content-Type: text/x-patch;
 name="fw.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fw.diff"

diff --git a/fireworks/fireworks_control.c b/fireworks/fireworks_control.c
index 87ae272..3418f86 100755
--- a/fireworks/fireworks_control.c
+++ b/fireworks/fireworks_control.c
@@ -18,6 +18,10 @@
 
 #include "fireworks.h"
 
+#ifndef __devinitdata
+#define __devinitdata
+#endif
+
 /*
  * Physical metering:
  *  available channels differ depending on current sampling rate

--------------020409070901050503040004
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020409070901050503040004--
