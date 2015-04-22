From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 2/9] ASoC: hda: Add IPC library for SKL
	platform
Date: Wed, 22 Apr 2015 09:24:53 +0530
Message-ID: <20150422035453.GE2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-3-git-send-email-vinod.koul@intel.com>
 <20150420215639.GY14892@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6658057017398995911=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F4D82604AE
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 05:57:30 +0200 (CEST)
In-Reply-To: <20150420215639.GY14892@sirena.org.uk>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6658057017398995911==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2015 at 10:56:39PM +0100, Mark Brown wrote:
> On Fri, Apr 17, 2015 at 06:46:00PM +0530, Vinod Koul wrote:
>=20
> > +
> > +/* IPC data */
> > +struct ssth_ipc {
> > +	struct device *dev;
> > +	struct ssth_lib *dsp;
> > +
> > +/* IPC messaging */
> > +	struct list_head tx_list;
>=20
> Lots of odd indentation of comments in this code (well, several examples
> I noticed so far anyway).
>=20
> > +	if (ret =3D=3D 0)
> > +		ret =3D -ETIMEDOUT;
> > +	else {
> > +	/* copy the data returned from DSP */
>=20
> Coding style - { } on both sides of the if (and the comments again).
Ah sorry about that, I did try to fix style issues in code but looks like
few were missed. I will fix them in the patch series.
>=20
> > +		if (msg->rx_size) {
> > +			if (rx_data)
> > +				memcpy(rx_data, msg->rx_data, msg->rx_size);
> > +			else
> > +				dev_err(ipc->dev, "error: no output buffer");
> > +		}
> > +		ret =3D msg->errno;
> > +	}
> > +
> > +	ssth_ipc_msg_put_empty(ipc, msg);
> > +
> > +	spin_unlock_irqrestore(&ipc->ipc_lock, irq_flags);
>=20
> Can we pop the message off the list, release the lock and then copy?
> That way we can avoid having interrupts disabled while we do the
> memcpy().  In general there seems to be a lot of interrupts disabled
> copying going on (which is there for some of the other drivers too)
> which might be avoidable.
Thanks for pointing, yes this should be done.
>=20
> > +static void ssth_ipc_reply_remove(struct ssth_ipc *ipc, struct ssth_ip=
c_message *msg)
> > +{
> > +	unsigned long irq_flags;
> > +
> > +	spin_lock_irqsave(&ipc->ipc_lock, irq_flags);
> > +	if (list_empty(&ipc->rx_list)) {
> > +		dev_dbg(ipc->dev, "empty rx list");
> > +		goto out;
> > +	}
> > +	list_del(&msg->list);
> > +
> > +out:
> > +	spin_unlock_irqrestore(&ipc->ipc_lock, irq_flags);
> > +}
>=20
> Are we expecting to not find the message/
For reply case, I am not sure. I think if thats true would make sense to
complain loudly..

>=20
> > +	if (IPC_GLB_NOTIFI_MSG_TYPE(header.primary)) {
> > +		switch (IPC_GLB_NOTIFI_TYPE(header.primary)) {
> > +		case IPC_GLB_NOTIFCATION_GLITCH:
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_OVERRUN:
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_UNDERRUN:
> > +			dev_dbg(ipc->dev, "FW UNDERRUN\n");
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_END_STREAM:
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_PHRASE_DETECTED:
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_RESOURCE_EVENT:
> > +			dev_dbg(ipc->dev, "MCPS Budget Violation\n");
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_LOG_BUFFER_STATUS:
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_TIMESTAMP_CAPTURED:
> > +			break;
> > +		case IPC_GLB_NOTIFCATION_FW_READY:
> > +			ipc->boot_complete =3D true;
> > +			wake_up(&ipc->boot_wait);
> > +			break;
>=20
> More prints perhaps?  _PHRASE_DETECTED looks interesting, as does
> _OVERRUN.
Overrun is FW detectiong its pipelines are overunning the buffer, no the
ALSA ring buffer though. _PHRASE_DETECTED is for keyword detection which can
run on dsp

Thanks
--=20
~Vinod

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVNxuNAAoJEHwUBw8lI4NHYI0QAMssnTzAuXiZvZMZSxQP2FhU
TVMfxiOOeGmVZJGaiK/YEY/bfwlEhVhRNLItrw7GuyzbL5ukZShoTtmEKq4rz2JR
YmQDWFRLcsIho+BlnOQd/tggyc/mAw0Gt/X54Cd+4yh+PoAchqHugqqHj2z8gUfM
WDc7RMFn60oLQw/m06YsJrWyyKrupqM8H9Hje5/ZvIHn7EjPSHFBujVC5H6kf5mI
KC1lXFmmfPvQKDQHqzbXkTHTLKzZ6OWeKbf1Z3f0XemWUFMDvDeFARUGoPqM7N5+
CUwluUWDmOm09MzLsaECM3pOHETgKUN/t0WaRkpo/w9PIQRjarCKo/zbbqSjUc95
jLQ+wiYYpn5vbNAcKgX+x9gR/NQIm5c7avySvgiQ5m/3Byh4F+s8Mjhj9p6EP4Tm
Ws1UP3qv1r+uh3XVv9Uticsx7/2mPwD8ItpHeHMOQknJY1EMxjMX+zBacG+r7MMN
vgsimaRa+rnp7nMZL678wzvri58V2Vp04LMwx1nShcZKkPUOl/HwKDM+ZR/cC6qx
6xSWDtrxbLLfJNq7/EdAhVnmXd8osepRDQZM6kw+p0d/12Fpu8Vm4cbE0xSyJhNN
4jx5gRG9SKDdStTZYkI/IrYS0XIfIDX/XnDrJzaOUEpcFIOAemcVIqkIuYRxK29Y
v7E3/LFhcjRTlnPW0rBp
=Sd2I
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--

--===============6658057017398995911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6658057017398995911==--
