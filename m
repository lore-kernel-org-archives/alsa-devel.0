From: alsa@slackware.ru
Subject: Re: audigy2 strange behaviour
Date: Sat, 29 Mar 2003 18:29:10 +0300 (MSK)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0303291825490.20096@scil.sinp.msu.ru>
References: <200303281340.OAA13096@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200303281340.OAA13096@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Thanx!
But... what a strange behaviour of controls....
I'm new to that card, but... to make CD play, one need to UP the spdif
(last 2 lines in alsamixer). then normal CD controls become available.
it is a "feature" of the card?

On Fri, 28 Mar 2003, p z oooo wrote:

> Try this:
> Find in file
> alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
> this
> /* analog speakers */
> 	A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R,
> playback + SND_EMU10K1_PLAYBACK_CHANNELS);
> 	//A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R,
> playback + SND_EMU10K1_PLAYBACK_CHANNELS);
>
> Peter Zubaj


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
