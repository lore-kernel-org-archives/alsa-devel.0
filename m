From: Johan Bilien <jobi@via.ecp.fr>
Subject: ALSA crash on linux 2.6.0-test9 and USB audio
Date: Thu, 6 Nov 2003 15:14:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031106141429.GA19456@via.ecp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

since I moved from test3 to test9 (test8 would not recognize my usb
headset), I am experiencing a hang in ALSA playback almost everytime I
use my USB headset (Plantronics). In the syslog, I get something like:

Nov  6 15:00:09 naboo kernel: Debug: sleeping function called from
invalid context at kernel/sched.c:1736
Nov  6 15:00:09 naboo kernel: in_atomic():1, irqs_disabled():1
Nov  6 15:00:09 naboo kernel: Call Trace:
Nov  6 15:00:09 naboo kernel:  [__might_sleep+172/224]
__might_sleep+0xac/0xe0
Nov  6 15:00:09 naboo kernel:  [wait_for_completion+32/240]
wait_for_completion+0x20/0xf0
Nov  6 15:00:09 naboo kernel:  [_end+147956939/1070252488]
hcd_unlink_urb+0x163/0x260 [usbcore]
Nov  6 15:00:09 naboo kernel:  [_end+148363464/1070252488]
snd_complete_urb+0x0/0xd0 [snd_usb_audio]
Nov  6 15:00:09 naboo kernel:  [_end+147959157/1070252488]
usb_unlink_urb+0x3d/0x40 [usbcore]
Nov  6 15:00:09 naboo kernel:  [_end+148364069/1070252488]
deactivate_urbs+0xad/0xb0 [snd_usb_audio]
Nov  6 15:00:09 naboo kernel:  [_end+148364682/1070252488]
snd_usb_pcm_trigger+0x52/0x60 [snd_usb_audio]
Nov  6 15:00:09 naboo kernel:  [_end+148280253/1070252488]
snd_pcm_do_stop+0x25/0x30 [snd_pcm]
Nov  6 15:00:09 naboo kernel:  [_end+148279473/1070252488]
snd_pcm_action_single+0x39/0x70 [snd_pcm]
Nov  6 15:00:09 naboo kernel:  [_end+148279640/1070252488]
snd_pcm_action+0x70/0x80 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148280423/1070252488]
snd_pcm_stop+0x1f/0x30 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148300253/1070252488]
snd_pcm_update_hw_ptr+0x145/0x1e0 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [schedule_timeout+109/192]
schedule_timeout+0x6d/0xc0
Nov  6 15:00:10 naboo kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
Nov  6 15:00:10 naboo kernel:  [_end+148292138/1070252488]
snd_pcm_delay+0x52/0x170 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148293276/1070252488]
snd_pcm_playback_ioctl1+0x64/0x4d0 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [sys_poll+642/720] sys_poll+0x282/0x2d0
Nov  6 15:00:10 naboo kernel:  [sys_ioctl+256/672] sys_ioctl+0x100/0x2a0
Nov  6 15:00:10 naboo kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Nov  6 15:00:10 naboo kernel:
Nov  6 15:00:10 naboo kernel: bad: scheduling while atomic!
Nov  6 15:00:10 naboo kernel: Call Trace:
Nov  6 15:00:10 naboo kernel:  [schedule+1445/1456] schedule+0x5a5/0x5b0
Nov  6 15:00:10 naboo kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Nov  6 15:00:10 naboo kernel:  [wait_for_completion+152/240]
wait_for_completion+0x98/0xf0
Nov  6 15:00:10 naboo kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Nov  6 15:00:10 naboo kernel:  [default_wake_function+0/48]
default_wake_function+0x0/0x30
Nov  6 15:00:10 naboo kernel:  [_end+147956939/1070252488]
hcd_unlink_urb+0x163/0x260 [usbcore]
Nov  6 15:00:10 naboo kernel:  [_end+148363464/1070252488]
snd_complete_urb+0x0/0xd0 [snd_usb_audio]
Nov  6 15:00:10 naboo kernel:  [_end+147959157/1070252488]
usb_unlink_urb+0x3d/0x40 [usbcore]
Nov  6 15:00:10 naboo kernel:  [_end+148364069/1070252488]
deactivate_urbs+0xad/0xb0 [snd_usb_audio]
Nov  6 15:00:10 naboo kernel:  [_end+148364682/1070252488]
snd_usb_pcm_trigger+0x52/0x60 [snd_usb_audio]
Nov  6 15:00:10 naboo kernel:  [_end+148280253/1070252488]
snd_pcm_do_stop+0x25/0x30 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148279473/1070252488]
snd_pcm_action_single+0x39/0x70 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148279640/1070252488]
snd_pcm_action+0x70/0x80 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148280423/1070252488]
snd_pcm_stop+0x1f/0x30 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148300253/1070252488]
snd_pcm_update_hw_ptr+0x145/0x1e0 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [schedule_timeout+109/192]
schedule_timeout+0x6d/0xc0
Nov  6 15:00:10 naboo kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
Nov  6 15:00:10 naboo kernel:  [_end+148292138/1070252488]
snd_pcm_delay+0x52/0x170 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [_end+148293276/1070252488]
snd_pcm_playback_ioctl1+0x64/0x4d0 [snd_pcm]
Nov  6 15:00:10 naboo kernel:  [sys_poll+642/720] sys_poll+0x282/0x2d0
Nov  6 15:00:10 naboo kernel:  [sys_ioctl+256/672] sys_ioctl+0x100/0x2a0
Nov  6 15:00:10 naboo kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

and so on. I am using the snd-usb-audio module, with XMMS ALSA output.
Let me know what other details may help you.

-- 
Johan


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
