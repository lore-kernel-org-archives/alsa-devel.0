From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: aplay crash in alsa-*-0.9.0beta12
Date: Tue, 12 Mar 2002 08:06:41 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0203120806340.1021-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA10853
	for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2002 08:07:07 +0100
In-Reply-To: <16kZrk-1VaOzgC@fmrl04.sul.t-online.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Markus Schoder <markus_schoder@yahoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 12 Mar 2002, Markus Schoder wrote:

> Hi!
> 
> I experienced crashes with aplay from alsa-*-0.9.0beta12 when playing a
> .wav file.  I tracked it down to the snd_pcm_plugin_write_areas
> function in pcm/pcm_plugin.c of libasound.
> 
> The result variable in the loop can get larger than size.  It is
> subtracted from size but since size is unsigned it will wrap
> around to an insanely high value and either loop forever or
> eventually crash.
> 
> The reason for this behaviour seems to be that slave_frames can get
> bigger than frames due to some resampling being done in the function
> snd_pcm_rate_expand in pcm/pcm_rate.c.
> 
> I patched the snd_pcm_plugin_write_areas function by not allowing more
> than frames to be subtracted from size.  This fixed the crash but I am
> now experiencing some garbage being played at the end of the .wav.
> 
> Any ideas?

It's fixed in CVS.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
