From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: kernel-2.5.72: /proc/asound/dev missing
Date: Fri, 20 Jun 2003 14:43:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030620144322.3afea401.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hello,

I just upgraded to kernel 2.5.72 (I want to do some LL testing), with the
alsa driver as included in the kernel. The modules load, but I don't get
/proc/asound/dev (to which, as I understand, /dev/snd should link). I don't
use devfs.

Any suggestions?

Maarten

-----------------------------------------------------------------------------

$ grep SND /usr/src/linux-2.5.72/.config  | grep -v "not set"
CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_VIRMIDI=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_USB_AUDIO=m

$ lsmod
Module                  Size  Used by
snd_emu10k1            60804  0
snd_rawmidi            12160  1 snd_emu10k1
snd_pcm                54528  1 snd_emu10k1
snd_timer              13056  1 snd_pcm
snd_seq_device          4100  2 snd_emu10k1,snd_rawmidi
snd_ac97_codec         34308  1 snd_emu10k1
snd_page_alloc          4484  2 snd_emu10k1,snd_pcm
snd_util_mem            1664  1 snd_emu10k1
snd_hwdep               4352  1 snd_emu10k1
snd                    27296  8 snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep

$ ls -l /proc/asound/
total 0
lrwxrwxrwx    1 root     root            5 Jun 20 14:35 Live -> card0
dr-xr-xr-x    7 root     root            0 Jun 20 14:35 card0
-r--r--r--    1 root     root            0 Jun 20 14:35 cards
-r--r--r--    1 root     root            0 Jun 20 14:35 devices
-r--r--r--    1 root     root            0 Jun 20 14:35 hwdep
-r--r--r--    1 root     root            0 Jun 20 14:35 modules
dr-xr-xr-x    2 root     root            0 Jun 20 14:35 oss
-r--r--r--    1 root     root            0 Jun 20 14:35 pcm
dr-xr-xr-x    2 root     root            0 Jun 20 14:35 seq
-r--r--r--    1 root     root            0 Jun 20 14:35 timers
-r--r--r--    1 root     root            0 Jun 20 14:35 version




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
