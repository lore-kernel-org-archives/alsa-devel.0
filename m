From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: quattro multi plugin.
Date: Sun, 21 Jul 2002 10:20:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0207211019300.755-100000@pnote.perex-int.cz>
References: <3D398B26.8080106@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D398B26.8080106@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 21 Jul 2002, Patrick Shirkey wrote:

> Nope. I have tried something very similar to this before with no luck. 
> It is extremely annoying that I now cannot reproduce the previous 
> message. I don't understand why it can almost work once but seemingly 
> never again ??? It's very strange.
> 
> 
> 
> Takashi Iwai wrote:
> > At Fri, 19 Jul 2002 22:56:15 +0900,
> > Patrick Shirkey wrote:
> > 
> >>This is wierd. Using the exact same commands I cannot get jackd to load 
> >>now. The card still, ahem, works, cough, with a single pcm device.
> > 
> > 
> > how about the asoundrc attached below?
> > this will map hw:2,1 and hw:2,2 as 4 channels pcm.
> > i thought that these two devices correspond to 96kHz, so you need to
> > specify other frequency for jackd.
> > 
> > 
> > Takashi
> 
> ----
> # jackd -R -v -a -d alsa -d q4
> jackd 0.37.1
> Copyright 2001-2002 Paul Davis and others.
> jackd comes with ABSOLUTELY NO WARRANTY
> This is free software, and you are welcome to redistribute it
> under certain conditions; see the file COPYING for details
> 
> 507 waiting for signals
> creating alsa driver ... q4|1024|2|48000|swmon
> You appear to be using the ALSA software "plug" layer, probably
> a result of using the "default" ALSA device. This is less
> efficient than it could be. Consider using a ~/.asoundrc file
> to define a hardware audio device rather than using the plug layer
> 
> You appear to be using the ALSA software "plug" layer, probably
> a result of using the "default" ALSA device. This is less
> efficient than it could be. Consider using a ~/.asoundrc file
> to define a hardware audio device rather than using the plug layer
> 
> new client: alsa_pcm, id = 1 type 1 @ 0x8067490 fd = 14
> port alsa_pcm:in_1 buf shm key 0x28441bd5 at offset 4096 bi = 0x8066860
> registered port alsa_pcm:in_1, offset = 4096
> port alsa_pcm:in_2 buf shm key 0x28441bd5 at offset 8192 bi = 0x8066870
> registered port alsa_pcm:in_2, offset = 8192
> registered port alsa_pcm:out_1, offset = 0
> registered port alsa_pcm:out_2, offset = 0
> -- jack_rechain_graph():
> client alsa_pcm: inprocess client, execution_order=0.
> jackd: pcm.c:1925: snd_pcm_area_silence: Assertion `0' failed.

Please, try again. I've just added missing support for 24-bit samples to
one alsa-lib's function.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
