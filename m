From: Dave Phillips <dlphilp@linux-sound.org>
Subject: problem with ALSA 1.09 and 2.6 kernel (AGNULA/Demudi)
Date: Wed, 27 Jul 2005 08:34:13 -0400
Message-ID: <42E77F45.9090307@linux-sound.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

Greetings:

  Here's the hardware:

    HP Omnibook 4150 with NeoMagic NM256AV media chipset
    Midisport 2x2 USB MIDI interface
    CoreSound PDAudioCF PCMCIA digital audio input card

  Here's the software:

    AGNULA/Demudi 1.2.1 with 2.6.12 multimedia kernel
    ALSA 1.0.9rc2

  Here's the trouble:

    Although the snd-nm256 module loads without complaint 'cat 
/proc/asound/cards' reports no soundcards in the system. Ditto if I load 
the snd-pcaudiocf module. Still no soundcard. I'll try loading the 
Midisport after I get basic services working. :)

    I've tried loading the snd-cs4232 module instead (I've used it for 
this machine under the 2.4 kernels with no troubles) but it fails with 
these messages:

    demudi:/home/dlphilp# modprobe snd-cs4232
    FATAL: Error inserting snd_cs4232    
    
(/lib/modules/2.6.12-3-multimedia-686/kernel/sound/isa/cs423x/snd-cs4232.ko): 
No such device
    FATAL: Error running install command for snd_cs4232

  I've appended relevant messages from dmesg and lsmod below. I'm not in 
a rush to get this working and I'm willing to spend time on it, so any 
suggestions will be greatly appreciated. Guenter Geiger suggested that I 
may need to load some extra kernel options but at this time I don't know 
which to try. Any advice out there ? :)

Best regards,

Dave Phillips

demudi:/home/dlphilp# lsmod |grep snd
snd_pdaudiocf          17988  0
snd_ak4117             10240  1 snd_pdaudiocf
snd_nm256              70368  0
snd_ac97_codec         83320  1 snd_nm256
snd_ad1848_lib         17920  0
pcmcia                 28480  7 snd_pdaudiocf,serial_cs,pcnet_cs
pcmcia_core            52628  6 
snd_pdaudiocf,serial_cs,pcnet_cs,pcmcia,yenta_socket,rsrc_nonstatic
snd_opl3_lib           11648  0
snd_hwdep               9632  1 snd_opl3_lib
snd_cs4231_lib         27776  0
snd_pcm_oss            53792  0
snd_mixer_oss          19200  1 snd_pcm_oss
snd_pcm                96580  7 
snd_pdaudiocf,snd_ak4117,snd_nm256,snd_ac97_codec,snd_ad1848_lib,snd_cs4231_lib,snd_pcm_oss
snd_page_alloc         10116  2 snd_cs4231_lib,snd_pcm
snd_mpu401_uart         8832  0
snd_seq_dummy           3844  0
snd_seq_oss            36416  0
snd_seq_midi            9248  0
snd_rawmidi            26400  2 snd_mpu401_uart,snd_seq_midi
snd_seq_midi_event      8320  2 snd_seq_oss,snd_seq_midi
snd_seq                55888  9 
snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_timer              26148  4 snd_opl3_lib,snd_cs4231_lib,snd_pcm,snd_seq
snd_seq_device          8716  6 
snd_opl3_lib,snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_rawmidi,snd_seq
snd                    58404  18 
snd_pdaudiocf,snd_ak4117,snd_nm256,snd_ac97_codec,snd_ad1848_lib,snd_opl3_lib,snd_hwdep,snd_cs4231_lib,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_mpu401_uart,snd_seq_oss,snd_rawmidi,snd_seq,snd_timer,snd_seq_device
soundcore              10624  1 snd

demudi:/home/dlphilp# dmesg |grep CS4232
CS4232 soundcard not found or device busy

demudi:/home/dlphilp# dmesg |grep acpi 
shpchp: acpi_shpchprm:get_device PCI ROOT HID fail=0x1001




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
