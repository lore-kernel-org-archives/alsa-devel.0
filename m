From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-sai: Add device tree nodes and
 its availiable check
Date: Mon, 13 Jan 2014 06:15:24 +0000
Message-ID: <8ea36054cbe745cf9ce5c5d4a786f9ff@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389319550-12238-1-git-send-email-Li.Xiubo@freescale.com>
 <20140110110900.GC29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 by alsa0.perex.cz (Postfix) with ESMTP id AE52E2619E5
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 07:15:35 +0100 (CET)
In-Reply-To: <20140110110900.GC29039@sirena.org.uk>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> > +	if (!np || !of_device_is_available(np))
> > +		return -ENODEV;
> > +
> 
> I would expect the of_device_is_available() check to be done by the
> driver core rather than by individual drivers - every single driver
> should have that check.  Is this not happening?  The check for np is OK
> though.

Yes, I hasn't found the core driver does that for now...

And IMO this is needed since the SAI driver is only base dts. And maybe
the device is not presently operational, but it might become operational
in the future (for example, something is not plugged in, or switched off).
Or A serious error was detected in the device, and it is unlikely to become
operational without repair...

And for now for the individual drivers, before calling the of_device_is_available
the '!np' check is need, because:
While in __of_device_is_available:
 >	status = of_get_property(device, "status", &statlen);
 >	if (status == NULL)
 >		return 1;
The status value returned from 'of_get_property()' will be NULL in two cases:
Firstly: the 'device' value (device node) is NULL.
Secondly: the 'status' property is actaully not exist.

If the device node is NULL, the __of_device_is_available will return true too,
that will mean the absent state of the 'status' property.


Thanks,

--
Best Regards,
Xiubo
