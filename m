From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: ASoC SSP Driver Question
Date: Mon, 10 Jan 2011 15:22:17 +0200
Message-ID: <4D2B0809.3060304@nokia.com>
References: <2A84145621092446B6659B8A0F28E26F47005A34FF@irsmsx501.ger.corp.intel.com>
	<4D2AF42F.80308@nokia.com>
	<2A84145621092446B6659B8A0F28E26F47005A3561@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 6209D244BF
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 14:22:31 +0100 (CET)
In-Reply-To: <2A84145621092446B6659B8A0F28E26F47005A3561@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Bensaid, Selma" <selma.bensaid@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Aaltonen Matti Johannes <matti.j.aaltonen@nokia.com>, "Le Gall,
	Louis" <louis.le.gall@intel.com>
List-Id: alsa-devel@alsa-project.org

On 01/10/11 14:46, ext Bensaid, Selma wrote:
> Yes, I'm planning to use this codec driver however I'm not sure that it =

> supports the FM capture. =

> According to the code, the codec handles the WL1273_MODE_BT mode only. =


The BT mode is the default, but the driver supports both FM TX and RX as
well. The change can be done via the "Codec Mode" ALSA control.

The driver in upstream supports the shared I2S lines only (shared
between BT/FM radio). The codec has dedicated FM I2S lines, but in the
HW we have it is not connected, but IMHO it can be easily added as
another DAI on the codec.

-- =

P=E9ter
