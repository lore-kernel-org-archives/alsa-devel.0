From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Mon, 14 May 2012 14:38:20 +0300
Message-ID: <4FB0EEAC.6060204@ti.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
	<4FACF1C2.7050008@ti.com>
	<20120511130816.GB3960@opensource.wolfsonmicro.com>
	<4FAD33D3.3050104@ti.com>
	<20120511203425.GB29835@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 4755D104107
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 13:38:15 +0200 (CEST)
Received: by lban1 with SMTP id n1so3849310lba.24
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2012 04:38:13 -0700 (PDT)
In-Reply-To: <20120511203425.GB29835@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Samuel Ortiz <sameo@linux.intel.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Misael Lopez Cruz <misael.lopez@ti.com>, Liam Girdwood <lrg@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>
List-Id: alsa-devel@alsa-project.org

On 05/11/2012 11:34 PM, Mark Brown wrote:
> The issue is the tastefulness.  Just looking at the binding it's
> immediately clear that the only thing that the extra levels of
> indirection are adding is the removal of the mfd_add_cells() call from
> the MFD driver which isn't particularly helping anything and is
> basically Linux specific.

It is not really a coincident that we have the drivers structured in a
way they are at the moment (with or without MFD).
We have several functionality provided by this chip (twl6040). In one
chip it provides audio (twl6040-codec), vibra (twl6040-vibra) and we are
going to have few more additions as well (GPO, clock driver to provide
the McPDM functional clock).

We might see more integrated solution in a future which would combine
the current pmic and the audio in a single chip. If this happens we can
just use the dts sections describing the functionalities of the twl6040
appended to this - theoretical - chip.
The child (or drivers for the functionality) only needs small update for
compatible_of, and new chip access wrapper.
In this case the core chip driver (twl6040 MFD) will no longer
exist/make sense since the functionality provided by the twl6040 chip
has been merged together with the PMIC.

You might be right that the resulting dts section for the chip is just
represents the current MD stack, but if I want to prepare for the future
this is the way I think is the best for us.

-- =

P=E9ter
