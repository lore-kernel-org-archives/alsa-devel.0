From: hong zhang <henryzhang62@yahoo.com>
Subject: Re: multi channels input and single channel out
Date: Fri, 6 May 2011 09:48:26 -0700 (PDT)
Message-ID: <57372.52581.qm@web161702.mail.bf1.yahoo.com>
References: <s5hoc3gidgj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm27-vm0.bullet.mail.bf1.yahoo.com
	(nm27-vm0.bullet.mail.bf1.yahoo.com [98.139.213.139])
	by alsa0.perex.cz (Postfix) with SMTP id B4A67103AB0
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 18:48:28 +0200 (CEST)
In-Reply-To: <s5hoc3gidgj.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lu Guanqun <guanqun.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

Yes, you are right. But 6 files (3 pins) size is same 4096 see following.

$arecord -f S16_LE -r 48000 -c 6 -D plughw:0,1 --separate-channels c1.wav c=
2.wav c3.wav c4.wav c5.wav c6.wav
Recording raw data 'c1.wav' : Signed 16 bit Little Endian, Rate 48000 Hz, C=
hannels 6

$ll c*
-rw-r--r-- 1 root root 4096 2011-05-06 09:44 c1.wav
-rw-r--r-- 1 root root 4096 2011-05-06 09:44 c2.wav
-rw-r--r-- 1 root root 4096 2011-05-06 09:44 c3.wav
-rw-r--r-- 1 root root 4096 2011-05-06 09:44 c4.wav
-rw-r--r-- 1 root root 4096 2011-05-06 09:44 c5.wav
-rw-r--r-- 1 root root 4096 2011-05-06 09:44 c6.wav

$aplay -f S16_LE -r 48000 -c 1 -D plughw:0,0 c1.wav

does not have sound.

Are my commands right?
 =



--- On Fri, 5/6/11, Takashi Iwai <tiwai@suse.de> wrote:

> From: Takashi Iwai <tiwai@suse.de>
> Subject: Re: [alsa-devel] multi channels input and single channel out
> To: "hong zhang" <henryzhang62@yahoo.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lu Guan=
qun" <guanqun.lu@intel.com>
> Date: Friday, May 6, 2011, 12:51 AM
> At Thu, 5 May 2011 17:31:06 -0700
> (PDT),
> hong zhang wrote:
> > =

> > "--separate-channels" option only allows two files for
> two channels.
> =

> No.=A0 You passed -fdat, right?=A0 "dat" format
> specifies 2 channels.
> Pass -c8 after -fdat.
> =

> =

> Takashi
> =

> > Interesting thing is plughw:0,1 -c 1 works only for
> one pin input (two channels). =

> > =

> > plughw:0,1 -c 1 complains overrun for 6 channels (3
> input pins) input.
> > =

> > --- On Thu, 5/5/11, Lu Guanqun <guanqun.lu@intel.com>
> wrote:
> > =

> > > From: Lu Guanqun <guanqun.lu@intel.com>
> > > Subject: Re: [alsa-devel] multi channels input
> and single channel out
> > > To: "hong zhang" <henryzhang62@yahoo.com>
> > > Cc: "alsa-devel@alsa-project.org"
> <alsa-devel@alsa-project.org>
> > > Date: Thursday, May 5, 2011, 7:23 PM
> > > On Fri, May 06, 2011 at 07:47:55AM
> > > +0800, hong zhang wrote:
> > > > List,
> > > > =

> > > > I have 8 channels of hdmi input and one
> channel output
> > > on my board.
> > > > When arecord -f dat hdmi-rx.wav to store 8
> channels
> > > data, aplay -f dat hdmi-rx.wav releases noise.
> > > > =

> > > > Ia there any way arecord stores each channel
> data to 8
> > > different files?
> > > =

> > > check out the "--separate-channels" option for
> arecord.
> > > see if it meets your needs.
> > > =

> > > > Or I have to do beam forming to sort 8
> channels out by
> > > custom application?
> > > > =

> > > > Thanks.
> > > > =

> > > > ---henry
> > > >
> _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > =

> > > -- =

> > > guanqun
> > > =

> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > =

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> =
