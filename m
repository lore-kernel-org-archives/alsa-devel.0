From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: Re: [Alsa-user] fm801 driver status?
Date: Thu, 19 Dec 2002 21:21:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E022A60.20002@gmx.de>
References: <3DF8A109.2030206@gmx.de>	<s5hel8nuvee.wl@alsa2.suse.de>	<3DF8B8FA.3040009@gmx.de>	<s5h3cp3uorz.wl@alsa2.suse.de>	<m27keexn25.fsf@vador.mandrakesoft.com>	<3DF9C1CD.3090205@gmx.de>	<s5hisxxubkx.wl@alsa2.suse.de>	<3DFA1166.2020409@gmx.de>	<s5hel8lua27.wl@alsa2.suse.de>	<3DFA25F1.2000705@gmx.de>	<s5hznr6roae.wl@alsa2.suse.de>	<3DFE3DA5.4000700@gmx.de>	<s5h8yyowm5s.wl@alsa2.suse.de>	<3E0077E9.9050402@gmx.de> <s5hr8ceutxh.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr8ceutxh.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

Takashi Iwai wrote:

>At Wed, 18 Dec 2002 14:28:09 +0100,
>Friedrich Ewaldt wrote:
>  
>
>>Using aplay, at the end of the audio file the last played samples get 
>>repeated once. This doesn't happen with 'play', 'cat somefile /dev/dsp' 
>>or 'artsplay'. But when I cause an error beep in a shell, I first hear 
>>the beep and then the last samples played back before by any program 
>>like  aplay, play, xmms,... I can reproduce this as many time as I like, 
>>i.e. the samples remain in the soundcard buffer all the time.
>>Another issue regarding aplay: playing back mono wav with a sampling 
>>frequency below 44k1, the sound get's crackled. This also doesn't happen 
>>with the other playback programs.
>>    
>>
>
>hmm, this could have been a cause of the last hang-up.
>the unexpected interrupt was not caught by the handler.
>
>could you check /proc/asound/card0/pcm0p/sub0/hw_params for each case?
>
Here's the output of /proc/asound/card0/pcm0p/sub0/hw_params for a 8Bit 
mono 11kHz wav file:

*** played with 'play'
access: RW_INTERLEAVED
format: U8
subformat: STD
channels: 1
rate: 11025 (11025/1)
period_size: 8192
buffer_size: 65536
tick_time: 10000
OSS format: U8
OSS channels: 1
OSS rate: 11025
OSS period bytes: 8192
OSS periods: 8

*** played with 'aplay'
access: RW_INTERLEAVED
format: U8
subformat: STD
channels: 1
rate: 11025 (11025/1)
period_size: 149
buffer_size: 5513
tick_time: 10000

*** xmms, oss output:
access: RW_INTERLEAVED
format: U8
subformat: STD
channels: 1
rate: 11025 (11025/1)
period_size: 256
buffer_size: 8192
tick_time: 10000
OSS format: U8
OSS channels: 1
OSS rate: 11025
OSS period bytes: 256
OSS periods: 32

*** xmms, alsa output
access: MMAP_INTERLEAVED
(if MMAP deactivated in xmms: access: RW_INTERLEAVED)
format: U8
subformat: STD
channels: 1
rate: 11025 (11025/1)
period_size: 149
buffer_size: 5513
tick_time: 10000


Sound is ok with play and xmms/OSS output, but with aplay and xmms/ALSA 
it is noisy and crackled as if it were bad FM radio transmission (with 
and without MMAP mode, MMAP doesn't change anything).
That's only true for mono files with low sampling rates. Stereo files 
are ok using alsa or oss device.

Using xmms/ALSA, another problem occurs:
If xmms finishes playback of one file and starts the next of the 
playlist, output sounds like if it were mixed with helicopter noise. To 
stop this distortion I can press the 'pause' button twice or press 
'stop' + 'playback'.
The same distortion occurs when I start playback of the same or another 
file of the playlist while playback of one file is running. I can see 
(better: hear) this problem with stereo 44kHz files and ALSA output. 
Using OSS output, this problem doesn't occur.
I don't see this problem using xmms/ALSA on an similar system (some 
software) with another soundcard.

>also, please try the attached patch (the drivers should be compiled
>with --with-debug=full) and see what shown in the kernel messages.
>this will print the current ply_ctrl register value.
>the patch is to the latest cvs.  the cvs tree already includes the
>last fix and some additions for pause/release and spdif-out.
>  
>
I patched against the cvs snapshot from december 9th with all your 
previous patches applied before. I'll also test with latest cvs if I 
find some more time.

Here's some output of /var/log/syslog after applaying the last patch and 
compiling with debug=full:

after error beep in shell:
Dec 19 19:43:13 localhost kernel: ALSA ../alsa-kernel/pci/fm801.c:395: 
prepare: ply_ctrl = 0x180
(after the beep I hear loud noise or the last audio samples played 
before by any audio player. These samples are played with wrong speed, 
probably because the beep is played back at another sampling rate)

after playing mono wav file 8Bit, 11kHz using aplay or play:
Dec 19 19:44:15 localhost kernel: ALSA ../alsa-kernel/pci/fm801.c:395: 
prepare: ply_ctrl = 0x380

after playing stereo wav file 16Bit, 44.1kHz using aplay or play:
Dec 19 19:45:00 localhost kernel: ALSA ../alsa-kernel/pci/fm801.c:395: 
prepare: ply_ctrl = 0xc980

The messages are repeated for every playback.
Do these play_ctrl values show anything? They are the same for 'aplay' 
as for 'play' (and xmms, too). But playing back with native alsa apps, I 
have some trouble that I don't have when I use /dev/dsp. The values seem 
to depend only on the audio format. Does this info help?
ciao
fe




-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
