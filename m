From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [Regression] Loss of OPL3 FM Synth in
	alsa-driver-1.0.25
Date: Sun, 4 Mar 2012 10:47:29 +0800
Message-ID: <CAN8cciazpgRcUVp2W9C9KYBY13CW4ZpyMmQdWiHEqQJ1Pd8PPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 58F24243A7
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 03:47:30 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so1863665wgb.20
	for <alsa-devel@alsa-project.org>; Sat, 03 Mar 2012 18:47:30 -0800 (PST)
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

alsa-tools/seq/sbiload still work but Loss of OPL3 FM synth for
ymf724f in alsa-driver-1.0.25

The OPL3 FM Synth works In alsa-driver-1.0.24

aplaymidi -l

 Port    Client name                      Port name
 14:0    Midi Through                     Midi Through Port-0
 17:0    OPL3 FM synth                    OPL3 FM Port

lsmod

Module                  Size  Used by
snd_hrtimer             6664  1
snd_opl3_synth         14852  1
snd_seq_midi_emul       9088  1 snd_opl3_synth
fuse                   49436  2
i915                   53764  2
drm                   158388  3 i915
vboxnetflt             74200  0
vboxdrv                98632  1 vboxnetflt
sunrpc                156436  3
ip6t_REJECT             7296  2
nf_conntrack_ipv6      15864  2
ip6table_filter         6400  1
ip6_tables             14736  1 ip6table_filter
ipv6                  230516  18 ip6t_REJECT,nf_conntrack_ipv6
cpufreq_ondemand        9996  2
acpi_cpufreq           12172  0
dm_multipath           17292  0
uinput                 10624  0
snd_hda_codec_analog    72576  1
snd_hda_intel          30480  0
snd_hda_codec          75520  2 snd_hda_codec_analog,snd_hda_intel
snd_seq_dummy           6788  0
snd_seq_oss            28060  0
snd_seq_midi_event      9728  1 snd_seq_oss
snd_seq                45756  9
snd_opl3_synth,snd_seq_midi_emul,snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_usb_audio          93316  0
snd_ymfpci             34052  2
gameport               13452  1 snd_ymfpci
snd_ac97_codec         96548  1 snd_ymfpci
ac97_bus                5760  1 snd_ac97_codec
snd_opl3_lib           12672  2 snd_opl3_synth,snd_ymfpci
snd_hwdep              10500  3 snd_hda_codec,snd_usb_audio,snd_opl3_lib
snd_usbmidi_lib        20352  1 snd_usb_audio
snd_pcm_oss            36864  0
snd_mpu401_uart        10496  1 snd_ymfpci
snd_rawmidi            22016  2 snd_usbmidi_lib,snd_mpu401_uart
snd_mixer_oss          16896  1 snd_pcm_oss
snd_seq_device         10124  6
snd_opl3_synth,snd_seq_dummy,snd_seq_oss,snd_seq,snd_opl3_lib,snd_rawmidi
snd_pcm                64260  7
snd_hda_intel,snd_hda_codec,snd_usb_audio,snd_ymfpci,snd_ac97_codec,snd_pcm_oss
snd_timer              21512  5
snd_hrtimer,snd_seq,snd_ymfpci,snd_opl3_lib,snd_pcm
snd                    52536  23
snd_hrtimer,snd_opl3_synth,snd_hda_codec_analog,snd_hda_intel,snd_hda_codec,snd_seq_dummy,snd_seq_oss,snd_seq,snd_usb_audio,snd_ymfpci,snd_ac97_codec,snd_opl3_lib,snd_hwdep,snd_usbmidi_lib,snd_pcm_oss,snd_mpu401_uart,snd_rawmidi,snd_mixer_oss,snd_seq_device,snd_pcm,snd_timer
snd_page_alloc         11400  3 snd_hda_intel,snd_ymfpci,snd_pcm
iTCO_wdt               13732  0
iTCO_vendor_support     6916  1 iTCO_wdt
i2c_i801               12048  0
i2c_core               21396  2 drm,i2c_i801
skge                   38416  0
uvcvideo               51720  0
compat_ioctl32          5120  1 uvcvideo
videodev               32000  1 uvcvideo
v4l1_compat            15876  2 uvcvideo,videodev
firewire_ohci          22532  0
firewire_core          35616  1 firewire_ohci
crc_itu_t               5760  1 firewire_core
soundcore               9416  1 snd
pcspkr                  6272  0
pata_jmicron            6912  0
ata_generic             8452  0


But in alsa-driver-1.0.25

aplaymidi -l

 Port    Client name                      Port name
 14:0    Midi Through                     Midi Through Port-0


Module                  Size  Used by
fuse                   49436  2
i915                   53764  2
drm                   158388  3 i915
vboxnetflt             74200  0
vboxdrv                98632  1 vboxnetflt
sunrpc                156436  3
ip6t_REJECT             7296  2
nf_conntrack_ipv6      15864  2
ip6table_filter         6400  1
ip6_tables             14736  1 ip6table_filter
ipv6                  230516  18 ip6t_REJECT,nf_conntrack_ipv6
cpufreq_ondemand        9996  2
acpi_cpufreq           12172  0
dm_multipath           17292  0
uinput                 10624  0
snd_hda_codec_analog    72576  1
snd_hda_intel          32016  0
snd_usb_audio          98948  0
snd_hda_codec          78976  2 snd_hda_codec_analog,snd_hda_intel
snd_seq_dummy           6788  0
snd_ymfpci             34180  0
gameport               13452  1 snd_ymfpci
snd_ac97_codec         96804  1 snd_ymfpci
ac97_bus                5760  1 snd_ac97_codec
snd_seq_oss            28060  0
snd_seq_midi_event      9728  1 snd_seq_oss
snd_seq                45756  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_pcm_oss            36864  0
snd_mixer_oss          16768  1 snd_pcm_oss
snd_pcm                64516  6
snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_ymfpci,snd_ac97_codec,snd_pcm_oss
firewire_ohci          22532  0
snd_opl3_lib           12672  1 snd_ymfpci
pata_jmicron            6912  0
snd_timer              21512  4 snd_ymfpci,snd_seq,snd_pcm,snd_opl3_lib
firewire_core          35616  1 firewire_ohci
uvcvideo               51720  0
compat_ioctl32          5120  1 uvcvideo
snd_usbmidi_lib        20608  1 snd_usb_audio
pcspkr                  6272  0
skge                   38416  0
iTCO_wdt               13732  0
snd_hwdep              10500  3 snd_usb_audio,snd_hda_codec,snd_opl3_lib
snd_mpu401_uart        10496  1 snd_ymfpci
videodev               32000  1 uvcvideo
snd_rawmidi            21888  2 snd_usbmidi_lib,snd_mpu401_uart
snd_seq_device         10124  5
snd_seq_dummy,snd_seq_oss,snd_seq,snd_opl3_lib,snd_rawmidi
crc_itu_t               5760  1 firewire_core
iTCO_vendor_support     6916  1 iTCO_wdt
snd                    54328  19
snd_hda_codec_analog,snd_hda_intel,snd_usb_audio,snd_hda_codec,snd_seq_dummy,snd_ymfpci,snd_ac97_codec,snd_seq_oss,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_usbmidi_lib,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
soundcore               9416  1 snd
snd_page_alloc         11400  3 snd_hda_intel,snd_ymfpci,snd_pcm
v4l1_compat            15876  2 uvcvideo,videodev
i2c_i801               12048  0
i2c_core               21396  2 drm,i2c_i801
ata_generic             8452  0
pata_acpi               7680  0
