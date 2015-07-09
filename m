From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/6] ASoC: Intel: Add Skylake IPC library
Date: Thu, 9 Jul 2015 10:56:13 +0530
Message-ID: <20150709052613.GK836@localhost>
References: <1435919647-14049-1-git-send-email-vinod.koul@intel.com>
 <1435919647-14049-6-git-send-email-vinod.koul@intel.com>
 <20150708184627.GB11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7285797721077738831=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E4D28265D8D
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2015 07:24:34 +0200 (CEST)
In-Reply-To: <20150708184627.GB11162@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7285797721077738831==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PWfwoUCx3AFJRUBq"
Content-Disposition: inline


--PWfwoUCx3AFJRUBq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2015 at 07:46:27PM +0100, Mark Brown wrote:
> On Fri, Jul 03, 2015 at 04:04:06PM +0530, Vinod Koul wrote:
>=20
> Mostly looks good - a few small things here, nothing too major:
>=20
> > +static struct ipc_message *skl_ipc_reply_find_msg(struct sst_generic_i=
pc *ipc,
> > +		u64 ipc_header)
> > +{
> > +	struct ipc_message *msg =3D NULL;
> > +	struct skl_ipc_header *header =3D (struct skl_ipc_header *)(&ipc_head=
er);
> > +
> > +	if (list_empty(&ipc->rx_list)) {
> > +		dev_err(ipc->dev, "ipc: rx list is empty but received 0x%x\n",
> > +			header->primary);
> > +		goto out;
> > +	}
> > +
> > +	msg =3D list_first_entry(&ipc->rx_list, struct ipc_message, list);
>=20
> This says it finds the message but it appears to just return the head of
> the list without reference to the supplied header other than casting it
> to skl_ipc_header and possibly using it in an error print?
Yes you are right. Actually currently we dont expect to queue up so we never
bother looking up. But yes intention to find messages when they are quued, I
will add that bit

> > +irqreturn_t skl_dsp_irq_thread_handler(int irq, void *context)
> > +{
> > +	struct sst_dsp *dsp =3D (struct sst_dsp *)context;
> > +	struct skl_sst *skl =3D sst_dsp_get_thread_context(dsp);
> > +	struct sst_generic_ipc *ipc =3D &skl->ipc;
> > +	struct skl_ipc_header header =3D {0};
> > +	u32 hipcie, hipct, hipcte;
> > +	int ipc_irq =3D 0;
> > +
> > +	/* Here we handle IPC interrupts only */
> > +	if (!(dsp->intr_status & SKL_ADSPIS_IPC))
> > +		return IRQ_HANDLED;
>=20
> Shouldn't we be returning IRQ_NONE if we didn't handle the interrupt?
Yes this is wrong, will fix

>=20
> > +		if (IPC_GLB_NOTIFY_RSP_TYPE(header.primary)) {
> > +			/* Handle Immediate reply from DSP Core */
> > +			skl_ipc_process_reply(ipc, header);
> > +		} else {
> > +			trace_printk("IPC irq: Notification from firmware\n");
> > +			skl_ipc_process_notification(ipc, header);
> > +		}
>=20
> Why trace_printk()?
Dont see a reason, this should be a printk, will fix
>=20
> > +int skl_ipc_set_dx(struct sst_generic_ipc *ipc, u8 instance_id,
> > +		u16 module_id, struct skl_ipc_dxstate_info *dx)
> > +{
> > +	struct skl_ipc_header header =3D {0};
> > +	u64 *ipc_header =3D (u64 *)(&header);
> > +	int ret;
> > +
> > +	header.primary =3D IPC_MSG_TARGET(IPC_MOD_MSG);
> > +	header.primary |=3D IPC_MSG_DIR(IPC_MSG_REQUEST);
> > +	header.primary |=3D IPC_GLB_TYPE(IPC_MOD_SET_DX);
> > +	header.primary |=3D IPC_MOD_INSTANCE_ID(instance_id);
> > +	header.primary |=3D IPC_MOD_ID(module_id);
> > +
> > +	dev_dbg(ipc->dev, "In %s primary =3D%x ext=3D%x\n", __func__,
> > +			 header.primary, header.extension);
> > +	ret =3D sst_ipc_tx_message_wait(ipc, *ipc_header,
> > +			(void *)dx, sizeof(dx), NULL, 0);
>=20
> If you need to cast a pointer to void something is wrong...  I suspect
> you just don't need the cast though.
yes i rechecked. The API expects void pointer for buffer for IPC payload and
will copy that. We need not cast it though

Thanks for quick review
--=20
~Vinod

--PWfwoUCx3AFJRUBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVngX1AAoJEHwUBw8lI4NHkHgP/R0EkspmrLD3GSZ7kk5SjT2C
sAdyeRreNGc8IUrCKVk17gKukTQq/jbCIyZsHRw6WiZlMzEMKucZNjrWLLS/nEgb
5TQWDwAxsAD8SIgS6djBIgWM28P0xk3pELioPmivxaHSSYtXuDC7u5x4XCX/ragk
fYu41Oolies3vm5ODp1avdq8FahGZaWQOR5TaFr9ueziCzdkQ7XXS0Muk3Dvgklk
/eubf3aBShkoZfg+ookDoAbU/3BkafGT5RDdrhswC3qL92wKIyTOKeoGKwvERLxa
KVh4TWZrEHhE0C03ZusRtwHPgRG6xTa4of8qTo+D4nQvrMoxbiVgoU8a0fkfepmh
MSc7aor3tsImmeRXj1VkSEjJgg8tcBfzO0tr/sz2+dxOTavwJ/uvrP4NQxwZyOIz
l8RhLtVWpfhL6u56Ejl3EID30wKsAjurcaTMDTJfMlVeCt4W2lLzNGSQ5BzCqLp3
5ezYx8L1peFJP4d8WWETUFTTaXDpOEZjrhmGsgTNizX1UAg9+KM86jdD2XEQlh5s
BEkYRF5kC8s6m3AEo39hz4KBckBmbeqFLH84VD60VQecxgIe5BMh3buE4lWsTJ8N
2KiYyeksIbJzQhbmSIaVFwRUzDRJH05W9CRrlK4A6LWdo4EhA8R/v8frNUqJrJFe
EPsb9qJR2GBTIxmT+cMX
=mFeV
-----END PGP SIGNATURE-----

--PWfwoUCx3AFJRUBq--

--===============7285797721077738831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7285797721077738831==--
