From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: aplay/arecord hang at 44100 Hz
Date: Wed, 12 Feb 2003 10:01:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4A0D51.205@uni-bonn.de>
References: <3E476DD8.7050907@uni-bonn.de>	<s5hu1fbcfyb.wl@alsa2.suse.de>	<3E49291E.7000307@uni-bonn.de> <s5hel6eoilm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hel6eoilm.wl@alsa2.suse.de>
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

Here's a backtrace from gdb:


(gdb) run
Starting program: 
/home/josh/programs/debian/alsa-utils-0.9.0rc7/aplay/aplay ./track_01.wav
[New Thread 16384 (LWP 1875)]
Playing WAVE './track_01.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo

Program received signal SIGTSTP, Stopped (user).
[Switching to Thread 16384 (LWP 1875)]
0x401c7224 in ioctl () from /lib/libc.so.6
(gdb) bt
#0  0x401c7224 in ioctl () from /lib/libc.so.6
#1  0x400947a8 in snd_seq_hw_ops () from /usr/lib/libasound.so.2
#2  0x40057912 in snd_pcm_hw_refine () from /usr/lib/libasound.so.2
#3  0x40055918 in snd_pcm_hw_param_set () from /usr/lib/libasound.so.2
#4  0x40056058 in snd_pcm_hw_param_refine_multiple () from 
/usr/lib/libasound.so.2
#5  0x40063eb7 in _snd_pcm_rate_open () from /usr/lib/libasound.so.2
#6  0x40057698 in snd_pcm_hw_refine_slave () from /usr/lib/libasound.so.2
#7  0x40064625 in _snd_pcm_rate_open () from /usr/lib/libasound.so.2
#8  0x40057912 in snd_pcm_hw_refine () from /usr/lib/libasound.so.2
#9  0x40054723 in snd_pcm_hw_param_set_first () from /usr/lib/libasound.so.2
#10 0x40055d57 in snd_pcm_hw_param_set_near () from /usr/lib/libasound.so.2
#11 0x4004fc4e in snd_pcm_hw_params_set_rate_near () from 
/usr/lib/libasound.so.2
#12 0x0804cdc7 in set_params () at aplay.c:800
#13 0x0804f1b6 in playback_go (fd=7, loaded=0, count=4294967295, 
rtype=2, name=0xbffffca0 "./track_01.wav")
     at aplay.c:1686
#14 0x0804f5d6 in playback (name=0xbffffca0 "./track_01.wav") at 
aplay.c:1807
#15 0x0804c092 in main (argc=2, argv=0xbffffb54) at aplay.c:514
(gdb)




Takashi Iwai wrote:
> At Tue, 11 Feb 2003 17:47:26 +0100,
> Josh Buhl wrote:
> 
>>Hi,
>>
>>
>>>i guess it's a bug of either alsa-lib or aplay, not of the driver.
>>>could you check at which user function the operation stops?
>>>
>>
>>I'll be happy to provide any debugging info I can, but I'm not exactly 
>>sure what you mean by which user function. The error occurs for both 
>>user functions aplay and arecord, or do you mean something else?
> 
> 
> please run aplay from gdb and break the operation to see what the
> program is doing there.
> 
> or, a traditional debugging via printf() can be enough :)
> 
> 
> Takashi
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 

-- 
"When you wake up in the morning, Pooh," said Piglet at last,
"what's the first thing you say to yourself?"

"What's for breakfast?" said Pooh.  "What do you say, Piglet?"

"I say, 'I wonder what's going to happen exciting today?'" said Piglet.

Pooh nodded thoughtfully.  "It's the same thing," he said.

	-- A.A. Milne

-----------------------------------------------------
http://www.nyfairuse.org/

WTO + WIPO = DMCA http://www.anti-dmca.org

Innovation vs Patent Inflation http://swpat.ffii.org/

120000 voices and 400 Firms against logic patents
http://www.noepatents.org/
-----------------------------------------------------




-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
