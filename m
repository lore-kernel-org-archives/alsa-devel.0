From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: NEW hdsp 9652 problems - {WAS: alsaconf -L - where's Waldo?)
Date: Fri, 21 Mar 2003 12:45:51 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18wQWs-0003WJ-00@sc8-sf-list1.sourceforge.net>
References: <1048263429.8624.23.camel@Wizard>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "21 Mar 2003 08:17:09 PST."
             <1048263429.8624.23.camel@Wizard>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>Now, this all worked fine on the previous 2.4.19-1.ll kernel from the
>PlanetCCRMA site **BEFORE** I updated firmware on the HDSP 9652 for new
>Win XP driver support. After updating firmware for the card, the
>alsaconf program I had for the 2.4.19-1.ll kernel no longer recognized
>the card at all and cannot write anything in modules.conf.

you cannot use the current ALSA driver with the new firmware.

i submitted a patch to handle the new firmware, but it has not been
put into CVS yet. meanwhile, thomas charbonnel has extended the work i
did and added some more stuff, and so we are working on a "mega-patch"
that fixes lots of issues with full H-DSP support.

once thomas gets his tasklet problems fixed (for MIDI I/O without
affecting PCM latency), we'll submit the patch again.

--p


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
