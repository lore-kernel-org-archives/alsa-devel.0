From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: period crossing page boundary
Date: Wed, 19 Mar 2003 21:16:28 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303192113420.1351-100000@pnote.perex-int.cz>
References: <1048107985.985.58.camel@Jay>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1048107985.985.58.camel@Jay>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On 19 Mar 2003, Giuliano Pochini wrote:

> > > I'm facing another *=A3%@ problem. When period size is a multiple or
> > > submultiple of PAGE_SIZE, it works fine, but when it isn't, sound
> > > clicks, pops, repeapeapeats, skps :(( And since the period never cros=
ses
> > > physically the page boundary because I split it when it happens, I ca=
n't
> > > imagine what's wrong. Perhaps some of you had the same problem.
> > >=20
> > > .period callback does this:
> >=20
> > do you mean pointer callback?
>=20
> Yes, sorry.=20
>=20
> > > bufsize=3Dsubstream->runtime->periods*substream->runtime->period_size=
;
> >
> > you already have substream->runtime->buffer_size for this.
> They are different:
>=20
> [aplay <no options> track.wav]
> Mar 19 19:21:23 localhost kernel: pcm_hw_params (bufsize=3D88200 periods=
=3D3
> persize=3D22052)=20
>=20
> bufsize=3D=3D88200 !=3D 3*22052 =3D=3D 66156=20

Note that there is no guarantee that the periods =3D=3D integer value.
If your hardware doesn't allow to set period_size and buffer_size=20
independently (if buffer_size must be multiple of period_size) then put=20
this code to the open callback:

        if ((err =3D snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PA=
RAM_PERIODS)) < 0)
                return err;

See alsa-kernel/pci/via82xx.c for an example.

In other cases, runtime->buffer_size MUST BE USED.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
