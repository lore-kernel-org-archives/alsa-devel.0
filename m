From: Francisco Moraes <fmoraes74@netzero.net>
Subject: Re: Help with supporting Emu10k1x  and question
Date: Fri, 27 Feb 2004 15:35:58 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403FAA2E.1040600@netzero.net>
References: <403154C2.3020701@netzero.net>	<s5h3c99yb00.wl@alsa2.suse.de>	<403354B9.8000305@netzero.net>	<s5hd68cwpxa.wl@alsa2.suse.de>	<40340A6B.7080507@netzero.net> <s5h65e2ugga.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65e2ugga.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I seem to be getting closer now. Still no sound, but XMMS is not running 
crazy anymore. Now it hangs after two seconds. Here are some of the 
debug messages I printed:

The start:

Feb 27 14:39:27 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:27 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:27 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:27 localhost kernel: pointer: 00000020 00000000
Feb 27 14:39:27 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:27 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:27 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:27 localhost kernel: pointer: 00000020 00000000
Feb 27 14:39:27 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:27 localhost kernel: pointer: 00000020 00000000
Feb 27 14:39:27 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:27 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:27 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:27 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:27 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:27 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:28 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:28 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:28 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:28 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:28 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:28 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:28 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:28 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:28 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:29 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:29 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:29 localhost kernel: pointer: 00000020 00000000
Feb 27 14:39:29 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:29 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:29 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:29 localhost kernel: pointer: 00000020 00000000
Feb 27 14:39:30 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:30 localhost kernel: pointer: 00000020 00000000
Feb 27 14:39:30 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:30 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:30 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:30 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:30 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:30 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:30 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:31 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:31 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:31 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:31 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:31 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:31 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:31 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:32 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:32 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:32 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:32 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:32 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:32 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:32 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:32 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:32 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:33 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:33 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:33 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
0, pointer = 15304
Feb 27 14:39:33 localhost kernel: trigger - emu10k1 = 0xddb78000, cmd = 
1, pointer = 0
Feb 27 14:39:33 localhost kernel: pointer: 00000000 00000000
Feb 27 14:39:33 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:39:33 localhost kernel: pointer: 00000000 00000000

After a while, it changed to this:

Feb 27 14:41:56 localhost kernel: pointer: 000041E0 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3dc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: pointer: 00004200 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3dc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: pointer: 00004200 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3dc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00008000 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00004020 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3be8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00008000 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00004020 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3be8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00008000 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00004020 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3be8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00008000 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00004020 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3be8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00008000 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00004020 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3be8, buffer_size = 0x4000, 
period_size = 0x40
Feb 27 14:41:56 localhost kernel: PCM interrupt
Feb 27 14:41:56 localhost kernel: pointer: 00008000 00000000
Feb 27 14:41:56 localhost kernel: ptr = 0x3bc8, buffer_size = 0x4000, 
period_size = 0x40

Any suggestions on what I may be missing?

Francisco



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
