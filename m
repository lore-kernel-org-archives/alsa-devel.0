From: Guenther Sohler <guenther.sohler@newlogic.com>
Subject: Re: Mixer Problem
Date: Tue, 19 Feb 2002 14:44:39 +0100 (MET)
Message-ID: <XFMail.20020219144439.guenther.sohler@newlogic.com>
Reply-To: Guenther Sohler <guenther.sohler@newlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
In-Reply-To: <s5hofilbno0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo Takashi,

I am trying to understand the internals of my audixy card, but it is
quite hard for me, because i am a newbie to the audixy, and i am a newbie to
soundcard internals too.
I have been brosing through the source of the alsa driver to understand things, 
but it goes very slowly.
I have once seen a (advertisment like)block diagram of the emu10k1 chip and how
it for example accesses the sound font per pci bus mastering.

Browsing the code i realise, there is the auxixy card, there is a dsp there is
an ac97 (what is this actually) there is the emu10k1(is this actually one chip
???) there are input and output ports, there is fx(what does this mean), fx can
somehow be routed. Does the dsp code determine the routing behaviour ???
so many questions.
In the first step most helpful would be a huge block diagram showing which
parts exist and how they are connected.

> The difference between "Music" and "Wave" is depending on your
> soundfont.  Most of soundfonts are composed with relatively lower
> volumes.
I have an old soundfont from my old awe 64 card. so i'll try this instead.

rds guenther

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
