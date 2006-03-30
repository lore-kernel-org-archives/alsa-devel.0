From: Robert Hardy <rhardy@webcon.ca>
Subject: Re: Re: [ALSA - driver 0001938]: EPIPE on Audigy with
 surround sound when seeking in 6 channel sound file
Date: Thu, 30 Mar 2006 12:09:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603301149200.15984@thor.webcon.net>
References: <Pine.LNX.4.64.0603291645290.6977@thor.webcon.net>
 <s5h3bh0l10a.wl%tiwai@suse.de> <s5hzmj8jlpx.wl%tiwai@suse.de>
 <Pine.LNX.4.64.0603301053330.11382@thor.webcon.net> <s5hirpv289o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirpv289o.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Mar 2006, Takashi Iwai wrote:
> At Thu, 30 Mar 2006 11:25:08 -0500 (EST),> Robert Hardy wrote:
>> On Thu, 30 Mar 2006, Takashi Iwai wrote:
>>> At Thu, 30 Mar 2006 11:45:09 +0200,
>>>> At Wed, 29 Mar 2006 17:18:59 -0500 (EST),
>>>> Robert Hardy wrote:
>>>>> Basically I was trying to point out I am also affected by this bug:
>>>>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1938
>>>>>
>>>>> This unfortunately made no difference here. I'm running 2.6.16-rh3 which is 2.6.16.1 with
>>>>> custom patches including the recent git commit for [ALSA] version 1.0.11rc4 from here:
>>>>> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1c2e02750b992703a8a18634e08b04353face243
>>>>>
>>>>> My sound card:
>>>>> 02:07.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
>>>>>          Subsystem: Creative Labs: Unknown device 1001
>>>>>
>>>>> This card once worked fine unfortunately I'm not sure with what
>>>>> mplayer/alsa-lib/alsa-driver/kernel....
>>>>>
>>>>> I'm running a i686/32bit mplayer in a 64 bit environment.
>>
>>>> Strange.  It works fine on my test syetm now with 32bit mplayer on
>>>> 64bit kernel.
>>>
>>> Maybe a dumb question: Did you properly install 32bit library?
>>>
>>> I often compile/install 64bit lib for debugging 32bit problems, and
>>> throw precious hours aways...
>>
>> I rolled those patches into my alsa-lib rpm before I tested them. Both my
>> i686 and x86_64 rpms have the patches. My currrent system has:
>>
>>> rpm -qa --qf='%{name}-%{version}-%{release}-%{arch}\n' | grep alsa
>> alsa-lib-devel-1.0.11-3.rc4.2.el4-x86_64
>> alsa-utils-1.0.11-2.rc4.1.el4-x86_64
>> alsa-lib-1.0.11-3.rc4.2.el4-i686
>> alsa-lib-devel-1.0.11-3.rc4.2.el4-i686
>> alsa-lib-1.0.11-3.rc4.2.el4-x86_64
>>
>> Wanting to make sure it wasn't some how getting confused by the x86_64
>> libraries, I just now tested only the i686 rpms in my chrooted el4 i386
>> environment and the same problem happened.
>
> OK, which problem exactly?  All tests failed?

cd /el4_i386_chroot
setarch i386 chroot .

# mplayer -vo xv -ao alsa -channels 6 An_AC3_movie.avi |& less

MPlayer dev-Fedora-GS-CVS-060328-14:45-3.4.5 (C) 2000-2006 MPlayer Team
CPU: Advanced Micro Devices Athlon 64 Newcastle,Winchester,San Diego,Venice;
Sempron Palermo (Family: 15, Stepping: 0)
CPUflags:  MMX: 1 MMX2: 1 3DNow: 1 3DNow2: 1 SSE: 1 SSE2: 1
Compiled for x86 CPU with extensions: MMX MMX2 3DNow 3DNowEx SSE SSE2

Playing An_AC3_movie.avi.
AVI file format detected.
VIDEO:  [XVID]  640x272  12bpp  25.000 fps  861.2 kbps (105.1 kbyte/s)
Clip info:
  Software: Nandub v1.0rc2
==========================================================================
Opening audio decoder: [liba52] AC3 decoding with liba52
Using SSE optimized IMDCT transform
AC3: 5.1 (3f+2r+lfe)  48000 Hz  448.0 kbit/s
Using MMX optimized resampler
AUDIO: 48000 Hz, 6 ch, s16le, 448.0 kbit/9.72% (ratio: 56000->576000)
Selected audio codec: [a52] afm: liba52 (AC3-liba52)
==========================================================================
Opening video decoder: [ffmpeg] FFmpeg's libavcodec codec family
Selected video codec: [ffodivx] vfm: ffmpeg (FFmpeg MPEG-4)
==========================================================================
alsa-init: using device surround51
alsa: 48000 Hz/6 channels/12 bpf/196608 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa] 48000Hz 6ch s16le (2 bytes per sample)
Starting playback...
VDec: vo config request - 640 x 272 (preferred colorspace: Planar YV12)
VDec: using Planar YV12 as output csp (no 0)
Movie-Aspect is 2.35:1 - prescaling to correct movie aspect.
VO: [xv] 640x272 => 640x272 Planar YV12
[ a bunch of position info trimmed ]
[ attempt to seek with right arrow ]
alsa-lib: pcm.c:6300:(snd_pcm_mmap_commit) commit offset (0) doesn't match with appl_ptr (291840) % buf_size (16384)
alsa-play: write error: Broken pipe
alsa-play: trying to reset soundcard
alsa-lib: pcm.c:6300:(snd_pcm_mmap_commit) commit offset (0) doesn't match with appl_ptr (291840) % buf_size (16384)
alsa-play: write error: Broken pipe
alsa-play: trying to reset soundcard
[ mplayer hangs w/ 100% cpu usage; same 3 messages repeat forever until mplayer is killed ]

Is there some way I can comment directly on bug 1938 in Mantis?

We seem to lose context in email (and Mantis doesn't seem to let me comment)?

Regards,
Rob

-- 
---------------------"Happiness is understanding."----------------------
Robert Hardy, B.Eng Computer Systems                  C.E.O. Webcon Inc.
rhardy <at> webcon <dot> ca    GPG Key available          (613) 276-7327


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
