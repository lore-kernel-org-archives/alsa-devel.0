From: "Robert Robinson" <robbiex@bellsouth.net>
Subject: Re: Audiophile 2496 S/PDIF Support
Date: Sat, 5 Oct 2002 08:19:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000d01c26c69$7597be40$0201a8c0@rer>
References: <m27kh1djdd.fsf@vador.mandrakesoft.com><20021002145420.6F590146FB@Cantor.suse.de><s5hd6qskhmn.wl@alsa2.suse.de><s5hbs6ckgm0.wl@alsa2.suse.de><20021002174359.1d2395d3.matthias@rpmforge.net><m2zntwn4gx.fsf@vador.mandrakesoft.com><000001c26a6b$bf2da600$0201a8c0@rer> <s5h3crm5szq.wl@alsa2.suse.de> <001501c26bd3$cd7da430$0201a8c0@rer> <3D9E6C5F.2010306@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James,

Thank you.
I will try arecord.

Robbie

----- Original Message -----
From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
To: "Robert Robinson" <robbiex@bellsouth.net>
Cc: "Takashi Iwai" <tiwai@suse.de>; <alsa-devel@lists.sourceforge.net>
Sent: Saturday, October 05, 2002 12:36 AM
Subject: Re: [Alsa-devel] Audiophile 2496 S/PDIF Support


> Robert Robinson wrote:
>
> >Takashi,
> >
> >I had communication from Kysela Jaroslav indicating that the Audiophile
2496
> >driver does support digital I/O.
> >The problem may be that I have not been using an audio interface program
> >that supports the digital option. This choice is never displayed as part
of
> >the I/O.
> >Robbie
> >
> >
> I own a SB Live card, and not an Audiophile 2496, but on the SB Live you
> use alsamixer to select all the recording sources. Then you run arecord
> and it records the sound from the multiple sources mixed together.
>
> The problem with the SB Live is that recording from the SPDIF is always
> interpolated to 48kHz, some interpolation happens between 48Khz input
> and the 48Khz of the sound card. In reality the sound quality does not
> change, but it does cause problems if you are trying to capture an AC3
> or DTS signal, because the interpolation breaks it.
>
> A good program to test recording in is arecord, which comes with alsa.
>
> Cheers
> James
>
>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
