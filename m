From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
	FIFO state query
Date: Thu, 4 Mar 2010 09:53:21 +0200
Message-ID: <201003040953.21534.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1FFEF31EBAA4F64B80D33027D42977602148968E68@NOK-EUMSG-02.mgdnok.nokia.com>
	<1FFEF31EBAA4F64B80D33027D42977602148968E69@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id D223D103821
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 08:53:36 +0100 (CET)
In-Reply-To: <1FFEF31EBAA4F64B80D33027D42977602148968E69@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wednesday 03 March 2010 21:07:21 Nurkkala Eero.An (EXT-Offcode/Oulu) wro=
te:
> > what went wrong? (the pcm pointer w/dma pos never missed that
> > greatly)
> > Very unlikely that an IRQ just happened to come in between the
> > register reads..with that frequency (> 1/50)
> =

> Just to make sure:
> =

> +void omap_mcbsp_buffstat(unsigned int id, unsigned int *xbuffstat,
> +				unsigned int *rbuffstat)
> +{
> +	struct omap_mcbsp *mcbsp;
> +
> +	if (!(cpu_is_omap2430() || cpu_is_omap34xx()))
> +		return;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return;
> +	}
> +
> +	mcbsp =3D id_to_mcbsp_ptr(id);
> +	*xbuffstat =3D OMAP_MCBSP_READ(mcbsp->io_base, XBUFFSTAT);
> +	*rbuffstat =3D OMAP_MCBSP_READ(mcbsp->io_base, RBUFFSTAT);
> +}

Yes, and your sysfs read function was actually calling the omap_mcbsp_buffs=
tat, =

and than it prints out both of the buffstat in one line.

> =

> see, the above is not trusted. However, it's 100% trusted to read off
> the timestamps recorded at DMA IRQ callback. (and at that time the buffer
> has just been filled up.).

Well, in element mode it would be kind of safe to report the FIFO size as d=
elay =

in all cases.
But in threshold mode it is a bit different.
It all depends how the threshold value has been configured:
For example
if the threshold is 400, than at startup you will have three consequent bur=
sts =

filling the buffer to 1200, and leaving 80 locations still free in the buff=
er. =

But as the playback progresses and we have 400 free locations, than the DMA=
 will =

be filling the FIFO to close to full.

if the threshold is 1024, than you will have one burst at startup, the buff=
er =

will have 1024 location filled and 256 free. But as the playback progresses=
 and =

we have 1024 free locations, than the DMA will be filling the FIFO to close=
 to =

full.

So yes, over time you will get pretty close estimation about the delay.

But I still think, that my proposal also gives pretty good estimation about=
 the =

delay as well.

> =

> =

> - Eero

-- =

P=E9ter
