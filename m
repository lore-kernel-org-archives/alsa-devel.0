From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 1/9] ALSA: hdspm - Allow DDS/Varispeed to
 be set from userspace
Date: Sat, 20 Oct 2012 10:35:36 +0200
Message-ID: <20121020083536.GQ2040@ltw.loris.tv>
References: <1350661350-5000-1-git-send-email-adi@drcomp.erfurt.thur.de>
 <1350661350-5000-2-git-send-email-adi@drcomp.erfurt.thur.de>
 <s5hsj9akx1k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id 63BF9264F07
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 10:35:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsj9akx1k.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, andre.schramm@iosono-sound.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 19, 2012 at 10:48:55PM +0200, Takashi Iwai wrote:

> > The DDS value is the actual physical sample rate. We set it indirectly
> > when selecting 44100, 48000 and so on via snd_hdspm_hw_params or
> > hdspm_set_clock_source.
> > =

> > This commit now allows the DDS value to be altered at runtime, thus
> > speeding up or slowing down the physical sample rate. This is required
> > for MADI's varispeed that allows for =B112.5% speed adjustment from the
> > "selected" rate (32kHz, 44100kHz, 48kHz and so on).
> > =

> > Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> > =

> > diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
> > index b12308b..742bd5e 100644
> > --- a/sound/pci/rme9652/hdspm.c
> > +++ b/sound/pci/rme9652/hdspm.c
> > @@ -2003,8 +2003,10 @@ static int hdspm_get_system_sample_rate(struct h=
dspm *hdspm)
> >  { .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER, \
> >    .name =3D xname, \
> >    .index =3D xindex, \
> > -  .access =3D SNDRV_CTL_ELEM_ACCESS_READ, \
> > +  .access =3D SNDRV_CTL_ELEM_ACCESS_READWRITE |\
> > +	SNDRV_CTL_ELEM_ACCESS_VOLATILE, \
> =

> What's the reason to add VOLATILE flag?
> Does the hardware itself change the value without the driver
> involvement?

Yes, when in slave mode. Then, this value reflects the detected external
sample rate that may change at any time.

The following example shows that this just happened in my test setup:

adi@foh:/opt/adi-src/sound-2.6$ amixer -c 0 cset numid=3D5 48000
numid=3D5,iface=3DMIXER,name=3D'System Sample Rate'
  ; type=3DINTEGER,access=3Drw------,values=3D1,min=3D27000,max=3D207000,st=
ep=3D1
  : values=3D44104

Though I was asking for 48000Hz, the card runs at 44104Hz, because it's
syncing to S/PDIF-In at the moment.


Cheers

-- =

mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
