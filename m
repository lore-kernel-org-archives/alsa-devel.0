From: Anders Johansson <ajh@watri.org.au>
Subject: Bad sceduling for VXPocket 440
Date: Wed, 19 May 2004 16:36:39 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040519083639.GN32181@watri.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi,

Soundcard: VXPocket 440
Kernel version: 2.6.6 w. preemtive multitasking
lib alsa version: 1.0.4

When I terminate arecord or aplay I get the following errors:

bad: scheduling while atomic!
Call Trace:
[<c028efd3>] schedule+0x5c3/0x5d0
[<c010b025>] timer_interrupt+0xb5/0xf0
[<c011c25e>] __mod_timer+0xce/0x180
[<c028f448>] schedule_timeout+0x58/0xb0
[<c011cd00>] process_timeout+0x0/0x10
[<c803b717>] vx_toggle_pipe+0xb7/0x110 [snd_vx_lib]
[<c803be9d>] vx_pcm_trigger+0x6d/0xd0 [snd_vx_lib]
[<c804ad49>] snd_pcm_do_stop+0x19/0x20 [snd_pcm]
[<c804a992>] snd_pcm_action_single+0x22/0x50 [snd_pcm]
[<c804aa18>] snd_pcm_action+0x58/0x60 [snd_pcm]
[<c804add4>] snd_pcm_stop+0x14/0x20 [snd_pcm]
[<c804b5c3>] snd_pcm_playback_drop+0xb3/0x100 [snd_pcm]
[<c804c765>] snd_pcm_release+0x25/0xa0 [snd_pcm]
[<c0141e24>] __fput+0xb4/0xd0
[<c0140853>] filp_close+0x43/0x70
[<c0116a67>] put_files_struct+0x67/0xc0
[<c011762c>] do_exit+0x17c/0x340
[<c011787f>] do_group_exit+0x2f/0xa0
[<c011f294>] get_signal_to_deliver+0x254/0x350
[<c0105824>] do_signal+0x54/0xd0
[<c804ccc9>] snd_pcm_hwsync+0x39/0x90 [snd_pcm]
[<c804d186>] snd_pcm_playback_ioctl1+0xc6/0x340 [snd_pcm]
[<c01519f4>] poll_freewait+0x44/0x50
[<c0151350>] sys_ioctl+0xe0/0x240
[<c01058d7>] do_notify_resume+0x37/0x40
[<c0105afe>] work_notifysig+0x13/0x15

Cheers,
//Anders




-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
