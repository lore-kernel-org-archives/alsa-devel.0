From: Thorsten Becker <thorsten.becker@cloupage.de>
Subject: Re: Dell OEM Soundblaster Live 5.1 with different PCI ID
Date: Sat, 21 Dec 2002 15:38:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212211538.31782.thorsten.becker@cloupage.de>
References: <72DB76FA-13CC-11D7-9D7F-0050E4E6A73C@ics.uci.edu> <s5hbs3gvilq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hbs3gvilq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Jeff Ridenour <jridenou@ics.uci.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Freitag, 20. Dezember 2002 16:02 schrieb Takashi Iwai:
> this is likely an interrupt problem.
> if you set "pnp os" to yes on the bios, try to set it to "no".

I tried various different bios-settings, none did help

> but even without interrupts, you should be able to hear CDs.
> this is a mixer mis-configuration in most cases.
> you'll need to adjust the volume of "Line Playback" and unmute it.
> in addition, the volume of "AC97 Playback" must be adjusted and
> unmuted.
> of course, "PCM" and "Master" must be adjusted and unmuted, too.
> to hear WAV, "Wave" must be adjusted and unmuted, too.

Everything unmuted and all sliders up - no sound (only the volume level o=
f=20
background noise going up and down when I move the sliders in the mixer).
Do you have any other ideas what to try next?

Thorsten


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
