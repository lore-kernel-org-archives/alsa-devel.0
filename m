From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: EWX 24/96 and SPDIF: solved? (with patch)
Date: Tue, 30 Sep 2003 22:27:57 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.58.0309302201580.257614@kosh.hut.fi>
References: <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
 <5.1.0.14.1.20030930091950.037fac38@pop3.infotecna.lcl>
 <5.1.0.14.1.20030930143325.01dac280@pop3.infotecna.lcl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.1.0.14.1.20030930143325.01dac280@pop3.infotecna.lcl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Denis Sbragion <d.sbragion@infotecna.it>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> With this patch my EWX works flawless with ALSA 0.9.7, anyway I can't
> check if it is going to cause problems with other ICE1712 based
> soundcards. I hope this change is the right one, and not something that
> makes just my soundcard work.

With 0.9.6

I experienced ice1712 driver hangups when I used two M-Audio cards
connected together through SPDIF and the other card synced it's clock from
SPDIF (Audiophile 2496 and 1010LT). Sometimes in envy24control the
vu-meters freezed, and I needed to do /etc/init.d/alsa restart to get the
cards to respond again.

Sometimes the problem went away without restart when I tried to change the
clock rate from envy24control, but the card didn't always respond,
sometimes the clock changed fine and then the vu meters worked again.

This, I think, caused also ecasound problems; it couldn't stop the
recording and after killing the process I found out that it had not
recorded anything even thougn the engine started fine.
I quess the drivers were halted just after ecasound engine started,
otherwise it might have reported some errors.

(Btw Kai, if you read this, maybe ecasound could have some control ability
to be sure that audio really get's written to harddisk. In my case it just
wrote the wav headers.)

I'm not sure if I used the cards right; modules.conf had settings for both
cards, but when alsa started it reported the cards like this:

Starting ALSA sound driver (version 0.9.6): ice1712 (ice1712)

so I'm not sure if the other card was properly set up. (I assume that the
parenthesis means that driver has some problems. I get (via82xx) if the
motherboard AC97 is disabled from bios, and without parenthesis when it is
enabled)

But still I was able to record from both cards simultaneously when they
were not freezed, and the sample clocks were synced fine.


Tommi Uimonen

ps. Kernel was 2.4.20 with LL patches.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
