From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: alsa cvs (06-26-2003) compiling against uclibc ...
Date: Fri, 27 Jun 2003 09:21:19 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0306270919390.11149-100000@pnote.perex-int.cz>
References: <1056665557.24737.34.camel@packet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1056665557.24737.34.camel@packet>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Brookes <chris@txrx.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 26 Jun 2003, Chris Brookes wrote:

> I'm trying to get a current CVS pull of alsa-lib compiled against
> UCLIBC. It's not going so well. The first problem is that uclibc doesn't
> have the wordexp function used in conf.c and pcm_ladspa.c ... I managed
> to get a patch from the uclibc maintainer that replaced the wordexp
> function with a glob function. This does make alsa-lib compile, and if
> you make sure alsa.conf doesn't have a tilde in it, it seems to run ok.
> 
> I have a test MP3 file and a test movie file. The mp3 file (played back
> with 0.90 version of mplayer) plays back fine:
> 
> Checking audio filter chain for 44100Hz/2ch/16bit ->
> 44100Hz/2ch/16bit...
> AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int 
> AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
> alsa-init: testing and bugreports are welcome.
> alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
> (Little-Endian)
> alsa-init: 1 soundcard found, using: hw:0,0
> alsa9: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
> Endian
> AO: [alsa9] 44100Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
> Building audio filter chain for 44100Hz/2ch/16bit ->
> 44100Hz/2ch/16bit...
> Video: no video
> Starting playback...
> 
> The movie file, with -vo null plays audio back ok:
> 
> chChecking audio filter chain for 44100Hz/2ch/16bit
> ->44100Hz/2ch/16bit...
> AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int 
> AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
> audio_setup: Can't open audio device /dev/dsp: No such device
> alsa-init: testing and bugreports are welcome.
> alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
> (Little-Endian)
> alsa-init: 1 soundcard found, using: hw:0,0
> alsa9: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
> Endian
> AO: [alsa9] 44100Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
> Building audio filter chain for 44100Hz/2ch/16bit ->
> 44100Hz/2ch/16bit...
> Starting playback...
> 
> The same movie file played back with video fails (see comments after, I
> know this seems like a faq) like this: 
> 
> Checking audio filter chain for 44100Hz/2ch/16bit ->
> 44100Hz/2ch/16bit...
> AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int 
> AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
> alsa-init: testing and bugreports are welcome.
> alsa-init: requested format: 44100 Hz, 2 channels, Signed 16-bit
> (Little-Endian)
> alsa-init: 1 soundcard found, using: hw:0,0
> ALSA lib conf.c:2658:(snd_config_hooks_call) Cannot open shared library
> (null)
> ALSA lib conf.c:3120:(snd_config_update_r) hooks failed, removing
> configuration
> alsa-init: playback open error: No such file or directory
> Could not open/initialize audio device -> no sound.
> Audio: no sound
> Starting playback...

It seems that snd_dlopen() function in alsa-lib/src/dlmisc.c does not work 
correctly. It should be updated for uclibc as well.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
