From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Pops at start of song
Date: Mon, 24 Nov 2003 11:01:40 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGIEAJDPAB.mknecht@controlnet.com>
References: <Pine.LNX.4.58.0311241923570.9896@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0311241923570.9896@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> Ok, can you force the master rate for HDSP?

Yes, I can force the HDSP master rate to be 44.1KHz.

I can then force the Pro Tools PC be a master also, at 44.1K, but there will
be random clicks and pops since the two are not synced to each other. If I
do this and record on the Pro Tools PC, I get all zeros with a random click
here and there. This is the only way I can record using Pro Tools as the
problem with the HDSP happens and shuts down Pro Tools since it doesn't like
the clock changing. (I.e. - the Pro Tools session is 44.1K, and the clock
changes to 48K, so it gets upset and stops recording.)

> Then you can simply send some
> short (a few seconds) .wav file (or other file) with same rate to selected
> channels (maybe via aplay if you have a good configuration in
> ~/.asoundrc).

There is no problem when using aplay, or at least using alsaplayer there
isn't. I've never had these problems with any Alsa application. Only with
apps that seem to use the OSS emulator, I think. I will try to get the noise
recorded when using xmms. You should get zeros leading in, then this noise,
and then the audio.


> Then you can compare (maybe via some editor) if the whole
> .wav file is in the recorded stream (plus some zero samples at begging and
> end of this stream). Or, you can send me your source and recorded files
> and I'll compare them for you (only mark which file is master).
>
> 						Jaroslav

I've just set up an apache server at home, so later today I'll put the audio
files there, and then give you an IP address where you can pick them up.
What time zone are you in by the way?

Thanks very much,
Mark





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
