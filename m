From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: No sound over HDMI on HDA-Intel - HDA ATI HDMI
Date: Wed, 09 Jan 2008 14:01:56 +0200
Message-ID: <4784B7B4.3060000@unixsol.org>
References: <4784AA9A.6000003@unixsol.org> <s5h1w8r2qpi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h1w8r2qpi.wl%tiwai@suse.de>
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
Cc: alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Around 01/09/08 13:17, Takashi Iwai scribbled:
>> root@browser:~# aplay -D plughw:1,0 test.wav
>> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Stereo
>>
>> No sound.
> 
> 16kHz is no standard sample rate that HD-audio supports.

Sure.

>> root@browser:~# aplay -D plughw:0,0 test.wav
>> Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Stereo
>>
>> Sound is ok.
>>
>> Is there some patches that I could try to get the HDMI output
>> working?
> 
> Try the very latest ALSA driver from ALSA HG repo.  The version on
> 2.6.24 doesn't support multiple devices.
> 
> Then run like
> 
> 	aplay -D default:1 test.wav
> 
> which means to send to the default secondary (1) output.

Ok, I've tried the latest ALSA hg tree and the difference is that
I get PCM slider on HDMI output, but still no sound. The PCM slider
is at 100% and iec958 is unmuted. SB output works fine like before.

I've tried to play the sound with aplay and mplayer:
mplayer -ao alsa:device=hw=1.0 test.wav
MPlayer 1.0rc2-4.1.2 (C) 2000-2007 MPlayer Team
CPU: AMD Athlon(tm) 64 Processor 3200+ (Family: 15, Model: 95, Stepping: 2)
CPUflags:  MMX: 1 MMX2: 1 3DNow: 1 3DNow2: 1 SSE: 1 SSE2: 1
Compiled with runtime CPU detection.

Playing test.wav.
Audio file file format detected.
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 16000 Hz, 2 ch, s16le, 512.0 kbit/100.00% (ratio: 64000->64000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A:   6.6 (06.5) of 6.0 (06.0)  0.6%

Exiting... (End of file)

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
