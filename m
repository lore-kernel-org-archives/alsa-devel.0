From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000491]: Corrupted sounds recorded after using mjpeg's glav utility
Date: Thu,  9 Sep 2004 08:17:03 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040909061703.5D8A214027@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B136C1F8
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 08:17:03 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id 6F6F921919
	for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2004 08:17:03 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been SUBMITTED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000491
======================================================================
Reported By:                derekfountain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     491
Category:                   ISA - sb16/sbawe
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-09-2004 08:17 CEST
Last Modified:              09-09-2004 08:17 CEST
======================================================================
Summary:                    Corrupted sounds recorded after using mjpeg's glav utility
Description: 
Running a standard, self compiled 2.6.7 kernel on top of SUSE-9.1 for IA32.
Dual PIII-500 box with an old ISA Sound Blaster 16 card. Also mjpegtools
1.6.2 (tried SUSE's and my own self compiled version).

The problem is corrupted sound being recorded. The underlying sound is
there - you can hear the conversation, or whatever - but over the top
there is a pulsing crackle. The crackle pulses every second or so.

The corruption only happens after the mjpeg "glav" playback utility is
used. That is, run "lavrec" to record video/sound , and it's OK. Play it
back using "glav" and it sounds fine. Now run "lavrec" again and what gets
recorded has this sound corruption.

If I ensure the sound system is reset (rcaslasound restart) before I run
"lavrec" the sound comes out fine, so at least I have a workaround.

The mjpeg guys acknowledge they do some funky stuff to get the best from
the sound hardware, and indeed, if I playback using mplayer then try
"lavrec" a second time it doesn't corrupt the sound. Something in glav is
upsetting the ISA sound blaster driver. No other sound card has (yet) been
found which suffers the same problem. OSS on a 2.4 kernel always worked
flawlessly on this machine.

I'm not up on the sound system - it "just worked" in the past. I'm not
even sure what modules I'm using. The sound system worked fine out of the
SUSE box until I came across this problem. My modules list:

# lsmod
Module                  Size  Used by
iptable_filter          3200  0
ip_tables              18560  1 iptable_filter
udf                    90372  0
snd_seq_oss            35712  0
snd_pcm_oss            63912  0
snd_mixer_oss          21504  1 snd_pcm_oss
snd_seq_midi            9888  0
snd_seq_midi_event      8064  2 snd_seq_oss,snd_seq_midi
snd_opl3_synth         17796  0
snd_seq_instr           9600  1 snd_opl3_synth
snd_seq_midi_emul       8576  1 snd_opl3_synth
snd_seq                59024  9
snd_seq_oss,snd_seq_midi,snd_seq_midi_event,snd_opl3_synth,snd_seq_instr,snd_seq_midi_emul
snd_ainstr_fm           3072  1 snd_opl3_synth
snd_sb16               15340  4
snd_opl3_lib           12416  2 snd_opl3_synth,snd_sb16
snd_sb16_dsp           13440  1 snd_sb16
snd_pcm               108804  2 snd_pcm_oss,snd_sb16_dsp
snd_timer              28932  3 snd_seq,snd_opl3_lib,snd_pcm
snd_sb16_csp           22528  1 snd_sb16
snd_sb_common          17408  3 snd_sb16,snd_sb16_dsp,snd_sb16_csp
snd_hwdep              10628  2 snd_opl3_lib,snd_sb16_csp
snd_mpu401_uart         8832  1 snd_sb16
snd_rawmidi            27300  2 snd_seq_midi,snd_mpu401_uart
snd_seq_device          9224  6
snd_seq_oss,snd_seq_midi,snd_opl3_synth,snd_seq,snd_opl3_lib,snd_rawmidi
snd                    65924  29
snd_seq_oss,snd_pcm_oss,snd_mixer_oss,snd_seq_midi,snd_seq_midi_event,snd_opl3_synth,snd_seq_instr,snd_seq_midi_emul,snd_seq,snd_sb16,snd_opl3_lib,snd_sb16_dsp,snd_pcm,snd_timer,snd_sb16_csp,snd_sb_common,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
nls_cp437               6144  1
nls_iso8859_1           4480  1
smbfs                  67064  2
parport_pc             38720  1
lp                     11144  0
parport                40648  2 parport_pc,lp
edd                    10904  0
joydev                 10048  0
sg                     38432  0
sr_mod                 17572  0
ide_cd                 40992  0
cdrom                  38044  2 sr_mod,ide_cd
nvram                   9608  0
intel_agp              19100  1
agpgart                33580  1 intel_agp
uhci_hcd               31504  0
snd_page_alloc         12680  1 snd_pcm
soundcore               9824  1 snd
ipv6                  252128  36
tulip                  47264  0
zr36060                10124  1
adv7175                 6664  0
saa7110                 8200  0
zr36067               134140  0
i2c_algo_bit            9480  1 zr36067
i2c_core               24320  3 adv7175,saa7110,i2c_algo_bit
videocodec              8468  2 zr36060,zr36067
pwcx                   91648  0
pwc                    51952  1 pwcx
usbcore               109536  4 uhci_hcd,pwc
videodev                9984  2 zr36067,pwc
dm_mod                 43680  4
reiserfs              256464  4
aic7xxx               189624  2
sd_mod                 21760  3
scsi_mod              117060  4 sg,sr_mod,aic7xxx,sd_mod

======================================================================

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-09-04 08:17 derekfountain  New Bug                                      
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
