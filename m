From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: Re: aplay/arecord hang at 44100 Hz
Date: Wed, 12 Feb 2003 10:29:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4A140A.7050300@uni-bonn.de>
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

Here's a backtrace after I compiled alsa-lib --with-debug=yes:

Starting program: 
/home/josh/programs/debian/alsa-utils-0.9.0rc7/aplay/aplay ./track_01.wav
[New Thread 16384 (LWP 18251)]
Playing WAVE './track_01.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Stereo

Program received signal SIGTSTP, Stopped (user).
[Switching to Thread 16384 (LWP 18251)]
0x401d0224 in ioctl () from /lib/libc.so.6
(gdb) bt
#0  0x401d0224 in ioctl () from /lib/libc.so.6
#1  0x4009e4cc in __DTOR_END__ () from /usr/lib/libasound.so.2
#2  0x40059cc9 in snd_pcm_hw_refine (pcm=0x8059cc0, params=0xbfffedbc) 
at pcm_params.c:2165
#3  0x40057aa3 in snd_pcm_hw_param_set (pcm=0x8059cc0, 
params=0xbfffedbc, mode=SND_TRY,
     var=SNDRV_PCM_HW_PARAM_RATE, val=621005684, dir=0) at pcm_params.c:692
#4  0x400581ea in snd_pcm_hw_param_refine_multiple (pcm=0x8059cc0, 
params=0xbfffedbc,
     var=SNDRV_PCM_HW_PARAM_RATE, src=0xbffff690) at pcm_params.c:948
#5  0x40066d13 in snd_pcm_plug_hw_refine_schange (pcm=0x8059e08, 
params=0xbffff690,
     sparams=0xbfffedbc) at pcm_plug.c:655
#6  0x40059a3d in snd_pcm_hw_refine_slave (pcm=0x8059e08, 
params=0xbffff690,
     cprepare=0x40066b74 <snd_pcm_plug_hw_refine_cprepare>,
     cchange=0x400670bc <snd_pcm_plug_hw_refine_cchange>,
     sprepare=0x40066c10 <snd_pcm_plug_hw_refine_sprepare>,
     schange=0x40066cc0 <snd_pcm_plug_hw_refine_schange>,
     srefine=0x400673f4 <snd_pcm_plug_hw_refine_slave>) at pcm_params.c:2057
#7  0x40067468 in snd_pcm_plug_hw_refine (pcm=0x8059e08, 
params=0xbffff690) at pcm_plug.c:843
#8  0x40059cc9 in snd_pcm_hw_refine (pcm=0x8059e08, params=0xbffff690) 
at pcm_params.c:2165
#9  0x400567d9 in snd_pcm_hw_param_set_first (pcm=0x8059e08, 
params=0xbffff690,
     var=SNDRV_PCM_HW_PARAM_RATE, rval=0x80528c8, dir=0x0) at 
pcm_params.c:314
#10 0x40057efc in snd_pcm_hw_param_set_near (pcm=0x8059e08, 
params=0xbffff690,
     var=SNDRV_PCM_HW_PARAM_RATE, val=0x80528c8, dir=0x0) at 
pcm_params.c:816
#11 0x400519e5 in __snd_pcm_hw_params_set_rate_near (pcm=0x8059e08, 
params=0xbffff690,
     val=0x80528c8, dir=0x0) at pcm.c:3499
#12 0x0804cdc7 in set_params () at aplay.c:800
#13 0x0804f1b6 in playback_go (fd=7, loaded=0, count=4294967295, rtype=2,
     name=0xbffffca0 "./track_01.wav") at aplay.c:1686
#14 0x0804f5d6 in playback (name=0xbffffca0 "./track_01.wav") at 
aplay.c:1807
#15 0x0804c092 in main (argc=2, argv=0xbffffb54) at aplay.c:514





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
