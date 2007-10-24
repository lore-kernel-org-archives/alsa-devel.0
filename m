From: Timur Tabi <timur@freescale.com>
Subject: Re: Confused about 'default' device
Date: Wed, 24 Oct 2007 11:36:09 -0500
Message-ID: <471F7479.9000602@freescale.com>
References: <471E4E2A.9090105@freescale.com> <s5h4pggevv8.wl%tiwai@suse.de>
	<1193225838.26984.1217558213@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D60B224508
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Oct 2007 18:36:29 +0200 (CEST)
In-Reply-To: <1193225838.26984.1217558213@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Takashi Iwai wrote:
>> Timur Tabi wrote:
>>> I'm having a hard time understand when ALSA does sample rate and format 
>>> conversion, and when it doesn't.
>>>
>>> When I issue the following command:
>>>
>>> 	mplayer -ao alsa filename.mov -v
>>>
>>> I get this output:
>>> ...
>>> alsa-init: using device default
>>> alsa-init: format s24le are not supported by hardware
>>>
>>> I was under the impression that ALSA can do format and sample rate conversion if 
>>> necessary, but I guess that's not always the case.
>> It does.  mplayer seems to try first the hardware device without
>> conversion and falls back to "default" PCM.
> 
> In this case, it uses only the "default" PCM device.  There seems to be
> some problem with its definition.
> 
> Are there any definitions in ~/.asoundrc or /etc/asound.conf?  If not,
> what driver is used, and does it have a file in /usr/share/alsa/cards/?

Ok, I made some progress.

According to http://alsa.opensrc.org/.asoundrc, because I'm using ALSA 1.0.8, I 
need to have an .asoundrc.  So I added this .asoundrc:

pcm.!default {
	type hw
	card 0
}
ctl.!default {
	type hw
	card 0
}

And now sample rate conversion works!  However, sample format conversion does 
not work.  When I try to play a movie with an s24le sound track, I get this:


$ MPlayer-1.0rc1/mplayer -ao alsa
video/320x240/sm3_sneak_peek.mov
MPlayer 1.0rc1-3.3.5 (C) 2000-2006 MPlayer Team
AltiVec found
CPU: PowerPC

Playing video/320x240/sm3_sneak_peek.mov.
ISO: File Type Major Brand: Original QuickTime
Quicktime/MOV file format detected.
VIDEO:  [avc1]  320x240  24bpp  29.970 fps    0.0 kbps ( 0.0 kbyte/s)
vo: couldn't open the X11 display ()!
vo: couldn't open the X11 display ()!
VO XOverlay need a subdriver
vo: couldn't open the X11 display ()!
==========================================================================
Opening video decoder: [ffmpeg] FFmpeg's libavcodec codec family
Selected video codec: [ffh264] vfm: ffmpeg (FFmpeg H.264)
==========================================================================
==========================================================================
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 48000 Hz, 2 ch, s24le, 2304.0 kbit/100.00% (ratio:
288000->288000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
==========================================================================
alsa-init: format s24le are not supported by hardware, trying default
alsa-init: unable to set format: Invalid argument
Could not open/initialize audio device -> no sound.
Audio: no sound
Starting playback...
VDec: vo config request - 320 x 240 (preferred colorspace: Planar YV12)
Could not find matching colorspace - retrying with -vf scale...
Opening video filter: [scale]
VDec: using Planar YV12 as output csp (no 0)
Movie-Aspect is undefined - no prescaling applied.
SwScaler: using unscaled yuv420p -> rgb32 special converter
VO: [fbdev] 320x240 => 320x240 ARGB
V:   2.4  74/ 74  4%  5%  0.0% 0 0
Exiting... (Quit)

Does this mean that sample rate conversion is supported, but not sample format 
conversion?
