From: cliffw@easystreet.com
Subject: usb-audio - kernel oops 2.5.72
Date: Sun, 22 Jun 2003 20:45:09 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306230345.h5N3j9RT030049@oldred.easystreet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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


Am attempting to get linux-2.5.72 + snd-usb-audio happening.
Results have been poor. Machine is VIA C3, ALSA + jack working 
fine with the built-in via audio. Tried various kernels, 
real ugly failures with 2.5.70, also have tried 2.5.72-mm2. 

So far, this is the best I can do:

JACK compiled with System V SHM support
loading driver ..
creating alsa driver ... usb-audio|1024|3|44100|swmon|swmeter|soft-mode
open
Rectangular dithering at 16 bits
port alsa_pcm:capture_1 has mixdown = 0x40017e70
port alsa_pcm:capture_2 has mixdown = 0x40017e70
port alsa_pcm:playback_1 has mixdown = 0x40017e70
port alsa_pcm:playback_2 has mixdown = 0x40017e70
starting engine
ALSA lib pcm_hw.c:494:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: Broken 
pipe
could not start playback (Broken pipe)
cannot start driver
cannot start main JACK thread
jack main caught signal 15

-----------------------------
With this oops in dmesg:
-----------------------------
bad: scheduling while atomic!
Call Trace:
 [<c01175a0>] schedule+0x410/0x420
 [<c01218e2>] add_timer+0x52/0x90
 [<c01224d5>] schedule_timeout+0x55/0xa0
 [<c0122470>] process_timeout+0x0/0x10
 [<c02ebf97>] usb_start_wait_urb+0x97/0x1b0
 [<c0117600>] default_wake_function+0x0/0x20
 [<c0117600>] default_wake_function+0x0/0x20
 [<c02ec106>] usb_internal_control_msg+0x56/0x70
 [<c02ec1a1>] usb_control_msg+0x81/0xa0
 [<c0345f46>] init_usb_sample_rate+0xb6/0x130
 [<c0346141>] set_format+0x181/0x2f0
 [<c03462fe>] snd_usb_pcm_prepare+0x1e/0x40
 [<c0321f3c>] snd_pcm_do_prepare+0xc/0x40
 [<c03214a0>] snd_pcm_action_group+0xa0/0x160
 [<c0321642>] snd_pcm_action_lock_irq+0x32/0xa0
 [<c0321fe2>] snd_pcm_prepare+0x42/0x60
 [<c03241ac>] snd_pcm_playback_ioctl1+0x4c/0x400
 [<c021d8b0>] write_chan+0x0/0x240
 [<c014c4c0>] vfs_write+0xb0/0x100
 [<c015d9f0>] sys_ioctl+0xf0/0x270
 [<c014c5a6>] sys_write+0x46/0x50
 [<c0109067>] syscall_call+0x7/0xb

ALSA sound/usb/usbaudio.c:682: cannot submit datapipe for urb 0, err = -22
----------------------

More data, config files on request.
cliffw





-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
