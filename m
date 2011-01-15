From: "torsten.schenk" <torsten.schenk@zoho.com>
Subject: Card driver: device or resource busy
Date: Sat, 15 Jan 2011 10:11:47 -0800
Message-ID: <12d8ae03d3b.-1810748071142587921.-87582792196928800@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id C5D5124392
	for <alsa-devel@alsa-project.org>; Sat, 15 Jan 2011 19:11:52 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I'm currently developing a driver for a card. PCM playback works so far, I just encountered some playback issues when firefox (flash) and another alsa client wanted to play back at the same time. I figured out that the difference between my driver and existing ones is, that my driver only allows one client and others multiple. I get a "Device or resource busy" when I play back two times the same file (also different ones of course) with mplayer f.ex.

I was able to track this down to the fact, that (only) the O_APPEND Flag is missing in file-&gt;f_flags (snd_pcm_attach_substream), but was completely unable to find out where this flag comes from in other drivers.
 
Another point (perhaps not unrelated to this) is, that I get a bug (see below) that seems to tell me, that prepare cannot schedule. Contrary to the documentation that says that prepare is now non-atomic. It is useful to wait in the prepare function since I need to set the sample rate and wait for a reply (USB device). Before I rewrite it, i wanted to ask about atomicity in prepare on this ML.

Greetings,
Torsten

[ 3662.318321] usb 1-2: unlink qh0-00ff/f69a5300 start 0 [2/0 us]
[ 3662.318434] BUG: scheduling while atomic: aplay/17902/0x00000002
[ 3662.318435] Modules linked in: snd_usb_6fire snd_rawmidi snd_seq_device snd_pcm snd_timer snd soundcore snd_page_alloc nvidia(P) [last unloaded: soundcore]
[ 3662.318443] Pid: 17902, comm: aplay Tainted: P            2.6.36-gentoo-r5 #3
[ 3662.318445] Call Trace:
[ 3662.318448]  [&lt;c1025fa0&gt;] __schedule_bug+0x48/0x4d
[ 3662.318451]  [&lt;c136f438&gt;] schedule+0x9d/0x6b6
[ 3662.318454]  [&lt;c10383f6&gt;] ? __mod_timer+0xf5/0x100
[ 3662.318457]  [&lt;c136fc83&gt;] schedule_timeout+0x73/0x90
[ 3662.318460]  [&lt;c1037ffe&gt;] ? process_timeout+0x0/0xa
[ 3662.318463]  [&lt;fa335622&gt;] pcm_alsa_prepare+0x353/0x3a5 [snd_usb_6fire]
[ 3662.318467]  [&lt;c1043121&gt;] ? autoremove_wake_function+0x0/0x2f
[ 3662.318472]  [&lt;fa2fb700&gt;] snd_pcm_do_prepare+0xc/0x1c [snd_pcm]
[ 3662.318476]  [&lt;fa2fb4d3&gt;] snd_pcm_action_single+0x25/0x4b [snd_pcm]
[ 3662.318481]  [&lt;fa2fc4cc&gt;] snd_pcm_action_nonatomic+0x42/0x55 [snd_pcm]
[ 3662.318486]  [&lt;fa2fe0c9&gt;] snd_pcm_common_ioctl1+0x379/0xa19 [snd_pcm]
[ 3662.318489]  [&lt;c1086437&gt;] ? find_get_page+0x6b/0x74
[ 3662.318492]  [&lt;c10259f4&gt;] ? get_parent_ip+0xb/0x31
[ 3662.318497]  [&lt;fa2fed24&gt;] snd_pcm_playback_ioctl1+0x2d4/0x2eb [snd_pcm]
[ 3662.318500]  [&lt;c1168866&gt;] ? file_has_perm+0x7c/0x85
[ 3662.318505]  [&lt;fa2fed5b&gt;] snd_pcm_playback_ioctl+0x20/0x2d [snd_pcm]
[ 3662.318513]  [&lt;fa2fed3b&gt;] ? snd_pcm_playback_ioctl+0x0/0x2d [snd_pcm]
[ 3662.318515]  [&lt;c10b9e1a&gt;] do_vfs_ioctl+0x43c/0x481
[ 3662.318519]  [&lt;c1168a26&gt;] ? selinux_file_ioctl+0x3e/0x41
[ 3662.318522]  [&lt;c10b9ea0&gt;] sys_ioctl+0x41/0x61
[ 3662.318525]  [&lt;c100278c&gt;] sysenter_do_call+0x12/0x22
