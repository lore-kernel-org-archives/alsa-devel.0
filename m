From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
Subject: cs46xx record (thinkpad A22) => deadlock
Date: Mon, 28 Oct 2002 18:30:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DBD743A.9070008@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Good news everyone!

I installed the new alsa-driver-0.9rc5 driver for my cs46xx and the 
hardware mixing is just great! *woooohoooo* But the important thing is 
that I have to report a bug. Since I play a lot around with VoIP I found 
out that the opening of the record device (OSS-Emulation) sometimes 
deadlocks my system. To me it looks like the kernel is stuck in an 
infinite loop and never returning from the sys_read(). (Hmm, I guess it 
is not the open(), but the first read() then...) Using SysRq+P I made 
the following stack-trace:

Adhoc d8889647 <[snd-pcm]snd_pcm_lib_read+73/88>
Adhoc d8889647 <[snd-pcm]snd_pcm_lib_read+73/88>
Adhoc d88891fc <[snd-pcm]snd_pcm_lib_read_transfer+0/7c>
Adhoc d888fe11 <[snd-pcm-oss]snd_pcm_oss_read3+79/ac>
Adhoc d8894216 <[snd-pcm-oss]io_capture_transfer+26/70>
Adhoc d8893ad7 <[snd-pcm-oss]snd_pcm_plug_read_transfer+8b/ac>
Adhoc d88901f4 <[snd-pcm-oss]snd_pcm_oss_read2+70/d8>
Adhoc d889037e <[snd-pcm-oss]snd_pcm_oss_read1+122/150>
Adhoc d8891e82 <[snd-pcm-oss]snd_pcm_oss_read+1e/28>
Adhoc c012efb6 <sys_read+96/e4>
Adhoc c0106d2b <system_call+33/38>

At that time the box only reacts on pings and SysRq keys. No HD I/O when 
I do an emergency sync, no console switching,... It does not matter if I 
set thinkpad=1 or not. I am running kernel 2.4.18 (vanilla) on Debian Woody.
The shortest stack-trace was up to io_capture_transfer or so. Is there a 
bug in the OSS-Emulation? Any ideas?

greetings,
Wilfried
-- 
BSc Ing. Wilfried Weissmann           mailto: Wilfried.Weissmann@gmx.at
Benedikt-Schellingergasse 18/19a      Tel.: +43 1 78 64 739
1150 Wien                             Mobil: +43 676 944 44 65



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
