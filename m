From: Amaury Jacquot <sxpert@esitcom.org>
Subject: kernel 2.6 bug
Date: Thu, 18 Dec 2003 22:26:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE21B72.8090200@esitcom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

hi
I tried the 2.6 kernel today, and have a bug

using snd-usb-audio with the oss emulation I use a gstreamer based 
player (I know, I could use alsasink) :D

notes:
* uhci USB
* no modules support (everything in)
* preemptible kernel on

when preemptible is off, I only get the

"cannot submit datapipe for urb <blah>" messages as shown below

restarting the application gives sound again

the application works in 2.4.23 with alsa 1.0.0-rc2

I get the following trace :

bad: scheduling while atomic!
Call Trace:
  [<c011bdea>] schedule+0x70a/0x710
  [<c028ce43>] snd_pcm_oss_get_formats+0x23/0xc0
  [<c011a206>] recalc_task_prio+0xb6/0x220
  [<c011c0ec>] wait_for_completion+0x8c/0xf0
  [<c011be40>] default_wake_function+0x0/0x20
  [<c011be40>] default_wake_function+0x0/0x20
  [<c0261871>] hcd_unlink_urb+0x1a1/0x2b0
  [<c02a78e0>] snd_complete_urb+0x0/0xa0
  [<c02615c0>] hcd_submit_urb+0x110/0x190
  [<c026218a>] usb_unlink_urb+0x2a/0x30
  [<c02a7ad8>] deactivate_urbs+0xb8/0xc0
  [<c02a7d08>] snd_usb_pcm_trigger+0x58/0x60
  [<c02963b9>] snd_pcm_do_stop+0x19/0x20
  [<c0296002>] snd_pcm_action_single+0x22/0x50
  [<c0296120>] snd_pcm_action+0xf0/0x100
  [<c0296444>] snd_pcm_stop+0x14/0x20
  [<c029ac9d>] snd_pcm_update_hw_ptr+0x13d/0x1e0
  [<c029e785>] snd_pcm_lib_write1+0x5d5/0x5f0
  [<c0292d41>] resample_expand+0x271/0x340
  [<c0292dcf>] resample_expand+0x2ff/0x340
  [<c029e812>] snd_pcm_lib_write+0x72/0xa0
  [<c029e0f0>] snd_pcm_lib_write_transfer+0x0/0xc0
  [<c028c090>] snd_pcm_oss_write3+0x50/0xb0
  [<c0290721>] snd_pcm_plug_write_transfer+0x81/0xf0
  [<c028c421>] snd_pcm_oss_write2+0xb1/0x130
  [<c028c668>] snd_pcm_oss_write1+0x1c8/0x200
  [<c0299aa7>] snd_pcm_kernel_playback_ioctl+0x27/0x30
  [<c028e6c6>] snd_pcm_oss_write+0x36/0x50
  [<c0152f6c>] vfs_write+0x9c/0x100
  [<c015304d>] sys_write+0x2d/0x50
  [<c01092f7>] syscall_call+0x7/0xb

bad: scheduling while atomic!
Call Trace:
  [<c011bdea>] schedule+0x70a/0x710
  [<c011a206>] recalc_task_prio+0xb6/0x220
  [<c011c0ec>] wait_for_completion+0x8c/0xf0
  [<c011be40>] default_wake_function+0x0/0x20
  [<c011be40>] default_wake_function+0x0/0x20
  [<c0261871>] hcd_unlink_urb+0x1a1/0x2b0
  [<c02a78e0>] snd_complete_urb+0x0/0xa0
  [<c02615c0>] hcd_submit_urb+0x110/0x190
  [<c026218a>] usb_unlink_urb+0x2a/0x30
  [<c02a7ad8>] deactivate_urbs+0xb8/0xc0
  [<c02a7d08>] snd_usb_pcm_trigger+0x58/0x60
  [<c02963b9>] snd_pcm_do_stop+0x19/0x20
  [<c0296002>] snd_pcm_action_single+0x22/0x50
  [<c0296120>] snd_pcm_action+0xf0/0x100
  [<c0296444>] snd_pcm_stop+0x14/0x20
  [<c029ac9d>] snd_pcm_update_hw_ptr+0x13d/0x1e0
  [<c029e785>] snd_pcm_lib_write1+0x5d5/0x5f0
  [<c0292d41>] resample_expand+0x271/0x340
  [<c0292dcf>] resample_expand+0x2ff/0x340
  [<c029e812>] snd_pcm_lib_write+0x72/0xa0
  [<c029e0f0>] snd_pcm_lib_write_transfer+0x0/0xc0
  [<c028c090>] snd_pcm_oss_write3+0x50/0xb0
  [<c0290721>] snd_pcm_plug_write_transfer+0x81/0xf0
  [<c028c421>] snd_pcm_oss_write2+0xb1/0x130
  [<c028c668>] snd_pcm_oss_write1+0x1c8/0x200
  [<c0299aa7>] snd_pcm_kernel_playback_ioctl+0x27/0x30
  [<c028e6c6>] snd_pcm_oss_write+0x36/0x50
  [<c0152f6c>] vfs_write+0x9c/0x100
  [<c015304d>] sys_write+0x2d/0x50
  [<c01092f7>] syscall_call+0x7/0xb

cannot submit datapipe for urb 0, err = -22
cannot submit datapipe for urb 0, err = -22
cannot submit datapipe for urb 0, err = -22
cannot submit datapipe for urb 1, err = -22
cannot submit datapipe for urb 0, err = -22
cannot submit datapipe for urb 1, err = -22
cannot submit datapipe for urb 0, err = -22
cannot submit datapipe for urb 1, err = -22



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
