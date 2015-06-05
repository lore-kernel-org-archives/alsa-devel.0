From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 02/23] ASoC: tas2552: Fix kernel crash
 when the codec is loaded but not part of a card
Date: Fri, 5 Jun 2015 09:57:59 +0300
Message-ID: <55714877.8060509@ti.com>
References: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
 <1433423075-14142-3-git-send-email-peter.ujfalusi@ti.com>
 <20150604162527.GJ14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id EF2B026672E
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 08:58:02 +0200 (CEST)
In-Reply-To: <20150604162527.GJ14071@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

On 06/04/2015 07:25 PM, Mark Brown wrote:
> On Thu, Jun 04, 2015 at 04:04:14PM +0300, Peter Ujfalusi wrote:
>> If the card is not part of any card the tas_data->codec is NULL since it=
 is
>> set only during snd_soc_codec_driver.probe, which is not yet called.
> =

>> @@ -120,6 +120,9 @@ static void tas2552_sw_shutdown(struct tas2552_data =
*tas_data, int sw_shutdown)
>>  {
>>  	u8 cfg1_reg;
>>  =

>> +	if (!tas_data->codec)
>> +		return;
>> +
> =

> This fixes the crash but isn't whatever the function is doing important
> (so we should fix by using regmap for the I/O or something)?

If the driver's snd_soc_codec_driver->probe is not called we do not initial=
ize
the amplifier.
This function would put the amp to software shutdown, which is the power up
state of the amp.

Hrm, it should use tas2552 instead of tas_dat for the tas2552_data to be
consistent with the rest of the driver.
I will add a patch for this in v3.

-- =

P=E9ter
