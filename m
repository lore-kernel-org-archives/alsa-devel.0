From: William <walsac3@liam2.demon.co.uk>
Subject: alsa-driver-1.0.3 always FATAL modprobe error from race?
Date: Fri, 26 Mar 2004 13:25:04 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403261325.NAA08465@liam2.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

alsa-driver-1.0.3 with Linux 2.6.4 always has a FATAL modprobe error
when loading the ALSA modules for the first time.  However, if you remove
the ALSA modules and then immediately re-load them, there is never an error
and ALSA works ok.  Is this a bug or a modprobe.conf problem?
Exactly the same modules are loaded both when ALSA fails and when ALSA works.
However, even though exactly the same modules are loaded,
the module usage-counts change for both snd-pcm-oss and snd-emu8000-synth
from u.count == 1 when ALSA fails to u.count == 2 when ALSA works.
This is the only visible difference.
When you load the ALSA modules and then immediately remove them,
the ALSA-module file images are kept in the kernel cache,
so the next time you try loading the ALSA modules the kernel does not have
to wait for any disk I/O because the file image is almost instantly available
from kernel cache.  This difference in module loading times
seems to be the trigger for the problem.
Is there a race condition between the ALSA modules?

William

 $ reboot

# After rebooting:

 $ lsmod | sort # the initial modules
Module                  Size  Used by
pcspkr                  3422  0 

 $ alsamixer # causes ALSA modules to be loaded
             # according to /etc/modprobe.conf (see below)

 $ lsmod | sort > lsmod-alsa-failed # modules failed

 $ rmmod-alsa.sh # script removes ALSA modules
                 # but kernel keeps module files in its cache

 $ alsamixer

 $ lsmod | sort > lsmod-alsa-worked (see below)

 $ diff lsmod-alsa-failed lsmod-alsa-worked # only module usage-counts differ

Module                  Size  Used by
25c25
< snd_mixer_oss          17312  1 snd_pcm_oss
---
> snd_mixer_oss          17312  2 snd_pcm_oss
36c36
< snd_sbawe              28928  1 snd_emu8000_synth
---
> snd_sbawe              28928  2 snd_emu8000_synth

 $ grep -E sound\|snd /etc/modprobe.conf
alias char-major-14-* soundcore
alias char-major-116-* snd
alias snd-card-0 snd-sbawe
alias sound-slot-0 snd-sbawe
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
options snd major=116 cards_limit=1
options snd-sbawe index=0
install snd-sbawe /sbin/modprobe --first-time --ignore-install snd-sbawe && { /sbin/modprobe snd-opl3-lib; /sbin/modprobe snd-timer; /sbin/modprobe snd-emux-synth; /sbin/modprobe snd-emu8000-synth; /sbin/modprobe snd-seq-dummy; /sbin/modprobe snd-pcm-oss; /sbin/modprobe snd-mixer-oss; /sbin/modprobe snd-seq-oss; /sbin/modprobe snd-opl3-synth; /bin/true; }
install snd-seq-virmidi /sbin/modprobe --first-time --ignore-install snd-seq-virmidi && { /sbin/modprobe snd-virmidi; /bin/true; }
install snd-mixer-oss /sbin/modprobe --first-time --ignore-install snd-mixer-oss && { /usr/sbin/aumix -f /usr/etc/aumixrc -L; /bin/true; }
remove snd-sbawe { /sbin/modprobe -r snd-pcm-oss; /sbin/modprobe -r snd-mixer-oss; /sbin/modprobe -r snd-seq-oss; /sbin/modprobe -r snd-opl3-synth; } ; /sbin/modprobe -r --first-time --ignore-remove snd-sbawe

 $ cat lsmod-alsa-worked

Module                  Size  Used by
pcspkr                  3422  0 
snd                    52404  24 snd_pcm_oss,snd_mixer_oss,snd_seq_dummy,snd_emu8000_synth,snd_emux_synth,snd_virmidi,snd_seq_virmidi,snd_util_mem,snd_seq_oss,snd_seq_midi_event,snd_opl3_synth,snd_seq_instr,snd_seq,snd_sbawe,snd_opl3_lib,snd_sb16_dsp,snd_pcm,snd_timer,snd_sb16_csp,snd_sb_common,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
snd_ainstr_fm           2568  1 snd_opl3_synth
snd_emu8000_synth      14722  0 
snd_emux_synth         34686  1 snd_emu8000_synth
snd_hwdep               8960  3 snd_emux_synth,snd_opl3_lib,snd_sb16_csp
snd_mixer_oss          17008  2 snd_pcm_oss
snd_mpu401_uart         7168  1 snd_sbawe
snd_opl3_lib            9888  2 snd_opl3_synth,snd_sbawe
snd_opl3_synth         14400  0 
snd_page_alloc         11364  1 snd_pcm
snd_pcm                92604  3 snd_pcm_oss,snd_emu8000_synth,snd_sb16_dsp
snd_pcm_oss            48644  0 
snd_rawmidi            23264  2 snd_seq_virmidi,snd_mpu401_uart
snd_sb16_csp           19322  1 snd_sbawe
snd_sb16_dsp           10710  1 snd_sbawe
snd_sb_common          14848  3 snd_sbawe,snd_sb16_dsp,snd_sb16_csp
snd_sbawe              28518  2 snd_emu8000_synth
snd_seq                50000  10 snd_seq_dummy,snd_emux_synth,snd_seq_virmidi,snd_seq_oss,snd_seq_midi_event,snd_opl3_synth,snd_seq_instr,snd_seq_midi_emul
snd_seq_device          7716  8 snd_emu8000_synth,snd_emux_synth,snd_seq_oss,snd_opl3_synth,snd_seq,snd_sbawe,snd_opl3_lib,snd_rawmidi
snd_seq_dummy           3072  0 
snd_seq_instr           8352  1 snd_opl3_synth
snd_seq_midi_emul       7264  2 snd_emux_synth,snd_opl3_synth
snd_seq_midi_event      7296  2 snd_seq_virmidi,snd_seq_oss
snd_seq_oss            31104  0 
snd_seq_virmidi         7072  2 snd_emux_synth,snd_virmidi
snd_timer              24222  3 snd_seq,snd_opl3_lib,snd_pcm
snd_util_mem            4610  2 snd_emu8000_synth,snd_emux_synth
snd_virmidi             3758  0 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
