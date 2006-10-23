From: Dimitri Van Landuyt <dimitri.vanlanduyt@gmail.com>
Subject: hda-intel on msi megabook
Date: Mon, 23 Oct 2006 09:28:03 +0200
Message-ID: <ehhqu3$mhi$1@sea.gmane.org>
Reply-To: dimitri.vanlanduyt@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I own a MSI Megabook S420 notebook and I am having the following
problem:

hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...

and possibly related:

hda-intel: Invalid position buffer, using LPIB read method instead.

in my dmesg.

The sound used to work through my speakers, but recently it stopped 
working and now and then it crackles, which I expect to be a result of a 
not correctly supported card. It still works fine through headphones and 
microphones and everything else works fine.

More info about my device:

00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
          Subsystem: ATI Technologies Inc Unknown device 437b
          Flags: bus master, slow devsel, latency 64, IRQ 201
          Memory at febf8000 (64-bit, non-prefetchable) [size=16K]
          Capabilities: [50] Power Management version 2
          Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable

$ ls -R  /proc/asound/card0/
/proc/asound/card0/:
codec#0  codec#1  id  oss_mixer  pcm0c  pcm0p  pcm1p  pcm2c  pcm6c  pcm6p

/proc/asound/card0/pcm0c:
info  oss  sub0  sub1

/proc/asound/card0/pcm0c/sub0:
hw_params  info  prealloc  status  sw_params

/proc/asound/card0/pcm0c/sub1:
hw_params  info  prealloc  status  sw_params

/proc/asound/card0/pcm0p:
info  oss  sub0

/proc/asound/card0/pcm0p/sub0:
hw_params  info  prealloc  status  sw_params

/proc/asound/card0/pcm1p:
info  oss  sub0

/proc/asound/card0/pcm1p/sub0:
hw_params  info  prealloc  status  sw_params

/proc/asound/card0/pcm2c:
info  sub0  sub1

/proc/asound/card0/pcm2c/sub0:
hw_params  info  prealloc  status  sw_params

/proc/asound/card0/pcm2c/sub1:
hw_params  info  prealloc  status  sw_params

/proc/asound/card0/pcm6c:
info  sub0

/proc/asound/card0/pcm6c/sub0:
hw_params  info  prealloc  status  sw_params

/proc/asound/card0/pcm6p:
info  sub0

/proc/asound/card0/pcm6p/sub0:
hw_params  info  prealloc  status  sw_params


$ lsmod | grep snd
snd_hda_intel          20116  4
snd_hda_codec         164608  1 snd_hda_intel
snd_pcm_oss            47360  0
snd_mixer_oss          19584  1 snd_pcm_oss
snd_pcm                84612  4 snd_hda_intel,snd_hda_codec,snd_pcm_oss
snd_timer              25348  2 snd_pcm
snd                    58372  12 
snd_hda_intel,snd_hda_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
soundcore              11232  1 snd
snd_page_alloc         11400  2 snd_hda_intel,snd_pcm



So I would really like to help adding support for this device in your
hda-intel driver, or at least provide enough info for some of you guys
to do it!

Best regards,

Dimitri


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
