From: Paulo Cavalcanti <promac@gmail.com>
Subject: Re: idt blue jack patch
Date: Fri, 20 Feb 2009 23:42:00 -0300
Message-ID: <68720af30902201842u2d60dc99q7d2f2388491cdf6b@mail.gmail.com>
References: <s5h4oyuirc5.wl%tiwai@suse.de> <s5htz6s8cis.wl%tiwai@suse.de>
	<68720af30902180104k40a3377cs95ae80446af61f0d@mail.gmail.com>
	<fd3eb9bf0902180144r476fd065ued924b5b26a6675@mail.gmail.com>
	<s5hk57nzs1h.wl%tiwai@suse.de> <20090219030212.GA26505@localhost>
	<1235013772.27435.118.camel@razman> <20090220010001.GA7520@localhost>
	<s5hbpsx10yg.wl%tiwai@suse.de> <20090221015529.GA6821@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A71E103946
	for <alsa-devel@alsa-project.org>; Sat, 21 Feb 2009 03:42:01 +0100 (CET)
Received: by gxk2 with SMTP id 2so3422993gxk.8
	for <alsa-devel@alsa-project.org>; Fri, 20 Feb 2009 18:42:00 -0800 (PST)
In-Reply-To: <20090221015529.GA6821@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-2?Q?Vedran_Mileti=E6?= <rivanvx@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 20, 2009 at 10:55 PM, Wu Fengguang <fengguang.wu@intel.com>wrot=
e:

> On Fri, Feb 20, 2009 at 07:18:31PM +0200, Takashi Iwai wrote:
> > At Fri, 20 Feb 2009 09:00:01 +0800,
> > Wu Fengguang wrote:
> > >
> > > Hi Tobin,
> > >
> > > Here are the Linux and WinXP pin configurations.
> > > Both Linux and WinXP configure node 0x0c as an output pin.
> > >
> > > However the driver seems to be offering three schemes:
> > >
> > >         scheme desc             0xC dev
> > > ------------------------------------------------------
> > >         IDS_CONFIG_OPEN         Speaker_Side/LineIn
> > >         IDS_CONFIG_51           LineIn
> > >         IDS_CONFIG_71           Speaker_Side
> > >
> > > Paulo, maybe you can run these commands to switch between
> > > linein/lineout modes:
> > >
> > >         # wget
> http://www.kernel.org/pub/linux/kernel/people/tiwai/misc/hda-verb-0.3.tar=
.bz2
> > >
> > >         # set PIN_IN mode
> > >         hda-verb /dev/snd/hwC0D2 0x0c SET_PIN_WIDGET_CONTROL 0x20
> > >
> > >         # set PIN_OUT mode
> > >         hda-verb /dev/snd/hwC0D2 0x0c SET_PIN_WIDGET_CONTROL 0x40
> >
> >
> > Regarding the default pin configurations.
> > I made a series of patches to add the interface to change the default
> > pincfg values dynamically via hwdep sysfs.  The patches are found in
> > test/hda-pincfg branch of sound git tree
> >     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> >
> > and included in the very latest alsa-driver-unstable snapshot
> >
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-u=
nstable-snapshot.tar.gz
> >
> > Basically, you can get / set the default pincfg values on the fly, and
> > trigger the codec reconfiguration after that.
> >
> > The init_pin_configs file shows the initial default pincfgs set by BIOS.
> >
> >       # cat /sys/class/sound/hwC0D0/init_pin_configs
> >       0x14 0x9993013f
> >       0x15 0x01014c10
> >       0x16 0x99030120
> >       0x18 0x01a19c30
> >       0x19 0x02a11c31
> >       0x1a 0x01813c32
> >       0x1b 0x02211c1f
> >       0x1c 0x99330133
> >       0x1d 0x411111f0
> >       0x1e 0x411111f0
> >       0x1f 0x411111f0
> >
> > Then, you can override the default value by writing to
> > override_pin_configs sysfs file.
> >
> >       # cat /sys/class/sound/hwC0D0/override_pin_configs
> >       # echo 0x1d 0x02a11c30 >
> /sys/class/sound/hwC0D0/override_pin_configs
> >       # cat /sys/class/sound/hwC0D0/override_pin_configs
> >       0x1d 0x02a11c30
> >
> > Note that this value won't appear in init_pin_configs.
> >
> > Also, there is another file, cur_pin_configs.  This contains the
> > pincfgs that are set by the driver explicitly.  For example,
> > the static pincfg table in patch_sigmatel.c appears here.
> >
> > Then you can trigger the codec reconfiguration by
> >
> >       # echo 1 > /sys/class/sound/hwC0D0/reconfig
> >
> > This will re-setup the driver based on the given pin configs.
> >
> > Unfortunately, in the current scenario, it can't override the static
> > pincfg table in the driver like in patch_sigmatel.c.  It's just for
> > fixing and BIOS setup.
>
> If override_pin_configs cannot override the values in cur_pin_configs
> (or will it later?), then the name is kind of misleading.
>
> How about the names bios_pin_configs, driver_pin_configs and
> user_pin_configs?
>
>

Having a tool for reconfiguring the pins seems to be the only hope
for fixing the problems of all cards available out there.

However, I fixed my problem. The Dell Vostro 1400 (STAC9228) uses the model
"dell-bios" by default. The problem is that plugging the headphones does not
mute the speakers, and the digital mic does not work at all.

The model that works better is the "dell-3stack". But in this case there is
no analog mic available (the digital mic works, but it is too low).

Comparing the codecs I realizaded that the problem was that
the pin/node 0x0e (mic) was 0x01a19040 in the ref model and 0x01111212 in
the del-3stack. Then I just switched their positions in the initialization,
and voil=E1,
I have an analog mic using the model I want, that is, del-3stack.

Unfortunately, I know I did not contribute to anything. I just changed a
codec
to fit my needs, and maybe created a lot of noise tn the process.

Cheers,

and thanks for all the guidance I received.


--- alsa-driver-1.0.19/alsa-kernel/pci/hda/patch_sigmatel.c     2009-01-19
09:08:58.000000000 -0200
+++ alsa-driver-1.0.19-new/alsa-kernel/pci/hda/patch_sigmatel.c 2009-02-20
19:08:18.000000000 -0300
@@ -2113,8 +2113,8 @@
 };

 static unsigned int dell_3st_pin_configs[14] =3D {
-       0x02211230, 0x02a11220, 0x01a19040, 0x01114210,
-       0x01111212, 0x01116211, 0x01813050, 0x01112214,
+       0x02211230, 0x02a11220, 0x01111212, 0x01114210,
+       0x01a19040, 0x01116211, 0x01813050, 0x01112214,
        0x403003fa, 0x90a60040, 0x90a60040, 0x404003fb,
        0x40c003fc, 0x40000100
 };




-- =

Paulo Roma Cavalcanti
LCG - UFRJ
