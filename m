From: Lee Revell <rlrevell@joe-job.com>
Subject: gmplayer ALSA bug [was Re: [ALSA - driver 0000475]:
	multiple input streams]
Date: Fri, 03 Sep 2004 20:21:17 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094257277.6575.127.camel__37589.6404417746$1094257916$gmane$org@krustophenia.net>
References: <20040903171836.F159C2D0C0@server.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 81473260
	for <alsa-devel@alsa-project.org>; Sat,  4 Sep 2004 02:21:18 +0200 (MEST)
In-Reply-To: <20040903171836.F159C2D0C0@server.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org, mplayer-users@mplayerhq.hu
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-03 at 13:18, bugtrack@alsa-project.org wrote:
> mplayer gives this result:
> ==========================================================================
> Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
> MP3lib: init layer2&3 finished, tables done
> AUDIO: 44100 Hz, 2 ch, 16 bit (0x10), ratio: 24000->176400 (192.0 kbit)
> Selected audio codec: [mp3] afm:mp3lib (mp3lib MPEG layer-2, layer-3)
> ==========================================================================
> Checking audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
> AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int
> AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
> audio_setup: Can't open audio device /dev/dsp: Device or resource busy
> alsa-init: got device=0, subdevice=0
> alsa-init: 1 soundcard found, using: default
> 
> (. gmplayer freeze .)
> 
> (. Closing xmms .)
> 
> alsa: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
> Endian
> AO: [alsa] 44100Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
> Building audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
> Video: no video
> Starting playback...
> ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
> alsa-control: mixer attach /dev/mixer error: No such file or directory

There is an egregious bug in gmplayer, where it blithely tries to open
ALSA devices (hw:x,x) using OSS device names (/dev/mixer).  I have been
meaning to file a bug report but didn't have the bandwidth, but now
people are reporting this as an ALSA bug.  To make matters worse, the
problem only occurs in gmplayer, and that regular mplayer works fine.

Is this fixed in a more recent release?

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
