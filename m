From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: --separate-channels issues
Date: Tue, 10 May 2011 11:21:19 -0700 (PDT)
Message-ID: <530274.59492.qm@web161715.mail.bf1.yahoo.com>
References: <s5htyd2fqzy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm29.bullet.mail.bf1.yahoo.com (nm29.bullet.mail.bf1.yahoo.com
	[98.139.212.188]) by alsa0.perex.cz (Postfix) with SMTP id 3C17724602
	for <alsa-devel@alsa-project.org>;
	Tue, 10 May 2011 20:21:21 +0200 (CEST)
In-Reply-To: <s5htyd2fqzy.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

If use hw:0,1, no "-c 4" is allowed. That is why I use plughw see following:
 =

arecord -f S16_LE -r 48000 -c 4 -D hw:0,1 --separate-channels c1.wav c2.wav=
 c3.wav c4.wav

Recording raw data 'c1.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, C=
hannels 4
arecord: set_params:1048: Access type not available

hw:0,1 works with no "-c" option only. I even try it on my laptop.

---henry

--- On Tue, 5/10/11, Takashi Iwai <tiwai@suse.de> wrote:

> From: Takashi Iwai <tiwai@suse.de>
> Subject: Re: [alsa-devel] --separate-channels issues
> To: "hong zhang" <henryzhang62@yahoo.com>
> Cc: alsa-devel@alsa-project.org
> Date: Tuesday, May 10, 2011, 11:40 AM
> At Tue, 10 May 2011 09:34:40 -0700
> (PDT),
> hong zhang wrote:
> > =

> > Takashi,
> > =

> > When I run following commands with 2 pins inputs.
> > =

> > $ arecord -f S16_LE -r 48000 -c 4 -D plughw:0,1
> --separate-channels c1.wav c2.wav c3.wav c4.wav
> > =

> > hd c3.wav and c4.wav returns 0 but c1.wav and c2.wav
> got right data.
> > Such as =

> > $ hd c3.wav =

> > 00000000=A0 00 00 00 00 00 00 00 00=A0 00 00 00
> 00 00 00 00 00=A0 |................|
> > *
> > 005ad000
> =

> Use hw:0,1 instead of plughw:0,1.=A0 If the hardware
> really supports the
> multi-channels, it should work in that way.=A0 I guess
> you didn't notice
> that the input is 2 channels because plughw covers it.
> =

> > Also, I see trigger Rx start command and then stop
> command immediately.
> =

> This sounds like a driver issue.
> =

> =

> Takashi
> =
