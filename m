From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH - try2] ASoC: TPA6130A2 amplifier driver
Date: Mon, 12 Oct 2009 10:37:50 +0300
Message-ID: <200910121037.50749.peter.ujfalusi@nokia.com>
References: <1255092941-17586-1-git-send-email-peter.ujfalusi@nokia.com>
	<20091009181538.GB20083@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 8F33324584
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 09:38:06 +0200 (CEST)
In-Reply-To: <20091009181538.GB20083@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Friday 09 October 2009 21:15:38 ext Mark Brown wrote:
> On Fri, Oct 09, 2009 at 03:55:41PM +0300, Peter Ujfalusi wrote:
> > +struct i2c_client *tpa6130a2_client;
> =

> This should be static.

Yes, it should

> =

> > +void tpa6130a2_power(int power)
> > +{
> =

> This should either be static or have an EXPORT_SYMBOL_GPL() - I'd expect
> the former since this is being managed via DAPM.

Will be static, since it should be handled by the tpa6130a2 driver internal=
ly.

> =

> > +	pdata =3D (struct tpa6130a2_platform_data *)client->dev.platform_data;
> =

> You should never need to cast away from void, and doing so can mask
> actual errors.

Yes.

> =

> > +fail:
> > +       kfree(data);
> > +       i2c_set_clientdata(tpa6130a2_client, NULL);
> > +       tpa6130a2_client =3D 0;
> =

> The kernel coding style is to use an explict NULL.

Correct.

> =

> Other than that everything looks good so I've applied this with the
> fixes I noted above.  If you could send a followup patch for the
> tpa6130a2_power export/static thing that'd be good.

I'll send a patch to make the tpa6130a2_power static.

> =

> Thanks!
> =



Thanks,
P=E9ter
