From: Paulo Marcel Coelho Aragao <pmcaragao-ag@yahoo.com>
Subject: Tips on debugging ALSA driver snd_es18xx
Date: Wed, 14 Dec 2005 23:34:11 -0200
Message-ID: <20051215013411.GK7983@cortazar>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I recently switched from OSS to ALSA and I'm baffled by this: aplay produces 
sound when playing wav files, but gxine and xmms produce no sound when playing 
streaming audio. I traced them and observed that they accessed sound in the 
same way, calling open() and ioctl() on /dev/snd/pcmC0D0p and 
/dev/snd/controlC0.

I started threads at alsa-user and xine-users which didn't reach a conclusion 
so far. I also tried linux-audio-user and debian-user but nobody replied. Of 
course, long hours googling, too. With the tools and knowledge (lack of) I 
have, I feel I can get no further. I thought of filing a bug (don't know 
against which package, actually) but then, what the heck, I should try doing 
something about it first. Perhaps I spent too much time working with 
commercial software and I still see myself expecting my problem to be solved 
by somebody else. Time to change that and get into the Linux way.

With this frame of mind, I come here asking for guidance: could anybody share 
with me some tips about debugging my ALSA driver, snd_es18xx ? A confession of 
ignorance: I've never hacked a Linux kernel, never compiled Linux software 
from source, for that matter, but I'm willing to learn what it takes to get to 
the bottom of this problem.

I've attached the output of http://alsa.opensrc.org/aadebug.txt, to describe 
my environment.

Thanks
Paulo

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="aadebug.log"

ALSA Audio Debug v0.1.0 - Wed Dec 14 09:50:33 BRDT 2005
http://alsa.opensrc.org/index.php?page=aadebug
http://www.gnu.org/licenses/gpl.txt

Kernel ----------------------------------------------------
Linux cortazar 2.6.14-2-686 #2 Fri Dec 9 10:11:34 UTC 2005 i686 GNU/Linux

Loaded Modules --------------------------------------------
snd_es18xx             31496  1 
snd_pcm_oss            55264  0 
snd_mixer_oss          19808  1 snd_pcm_oss
snd_pcm                92392  2 snd_es18xx,snd_pcm_oss
snd_page_alloc         10952  1 snd_pcm
snd_opl3_lib           10848  1 snd_es18xx
snd_timer              24708  2 snd_pcm,snd_opl3_lib
snd_hwdep               9184  1 snd_opl3_lib
snd_mpu401_uart         7328  1 snd_es18xx
snd_rawmidi            24896  1 snd_mpu401_uart
snd_seq_device          8748  2 snd_opl3_lib,snd_rawmidi
snd                    55940  12 snd_es18xx,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device

Modprobe Conf ---------------------------------------------
alias char-major-14-* soundcore

Proc Asound -----------------------------------------------
Advanced Linux Sound Architecture Driver Version 1.0.10rc1 (Mon Sep 12 08:13:09 2005 UTC).
0 [ES1879         ]: ES1879 - ESS AudioDrive ES1879
                     ESS AudioDrive ES1879 at 0x220, irq 5, dma1 1, dma2 5
  8: [0- 0]: raw midi
  4: [0- 0]: hardware dependent
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer
00-00: OPL3 FM
00-00: ES1879 : ESS AudioDrive ES1879 : playback 2 : capture 1

Dev Snd ---------------------------------------------------
controlC0  hwC0D0  midiC0D0  pcmC0D0c  pcmC0D0p  timer

CPU -------------------------------------------------------
model name	: Celeron (Mendocino)
cpu MHz		: 298.688

RAM -------------------------------------------------------
MemTotal:       159172 kB
SwapTotal:      313256 kB

Hardware --------------------------------------------------
0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (AGP disabled) (rev 03)


--DBIVS5p969aUjpLe--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
