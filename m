From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 8/8] ASoC: AMD: add AMD ASoC ACP-I2S driver
Date: Sat, 24 Oct 2015 04:31:52 +0900
Message-ID: <20151023193152.GL29919@sirena.org.uk>
References: <1444320760-21936-8-git-send-email-alexander.deucher@amd.com>
 <20151022161415.GU8232@sirena.org.uk>
 <CANv6ZMY_8MzZK0StdgAnzN7EqZVJ3tMz88pKACb3sGKXmRTtXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0474993818=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <CANv6ZMY_8MzZK0StdgAnzN7EqZVJ3tMz88pKACb3sGKXmRTtXQ@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Cc: alsa-devel@alsa-project.org, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, rajeev kumar <rajeevkumar.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0474993818==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+svXpSx+RSEd8UhP"
Content-Disposition: inline


--+svXpSx+RSEd8UhP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2015 at 12:20:09AM +0530, maruthi srinivas wrote:
> On Thu, Oct 22, 2015 at 9:44 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Oct 08, 2015 at 12:12:40PM -0400, Alex Deucher wrote:

> >> +/* ACP DMA irq handler routine for playback, capture usecases */
> >> +int dma_irq_handler(struct device *dev)
> >> +{
> >> +     u16 dscr_idx;
> >> +     u32 intr_flag;
> >
> > This says it's an interrupt handler but it's using some custom,
> > non-genirq interface?

> Irq handling is based on parent device's (part of other subsystem)
> provided interfaces. I will coordinate with others for this.

> Do you mean, using virtual irq assignment for MFD devices
> (ACP is a MFD device) and registering irq handler for it ?

Well, I'd expect that if we're exporting interrupts around the system
we'd be doing so using genirq rather than open coding something.

> >> +             /* Let ACP know the Allocated memory */
> >> +             num_of_pages =3D PAGE_ALIGN(size) >> PAGE_SHIFT;
> >> +
> >> +             /* Fill the page table entries in ACP SRAM */
> >> +             rtd->pg =3D pg;
> >> +             rtd->size =3D size;
> >> +             rtd->num_of_pages =3D num_of_pages;
> >> +             rtd->direction =3D substream->stream;

> > We never reference num_of_pages other than to assign it into the page
> > table entry?

> Sorry, I didn't understand your comment.
> I used 'num_of_pages' to configure ACP audio device for accessing system
> memory. The implementation is in 'acp_pte_config' function in the patch.

In the above code we have two blocks of code, one doing an assignment to
a local variable and the other initialising the struct but the local
variable in the first block is only ever referenced in the second block.

> >> +static int acp_dma_close(struct snd_pcm_substream *substream)
> >> +{
> >> +     struct snd_pcm_runtime *runtime =3D substream->runtime;
> >> +     struct audio_substream_data *rtd =3D runtime->private_data;
> >> +     struct snd_soc_pcm_runtime *prtd =3D substream->private_data;

> >> +     kfree(rtd);

> >> +     pm_runtime_mark_last_busy(prtd->platform->dev);

> > Why the _mark_last_busy() here?

> I want to power off ACP audio IP, when the audio usecase is not active for
> sometime (run time PM). I felt, 'close' is the correct place to mark this.

That's not what _mark_last_busy() does...  the core already takes
runtime PM references for you.

> >> +static int acp_pcm_suspend(struct device *dev)
> >> +{
> >> +     bool pm_rts;
> >> +     struct audio_drv_data *adata =3D dev_get_drvdata(dev);
> >> +
> >> +     pm_rts =3D pm_runtime_status_suspended(dev);
> >> +     if (pm_rts =3D=3D false)
> >> +             acp_suspend(adata->acp_mmio);
> >> +
> >> +     return 0;
> >> +}

> > This appears to merely call into the parent/core device (at least it
> > looks like this is the intention, there's a bunch of infrastructure fo
> > the core device which appeaars to replicate standard infrastructure).
> > Isn't whatever this eventually ends up doing handled by the parent
> > device in the normal PM callbacks.

> ACP device (child) can power off itself, when it receives suspend
> request. So, the intention is to call 'acp_suspend' (defined in same patc=
h)
> from the 'suspend' callback of ACP device.

This doesn't address why you're open coding this rather than using
standard infrastructure.

> >> +     pm_rts =3D pm_runtime_status_suspended(dev);
> >> +     if (pm_rts =3D=3D true) {
> >> +             /* Resumed from system wide suspend and there is
> >> +              * no pending audio activity to resume. */
> >> +             pm_runtime_disable(dev);
> >> +             pm_runtime_set_active(dev);
> >> +             pm_runtime_enable(dev);
> >
> > The above looks very strange - why are we bouncing runtime PM like this?
>=20
> Sorry, I didn't understand your comment. I felt, steps mentioned in
> kernel documentation :
> http://lxr.free-electrons.com/source/Documentation/power/runtime_pm.txt#L=
634
> is applicable in this scenario. I maybe wrong, but felt that is applicabl=
e.

Please document this clearly - your comment doesn't appear to relate to
the case where system resume powers things on at all.

> >> +/* Initialize the dma descriptors location in SRAM and page size */
> >> +static void acp_dma_descr_init(void __iomem *acp_mmio)
> >> +{
> >> +     u32 sram_pte_offset =3D 0;
> >> +
> >> +     /* SRAM starts at 0x04000000. From that offset one page (4KB) le=
ft for
> >> +      * filling DMA descriptors.sram_pte_offset =3D 0x04001000 , used=
 for

> > This is a device relative address rather than an absolute address?  A
> > lot of these numbers seem kind of large...

> That is SRAM block's offset address. Sorry. I didn't understand the
> expected change, here.

Offset with regard to what?  I'm asking if these addresses are within
the IP or global.

> >> +/* power off a tile/block within ACP */
> >> +static void acp_suspend_tile(void __iomem *acp_mmio, int tile)
> >> +{
> >> +     u32 val =3D 0;
> >> +     u32 timeout =3D 0;
> >> +
> >> +     if ((tile  < ACP_TILE_P1) || (tile > ACP_TILE_DSP2))
> >> +             return;
> >> +
> >> +     val =3D acp_reg_read(acp_mmio, mmACP_PGFSM_READ_REG_0 + tile);
> >> +     val &=3D ACP_TILE_ON_MASK;

> > This is definitely looking like a SoC that could benefit from the
> > standard kernel power management infrastructure and/or DAPM.  There's a
> > lot of code here that looks like it's following very common SoC design
> > patterns and could benefit from using infrastructure more.

> Sorry, I didn't understand. Could you help in adding more pointers on thi=
s.
> The device can get powered-off, with this helper function, which can
> be called from device 'suspend' callback.

Power domains are implemented using the interface in include/linux/pm_domai=
n.h
and DAPM is sound/soc/soc-dapm.c.  The point here is that it looks very
much like you are open coding implementations of concepts that we
already have generic support for which adds greatly to both the size and
complexity of this code.

> >> +static void acp_turnoff_sram_banks(void __iomem *acp_mmio)
> >> +{
> >> +     /* Bank 0 : used for DMA descriptors
> >> +      * Bank 1 to 4 : used for playback
> >> +      * Bank 5 to 8 : used for capture
> >> +      * Each bank is 8kB and max size allocated for playback/ capture=
 is
> >> +      * 16kB(max period size) * 2(max periods) reserved for playback/=
capture
> >> +      * in ALSA driver
> >> +      * Turn off all SRAM banks except above banks during playback/ca=
pture
> >> +      */
> >> +     u32 val, bank;

> > I didn't see any runtime management of the other SRAM bank power, seems
> > like that'd be a good idea?

> SRAM banks are part of ACP IP. With ACP's runtime PM handling, all blocks
> within ACP IP can be powered-off and on.

So why can't that cope with these banks then?

> >> +/* Update DMA postion in audio ring buffer at period level granularit=
y.
> >> + * This will be used by ALSA PCM driver
> >> + */
> >> +u32 acp_update_dma_pointer(void __iomem *acp_mmio, int direction,
> >> +                               u32 period_size)
> >> +{

> > Don't limit the accuracy to period level if the harwdare can do better,
> > report the current position as accurately as possible please.  This is
> > also feeling like we've got an unneeded abstraction here - why was this
> > not just directly the pointer operation?

> The current version of hardware has the limitation of accuracy reporting.

If the hardware is limited why does the comment suggest that we are
limiting based on periods?

> I will remove abstraction, if suggested.

Yes, it's just adding to the complexity of the code.

--+svXpSx+RSEd8UhP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKosnAAoJECTWi3JdVIfQkGcH/1TQGiw7MsuJfjsE+MjX4wfX
kIxj2qANQWwXHH/DDLPCTZ/2VURqoOe64VAwNlMMwk3uYobKIwI2OJJIKFcnlmxQ
a7TjjmEAM/r1hH5APxV4XFjb82bj1m+k/7uMmlOpZJjI9qFmC9FUYLi7+vjEVNkN
LGbcykPOSxm2hO6IAY2E38QDY4Nv3VjHt0QUoWC1VvKNCCt3Znn7fw4SouI2l19P
R10kKuIz3qFQ4k3aEs6U+RDGAc52yQfqFXITEi93h3WSuORk0YVFWiQEnLOlt9nx
d+SmP4MxOwieqw43wLP8Wfc/t46Z8/FRhE/D4dyL6QIJ1/E2XPgzLhGxTpMTj10=
=2TVV
-----END PGP SIGNATURE-----

--+svXpSx+RSEd8UhP--

--===============0474993818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK

--===============0474993818==--
