From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: period crossing page boundary
Date: 19 Mar 2003 21:06:20 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1048107985.985.58.camel@Jay>
References: <1048076671.1382.47.camel@Jay>  <s5hel53s2ud.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hel53s2ud.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > I'm facing another *=A3%@ problem. When period size is a multiple or
> > submultiple of PAGE_SIZE, it works fine, but when it isn't, sound
> > clicks, pops, repeapeapeats, skps :(( And since the period never crosse=
s
> > physically the page boundary because I split it when it happens, I can'=
t
> > imagine what's wrong. Perhaps some of you had the same problem.
> >=20
> > .period callback does this:
>=20
> do you mean pointer callback?

Yes, sorry.=20

> > bufsize=3Dsubstream->runtime->periods*substream->runtime->period_size;
>
> you already have substream->runtime->buffer_size for this.
They are different:

[aplay <no options> track.wav]
Mar 19 19:21:23 localhost kernel: pcm_hw_params (bufsize=3D88200 periods=3D=
3
persize=3D22052)=20

bufsize=3D=3D88200 !=3D 3*22052 =3D=3D 66156=20

> > //addr=3D=3Dnumber of bytes transferred.
> > pos=3Dbytes_to_frames(substream->runtime, addr);
> > return(pos%bufsize);
>
> i suppose addr is updated in the interrupt handler, right?

No, I read it from the hardware every time. I tried to store the value
in the irq handler and it's the same.

>
> > Here is a log of sg list construction:
> > [...]
>
> the logs seem fine.
>
> did you set up page callback, too?

Yes I did.

> were the irqs issued correctly with the 1.5 page periods?
> i mean, at the proper timing?

Yes, I believe. When period size is 2048 or 1024 it works fine. I put a
printk in the pointer callback to monitor the frame position and it always
seems correct despite the bad output. "irq" is a command I insert in the
sg list, because the hw don't generate it automatically at the and of each
block. IMO the bug is around the .pointer callback function.

> maybe it would be easier to debug if you show the actual code and the
> hardware spec...

I'm writing my driver around the open source generic driver released by
the manufacturer (in C++ argh!). I'm trying to keep the generic code
as-is to make upgrades to future releases easier. I don't have hw specs
but the sources are full of comments. As far as I can see there are no
hw limits about the size of the sg list and its entries.

You can get my (very-ugly-pre-alpha) sources here:
http://space.virgilio.it/g_pochini@virgilio.it/ea.tgz
and the generic driver here:
http://www.echoaudio.com/Downloads/Developer/EchoGenericDriverA0.zip


Bye.




-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
