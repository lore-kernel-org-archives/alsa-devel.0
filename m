From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: [PATCH] emu10k1: change "Music" to "Synth" in	mixer control names.
Date: Wed, 29 Dec 2004 13:37:57 +0100
Message-ID: <200412291237.iBTCbvHo002065@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>It may be better to simplify the controls.
>For example, master volume could be only a digital one and remove the
>ac97 master control (always set the max. level) as found in OSS/free
>emu10k1 driver.

This was done for Audigy (it doesn't use AC97 - only when needed), but
needs to be done for SB Live.

Peter Zubaj
=0A____________________________________=0ARAMMSTEIN, 22.02.2005 o 20,00, Br=
atislava Incheba, =0AInfo: 0904 666 363, http://www.xl.sk =0A


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
