From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 05/10] ASoC: Intel: mrfld: add DSP core
	controls
Date: Fri, 19 Sep 2014 13:51:53 +0530
Message-ID: <20140919082152.GC24663@intel.com>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140916193053.GD7960@sirena.org.uk>
 <20140917105552.GA13006@vinod.koul@linux.intel.com>
 <20140917193706.GU7960@sirena.org.uk>
 <20140918061237.GA24663@intel.com>
 <20140918172852.GY7960@sirena.org.uk>
 <20140919081047.GB24663@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2354421067702023243=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3850126168C
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 10:48:00 +0200 (CEST)
In-Reply-To: <20140919081047.GB24663@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2354421067702023243==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Content-Disposition: inline


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2014 at 01:40:47PM +0530, Vinod Koul wrote:
> On Thu, Sep 18, 2014 at 10:28:52AM -0700, Mark Brown wrote:
> > On Thu, Sep 18, 2014 at 11:42:37AM +0530, Vinod Koul wrote:
> > > On Wed, Sep 17, 2014 at 12:37:06PM -0700, Mark Brown wrote:
> >=20
> > > > This doesn't really answer my concern - what happens if we're alrea=
dy
> > > > active and making a change?
> >=20
> > > Since this is specfic to BE (SSP) port, the DSP FW doesnt allow us to=
 reconfigure
> > > the slots when it is active. These will take effect next time the BE
> > > restarts.
> >=20
> > > Yes not ideal but thats something we have to live with!
> >=20
> > That's fine but in that case I would expect to see an error returned to
> > userspace rather than just silently ignoring what it's doing until the
> > next time we start a stream, or at the very least some sort of warning
> > generated.  Silently ignoring things isn't great especially with no
> > comments in the code, it ends up looking like a bug.
> Error to usermode wont be apt as we accept the value and due to constraint
> the value is applied at next BE start.
>=20
> Yes definately makes sense to put a comment about this. Will update that
And turns out that limitation is gone so I was wrong here, thanks to Shubra=
nsu for pointing this out.

This function does indeed send the updated slot values to DSP

see this bit:

static int sst_slot_put(struct snd_kcontrol *kcontrol,
                        struct snd_ctl_elem_value *ucontrol)
{
        struct snd_soc_component *cmpnt =3Dsnd_soc_kcontrol_component(kcont=
rol);
        struct sst_data *drv =3D snd_soc_component_get_drvdata(cmpnt);
        struct sst_enum *e =3D (void *)kcontrol->private_value;
        int i, ret =3D 0;
        unsigned int ctl_no =3D e->reg;
        unsigned int is_tx =3D e->tx;
        unsigned int slot_channel_no;
        unsigned int val, mux;
        u8 *map;

        map =3D is_tx ? sst_ssp_channel_map : sst_ssp_slot_map;

        val =3D 1 << ctl_no;
        mux =3D ucontrol->value.enumerated.item[0];
        if (mux > e->max - 1) {
                return -EINVAL;
        }

        mutex_lock(&drv->lock);
        /* first clear all registers of this bit */
        for (i =3D 0; i < e->max; i++)
                map[i] &=3D ~val;

        if (mux =3D=3D 0) {/* kctl set to 'none' */
                mutex_unlock(&drv->lock);
                return 0;
        }

        /* offset by one to take "None" into account */
        slot_channel_no =3D mux - 1;
        map[slot_channel_no] |=3D val;

        dev_dbg(cmpnt->dev, "%s %s map =3D %#x\n",
                        is_tx ? "tx channel" : "rx slot",
                        e->texts[mux], map[slot_channel_no]);

        if (e->w && e->w->power)
                ret =3D sst_send_slot_map(drv);
		^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Here is the widget is powered up then we send the updated slot map to DSP.

So it will be updated real time now :)

--=20
~Vinod


--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJUG+egAAoJEHwUBw8lI4NHBM4P/0Vdy6AyGm/S1wy1SGd6OC7d
ZTFFABxtHougeDpj7TNGs8bQI+MQ1BnpzpmrE/cywKNk/RbrUktucHOQmd73ZBEU
+Al7BhAjvL6+VbaKM/VT+Xuuwau3KMuSFDuO9vh0M/ygCbn3lexIC9Oyx30mrz3c
0/15QbjB2fhOCzBW9iD1EL0SURWvCICDI1mVqSJQBwSQnzyd0UepALk4mtzzFQlw
s61n76tph9vmbhE/VZ8/PgbF9eFENHY4k00viu5BBh0xnVbrF3tPv3DZgM1UEPA5
+nuF8eFquatyfOavJIrzqAReaNZsZCTtQtwVk8CJpW+O3yIr0aISCr/qEu1mfcMV
mu1Zn6GvZZ+nXNygqVtt8k+82Wbp1yHbooWrHkh3SFmmr3GWHjvGUzqCJUs2bBSx
uRPPxaE9nZftSGbqN7uiquw4IktQ4y1xanEPe788ZPschThDpUqVuKg7QS/fzgvd
uBzX4uhiI2iHAhp2zaB1vwq24AT3PxxXQTd4S8csimW/2bGmXLlZInNhUw38F2W8
HtEuvyZb4c5ZfFnIKiKfZjG8xF5WWqns7QkZF3koCluO2fLwnXX4/EqoRE/7bTV1
KuUFY8pkDiE+o0yViJ7Tsp/ZAGKNLotyGuyRfX27XQEfcAlsVUQl5onwGVUtLWLc
IldewXMY/DIC1ipWGKPi
=xztB
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--

--===============2354421067702023243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2354421067702023243==--
