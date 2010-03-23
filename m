From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: PM fix for output amplifiers
Date: Tue, 23 Mar 2010 09:59:13 +0200
Message-ID: <201003230959.14186.peter.ujfalusi@nokia.com>
References: <1269264967-2003-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100322161928.GA30295@rakim.wolfsonmicro.main>
	<201003230905.39319.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 59DB01037F7
	for <alsa-devel@alsa-project.org>; Tue, 23 Mar 2010 08:59:43 +0100 (CET)
In-Reply-To: <201003230905.39319.peter.ujfalusi@nokia.com>
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

On Tuesday 23 March 2010 09:05:39 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> In any ways the output gains has to be handled with custom code no matter
> if the core has support for binding the volume controls to DAPM widget or
> not. The root of the problem is how the amplifiers are working:
> bit 4-5: Gain
> 0x0 - power down (mute)
> 0x1 - 6dB
> 0x2 - 0dB
> 0x3 - -6dB
> =

> I don't have separate power bit.
> I can not just invert the range.
> I need to do the following:
> If 0 is coming, than I write that (mute, power down)
> If 2, than write two
> For 1 I write 3
> For 3 I write 1
> This gives nice gain range for the user space.
> 0x0 - power down (mute)
> 0x1 - -6dB
> 0x2 - 0dB
> 0x3 - 6dB

I just wonder, would something like this work:

Instead of the custom SOC_DOUBLE_R_TLV_TWL4030, which handles the output ga=
ins:

/*
 * Gain controls tied to outputs
 * -6 dB to 6 dB in 6 dB steps (mute instead of -12)
 */
static const unsigned int output_tlv[] =3D {
	TLV_DB_RANGE_HEAD(4),
	0, 0, TLV_DB_SCALE_ITEM(-1200, 0,  1),
	3, 3, TLV_DB_SCALE_ITEM(-600, 0, 0),
	2, 2, TLV_DB_SCALE_ITEM(0, 0, 0),
	1, 1, TLV_DB_SCALE_ITEM(600, 0, 0),
};

SOC_DOUBLE_R_TLV("PreDriv Playback Volume",
	TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
	4, 3, 0, output_tvl),

I'm not sure about the tlv declaration, but is there a way to actually map =
the =

gain/power control in the TWL in a standard way?

-- =

P=E9ter
