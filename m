From: Matt Flax <flatmax@ieee.org>
Subject: snd_usb_audio bad: scheduling while atomic!
Date: Tue, 18 Nov 2003 16:11:04 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031118051104.GA21890@mffm.ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA10538
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2003 04:50:57 +0100
Received: from localhost (antivirus-04.services.comms.unsw.EDU.AU [149.171.193.83])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id hAI3okO18002
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2003 14:50:46 +1100 (EST)
Received: from maillationax ([149.171.36.140])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id hAI3ohc17894
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2003 14:50:44 +1100 (EST)
Received: from flatmax by maillationax with local (Exim 4.22 #1 (Debian))
	id 1ALy8m-0005jG-6f
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2003 16:11:04 +1100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

This doesn't apply to the onboard sound card. only usb.

I get the following when I interrupt my usb soundcard (ctrl-c):
Aborted by signal Interrupt...
bad: scheduling while atomic!
Call Trace:
 [<c011a217>] schedule+0x56b/0x574
 [<c011a478>] wait_for_completion+0x80/0xd0
 [<c011a268>] default_wake_function+0x0/0x18
 [<de9a4d17>] start_urb_unlink+0x1b/0x60 [ohci_hcd]
 [<c011a268>] default_wake_function+0x0/0x18
 [<de9fe436>] hcd_unlink_urb+0x162/0x244 [usbcore]
 [<c010c927>] handle_IRQ_event+0x2f/0x58
 [<dea6d678>] snd_complete_urb+0x0/0x84 [snd_usb_audio]
 [<de9feb92>] usb_unlink_urb+0x2a/0x2c [usbcore]
 [<dea6d827>] deactivate_urbs+0xa3/0xa8 [snd_usb_audio]
 [<dea6da14>] snd_usb_pcm_trigger+0x44/0x48 [snd_usb_audio]
 [<dea578ad>] snd_pcm_do_stop+0x19/0x20 [snd_pcm]
 [<dea57686>] snd_pcm_action_single+0x22/0x40 [snd_pcm]
 [<dea576f4>] snd_pcm_action+0x50/0x58 [snd_pcm]
 [<dea57922>] snd_pcm_stop+0x12/0x18 [snd_pcm]
 [<dea583d7>] snd_pcm_playback_drop+0xd3/0x144 [snd_pcm]
 [<dea59f19>] snd_pcm_playback_ioctl1+0x5d/0x418 [snd_pcm]
 [<c01bfed5>] tty_write+0x14d/0x24c
 [<c015ea87>] dput+0x1b/0x1fc
 [<c014bd0a>] __fput+0xaa/0x104
 [<c015a65e>] sys_ioctl+0xe2/0x24c
 [<c014a86b>] sys_close+0x53/0x80
 [<c010b577>] syscall_call+0x7/0xb

These messages get repeated about 3 times.
I am running kernel 2.6.0 test9
alsa version : Advanced Linux Sound Architecture Driver Version 0.9.7 
(Thu Sep 25 19:16:36 2003 UTC).
Compiled on Oct 26 2003 for kernel 2.6.0-test9-1-386.

Matt

-- 
http://flatmax.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
