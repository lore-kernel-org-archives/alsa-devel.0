From: laurent.ml@linuxfr.org
Subject: Re: Re: [Alsa-user] sb live dma buffer alloc failure?
Date: Sat, 08 Feb 2003 17:10:02 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <wazza.87znp6pul1.fsf@message.id>
References: <3E40BA0F.9070600@ece.cornell.edu> <s5hadh8e23e.wl@alsa2.suse.de>
	<3E440D06.8090803@ece.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E440D06.8090803@ece.cornell.edu> ("Brian J. Tarricone"'s
 message of "Fri, 07 Feb 2003 14:46:14 -0500")
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

"Brian J. Tarricone" <bjt23@ece.cornell.edu> writes:

Hi,

I made some tests.
The config was:
- HIGHMEM kernel 2.4.21pre4
- amd athlon xp+ 1800, RAM=1Go
- alsa drv rc7
- alsa lib rc7
- alsa utils rc6 (rc7 utils don't compile here)
- xmms 1.2.7 (debian sid)
- alsa-xmms (ALSA 0.9 output plugin for XMMS) 0.9.8 (debian sid)

I couldn't reproduce the problem from a fresh reboot, so I tried to simulate
a high memory usage.

the tests were:
sh -c 'a=1; while true; do echo $a; a=$(($a+1)); aplay ~/empty.wav ; done' and
sh -c 'a=1; while true; do echo $a; a=$(($a+1)); xmms ~/empty.wav ; done'

empty.wav is a ~200ms silence file.

the xmms test was done 2 times, the first time with Oss driver output, and
the second time with Alsa 0.9 driver output.
I didn't mention it before, but I was using xmms + alsa 0.9 driver output
when I got the problem. What about you Brian ?

I was not able to reproduce the problem with both aplay and xmms(oss driver)
loops. Both of them were able to run in these memory usages:
Mem:   1033824k total,   808256k used,   225568k free,    21428k buffers
Swap:   530104k total,   527296k used,     2808k free,    85520k cached

Mem:   1033824k total,  1017000k used,    16824k free,     3068k buffers
Swap:   530104k total,   529276k used,      828k free,    26752k cached

whereas the xmms(alsa drv) loop gave:
ALSA lib pcm_hw.c:297:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed: Cannot allocate memory
2.4.21pre4 don't produce kernel error, whereas 2.4.21pre4aa1 gives
"kernel: __alloc_pages: 0-order allocation failed (gfp=0x21/0)" kind of error.

After the xmms(alsa output) problem, I was able to rmmod alsa modules, then
reload them.

-- 
Laurent


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
