From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Mixer volume/decibel mapping
Date: Fri, 21 May 2010 09:51:36 +0300
Message-ID: <201005210951.36495.peter.ujfalusi@nokia.com>
References: <201005191834.57919.vand2@gmx.de>
	<AANLkTimRTIwmzU2Dq4lgBSSwtcmSxfMcBfcll9YDC_l5@mail.gmail.com>
	<4BF629B3.9020904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 680E910399C
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 08:51:52 +0200 (CEST)
In-Reply-To: <4BF629B3.9020904@ladisch.de>
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
Cc: "Sebastian H." <vand2@gmx.de>, ext Clemens Ladisch <clemens@ladisch.de>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Friday 21 May 2010 09:35:31 ext Clemens Ladisch wrote:
> James Courtier-Dutton wrote:
> > I believe it could be extended to support a continuous range.
> > For example, some hardware uses a 32bit value to control the gain.
> > The mix operation is simply "the_sample" * "the_control_value".
> > So in this case the hardware has a linear control that can be
> > considered continuous for our purposes.
> =

> Such controls already exist:
> =

> $ grep -rl DB_LINEAR sound/
> sound/i2c/other/ak4xxx-adda.c
> sound/pci/oxygen/hifier.c
> sound/pci/oxygen/oxygen.c
> sound/pci/ymfpci/ymfpci_main.c
> sound/soc/codecs/stac9766.c
> sound/soc/codecs/wm8350.c
> sound/soc/codecs/wm8400.c
> sound/soc/codecs/wm8990.c

The DB_SCALE also provides linear mapping:
For example, if the HW volume control has a range 0 .. 100
In HW these means:
0 =3D=3D -10dB, 1 =3D=3D -9.8dB, 2 =3D=3D -9.6dB .. 99 =3D 9.8dB, 100 =3D 1=
0dB
So it is linear.

#define TLV_DB_LINEAR_ITEM(min_dB, max_dB)
#define TLV_DB_SCALE_ITEM(min, step, mute)

The
TLV_DB_LINEAR_ITEM(-1000, 1000); is essentially the same as
TLV_DB_SCALE_ITEM(-1000, 20, 0);
In this case

In linear, you specify the min, and max dB. The control provides the range =

(steps) in between the two ends.
In scale, you specify the minimum, and the steps for each control step.
At the end both are linear, and gives you exactly the same volume/dB pair.

> =

> > The conversion from the control value to a usable value would have to
> > include a user land log operation.
> > It was never implemented due to lack of demand.
> =

> It is implemented.
> =

> > For the cards that do have this 32bit linear value, a simple lookup
> > table is used in the kernel code to convert it to 256 step values.
> =

> Which driver is this?  It should be changed to use the full range.
> =

> =

> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

P=E9ter
