From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: CS46xx woes.
Date: Fri, 15 Nov 2002 13:55:24 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33L2.0211151339210.14712-100000@cactus>
References: <20021115121043.67b5c0af.flame@home.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021115121043.67b5c0af.flame@home.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Olsson <flame@home.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I just upgraded my ALSA from 0.9.0rc2 to 0.9.0rc5 and my sound went from
> "ok" to "very bad".  I've got a Hercules Gametheater XP with the CS4630
> chip.  The volume (with same mixer settings before, including PCM at max
> 74% due to disorted sound at higher settings) is generally lower, and
> also weaker, and sounds quite a bit worse too.  I also tried the
> 2002-11-15 CVS snapshot with the same results.
>

Considerating the Hercules Gametheater XP breakout box as a cheap
construction the soundquality you will get from the analog output,
speakers, headphones, etc. will never be very good. (But using the
SPDIF output to an external receiver works great, at least forme -:) )

About you sound-experience, sounds like there some trouble with
the soundcard amplifier, you would experience this kind of trouble
if it for some reason have been turned of (which in theory should
not happen with rc5 or latest CVS)
Actually there was a hack related to the CD-input, which turned
of the amplifier when CD-line input was unmuted. Could you
try with rc2 and latest CVS to unmute CD-input and test
you hear any diference, if you can disconnect the CD-input cable
physically from the soundcard, and see if you hear any diference ?

> One strange thing is that in alsamixer the chipset line is "Cirrus Logic
> CS4294 rev 5,Cirrus Logic CS4294 rev 5" which seems a bit wrong.
>

The GTXP has two CS4294 codec's, look's OK to me.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
