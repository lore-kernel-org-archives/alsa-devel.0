From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: [PATCH] emu10k1: change "Music" to "Synth" in	mixer control names.
Date: Wed, 29 Dec 2004 09:40:57 +0100
Message-ID: <200412290840.iBT8erHo024276@www4.pobox.sk>
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
To: rlrevell@joe-job.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Because these controls are in AC97 too.
You can not have two controls with same name.
First AC97 mixer is created, then DSP mixer is created. Then unneeded
controls from AC97 are removed and DSP controls are renamed to their
final name.

Peter Zubaj
=0A____________________________________=0ARAMMSTEIN, 22.02.2005 o 20,00, Br=
atislava Incheba, =0AInfo: 0904 666 363, http://www.xl.sk =0A


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
