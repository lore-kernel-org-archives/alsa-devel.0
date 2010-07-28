From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320dac33: Revisit the FIFO
	Mode1 handling
Date: Wed, 28 Jul 2010 08:08:31 +0300
Message-ID: <201007280808.54390.peter.ujfalusi@nokia.com>
References: <1280213177-15439-1-git-send-email-peter.ujfalusi@nokia.com>
	<1280213177-15439-2-git-send-email-peter.ujfalusi@nokia.com>
	<20100727163243.GA18884@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 1109E10382C
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 07:09:11 +0200 (CEST)
In-Reply-To: <20100727163243.GA18884@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: ext Mark Brown <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 27 July 2010 19:32:44 ext Mark Brown wrote:
> I did notice that the default changes from 20ms:
> > -#define LATENCY_TIME_MS		20
> > =

> > +	if (!dac33->mode1_i2c_latency)
> > +		dac33->mode1_i2c_latency =3D 10000; /* 10ms */
> =

> to 10ms with the new code but that shouldn't be a problem.

Correct.
The LATENCY_TIME_MS was used for two things:
 alarm threshold =3D LATENCY_TIME_MS / 2
 nSample lower limit =3D LATENCY_TIME_MS

The new default (10ms) comes from the old alarm threshold time.

There is no real need to limit the nSample for higher value, it is safe to =
use =

the same time constraint for alarm threshold and nSample lower limit.
The important thing is actually the alarm threshold value here: we need to =
have =

enough time to handle the interrupt, schedule the work, and write to nSampl=
e =

registers (via i2c) within certain amount of time.
Probably naming the mode1_i2c_latency differently, like mode1_latency would=
 be =

better.

Probably it would be better if I resend the series with this change?

Thanks,
P=E9ter
