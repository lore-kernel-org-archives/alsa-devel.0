From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: New snd-hda warning spew
Date: Fri, 18 Mar 2016 15:54:59 +0200
Message-ID: <20160318135459.GF4329@intel.com>
References: <20160315160207.GY4329@intel.com> <s5hio0nejv3.wl-tiwai@suse.de>
 <20160316140420.GB4329@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 10504261ADC
 for <alsa-devel@alsa-project.org>; Fri, 18 Mar 2016 14:55:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160316140420.GB4329@intel.com>
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
Cc: alsa-devel@alsa-project.org, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2016 at 04:04:20PM +0200, Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 15, 2016 at 06:22:56PM +0100, Takashi Iwai wrote:
> > On Tue, 15 Mar 2016 17:02:07 +0100,
> > Ville Syrj=E4l=E4 wrote:
> > > =

> > > We have a few new WARN spews from snd-hda causing some grief in i915 =
CI.
> > > =

> > > This one happens on ILK and BYT. Looks like it happens 100% of the ti=
me on driver load:
> > > [   18.809850] ------------[ cut here ]------------
> > > [   18.809866] WARNING: CPU: 0 PID: 39 at sound/hda/hdac_i915.c:129 p=
in2port+0x25/0x30 [snd_hda_core]()
> > =

> > This is bad.  Basically we had a naive assumption of the fixed mapping
> > between the port number and the HD-audio widget, but it doesn't apply
> > properly to pre-HSW models.
> > =

> > The patch attached below disables the audio binding for pre-HSW
> > models.  I'm going to queue to for-linus branch.
> =

> That seems to eliminate the warn on my ILK.

Apparently it was less effective on BYT. We still get this:

[   14.978872] ------------[ cut here ]------------
[   14.978890] WARNING: CPU: 1 PID: 288 at sound/hda/hdac_i915.c:129 pin2po=
rt+0x25/0x30 [snd_hda_core]()
[   14.978894] Modules linked in: snd_hda_codec_hdmi(+) snd_hda_codec_realt=
ek snd_hda_codec_generic i915 snd_hda_intel snd_hda_codec intel_powerclamp =
coretemp crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hwdep snd_hd=
a_core snd_pcm lpc_ich i2c_hid i2c_designware_platform i2c_designware_core =
r8169 mii sdhci_acpi sdhci mmc_core
[   14.978934] CPU: 1 PID: 288 Comm: modprobe Not tainted 4.5.0-gfxbench+ #1
[   14.978938] Hardware name: \xffffffff\xffffffff\xffffffff\xffffffff\xfff=
fffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff=
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xfff=
fffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff=
\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff \xffffffff\xff=
ffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xfffffff=
f\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xff=
ffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xfffffff=
f\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xffffffff\xff=
ffffff\xffffffff/DN2820FYK, BIOS FYBYT10H.86A.0038.2014.0717.1455 07/17/2014
[   14.978941]  0000000000000000 ffff8800732d3a48 ffffffff813fef15 00000000=
00000000
[   14.978948]  ffffffffa014077c ffff8800732d3a80 ffffffff81078a21 ffff8800=
73201b90
[   14.978954]  ffff880073006878 ffff880073006880 0000000000000100 ffff8800=
73006878
[   14.978961] Call Trace:
[   14.978969]  [<ffffffff813fef15>] dump_stack+0x67/0x92
[   14.978976]  [<ffffffff81078a21>] warn_slowpath_common+0x81/0xc0
[   14.978980]  [<ffffffff81078b15>] warn_slowpath_null+0x15/0x20
[   14.978988]  [<ffffffffa013f2d5>] pin2port+0x25/0x30 [snd_hda_core]
[   14.978997]  [<ffffffffa013f378>] snd_hdac_acomp_get_eld+0x38/0x70 [snd_=
hda_core]
[   14.979009]  [<ffffffffa0050a69>] hdmi_present_sense+0xa9/0x3a0 [snd_hda=
_codec_hdmi]
[   14.979016]  [<ffffffffa005112f>] generic_hdmi_build_controls+0x11f/0x20=
0 [snd_hda_codec_hdmi]
[   14.979029]  [<ffffffffa018e5b1>] snd_hda_codec_build_controls+0x191/0x1=
d0 [snd_hda_codec]
[   14.979039]  [<ffffffffa018e881>] ? snd_hda_codec_build_pcms+0xe1/0x1a0 =
[snd_hda_codec]
[   14.979049]  [<ffffffffa0189442>] hda_codec_driver_probe+0x82/0x100 [snd=
_hda_codec]
[   14.979056]  [<ffffffff8153d9b9>] driver_probe_device+0x229/0x450
[   14.979061]  [<ffffffff8153dc63>] __driver_attach+0x83/0x90
[   14.979066]  [<ffffffff8153dbe0>] ? driver_probe_device+0x450/0x450
[   14.979070]  [<ffffffff8153b691>] bus_for_each_dev+0x61/0xa0
[   14.979074]  [<ffffffff8153d2a9>] driver_attach+0x19/0x20
[   14.979078]  [<ffffffff8153cd8f>] bus_add_driver+0x1ef/0x290
[   14.979083]  [<ffffffffa0059000>] ? 0xffffffffa0059000
[   14.979087]  [<ffffffff8153e98b>] driver_register+0x5b/0xe0
[   14.979096]  [<ffffffffa01890d5>] __hda_codec_driver_register+0x55/0x60 =
[snd_hda_codec]
[   14.979103]  [<ffffffffa005901e>] hdmi_driver_init+0x1e/0x20 [snd_hda_co=
dec_hdmi]
[   14.979110]  [<ffffffff810003de>] do_one_initcall+0xae/0x1d0
[   14.979115]  [<ffffffff810e1091>] ? rcu_read_lock_sched_held+0x81/0x90
[   14.979121]  [<ffffffff811b8863>] ? kmem_cache_alloc_trace+0x293/0x300
[   14.979126]  [<ffffffff8115b3dc>] ? do_init_module+0x22/0x1c6
[   14.979131]  [<ffffffff8115b415>] do_init_module+0x5b/0x1c6
[   14.979136]  [<ffffffff81107d3a>] load_module+0x1c0a/0x24b0
[   14.979142]  [<ffffffff81105410>] ? symbol_put_addr+0x60/0x60
[   14.979147]  [<ffffffff81105706>] ? copy_module_from_fd.isra.63+0xe6/0x1=
40
[   14.979152]  [<ffffffff811087ce>] SyS_finit_module+0x7e/0xa0
[   14.979160]  [<ffffffff817c5f5b>] entry_SYSCALL_64_fastpath+0x16/0x73
[   14.979271] ---[ end trace 639ed871547f2d0f ]---

<snip>
> > =

> > -- 8< --
> > From: Takashi Iwai <tiwai@suse.de>
> > Subject: [PATCH] ALSA: hda - Limit i915 HDMI binding only for HSW and l=
ater
> > MIME-Version: 1.0
> > =

> > It turned out that the pre-HSW Intel chips are incompatible with the
> > naive assumption we had -- the fixed mapping between the port and the
> > HD-audio widget.  This may result in the bad access, as captured by
> > the recent patch to add a WARN_ON() for the port mapping check.
> > =

> > As a quick workaround, disable the i915 audio component binding for
> > all pre-Haswell models.
> > =

> > Reported-by: Ville Syrj=E4l=E4 <ville.syrjala@linux.intel.com>
> > Cc: <stable@vger.kernel.org> # v4.5
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  sound/pci/hda/patch_hdmi.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > =

> > diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> > index 3fc259154c0b..cde9746cda8e 100644
> > --- a/sound/pci/hda/patch_hdmi.c
> > +++ b/sound/pci/hda/patch_hdmi.c
> > @@ -2243,9 +2243,10 @@ static int patch_generic_hdmi(struct hda_codec *=
codec)
> >  	codec->spec =3D spec;
> >  	hdmi_array_init(spec, 4);
> >  =

> > -	/* Try to bind with i915 for any Intel codecs (if not done yet) */
> > +	/* Try to bind with i915 for Intel HSW+ codecs (if not done yet) */
> >  	if (!codec_has_acomp(codec) &&
> > -	    (codec->core.vendor_id >> 16) =3D=3D 0x8086)
> > +	    (codec->core.vendor_id >> 16) =3D=3D 0x8086 &&
> > +	    is_haswell_plus(codec))
> >  		if (!snd_hdac_i915_init(&codec->bus->core))
> >  			spec->i915_bound =3D true;
> >  =

> > -- =

> > 2.7.3
> > =

> =

> -- =

> Ville Syrj=E4l=E4
> Intel OTC

-- =

Ville Syrj=E4l=E4
Intel OTC
