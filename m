From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Tue, 08 May 2012 15:42:41 +0300
Message-ID: <4FA914C1.904@ti.com>
References: <1336477945-27460-1-git-send-email-peter.ujfalusi@ti.com>
	<20120508122630.GM15893@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog130.obsmtp.com (na3sys009aog130.obsmtp.com
	[74.125.149.143])
	by alsa0.perex.cz (Postfix) with ESMTP id D218D1042CC
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 14:42:28 +0200 (CEST)
Received: by lahc1 with SMTP id c1so4665590lah.26
	for <alsa-devel@alsa-project.org>; Tue, 08 May 2012 05:42:25 -0700 (PDT)
In-Reply-To: <20120508122630.GM15893@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, "Cousson, Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On 05/08/2012 03:26 PM, Mark Brown wrote:
> On Tue, May 08, 2012 at 02:52:25PM +0300, Peter Ujfalusi wrote:
> =

>> +static const struct of_device_id twl6040_codec_of_match[] =3D {
>> +	{.compatible =3D "ti,twl6040-codec", },
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, twl6040_codec_of_match);
> =

> Why are we loading MFD components using device tree?  It seems like
> we're doing something very wrong if we need people to explicitly write
> this stuff out in the device tree, the whole MFD thing is purely a Linux
> implementation detail, as is the way the interrupt controller has been
> structured.  I'd really not expect to see a specific node like this,
> especially not one that does nothing but device registration.

I have based the twl6040 DT structure on the already existing twl4030,
twl6030 MFD parts.
After all the twl6040 provides audio, vibra and it will also provide GPO
(it has general purpose outputs - the driver is under development for
this function).
Also without a DT entry I will not have a way to use phandle to connect
the codec in the machine driver.
I would expect other operating systems should be able to sue this
structure since in every environment there must be a way to handle MFD
devices.

-- =

P=E9ter
