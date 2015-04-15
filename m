From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: Understanding Atmel SSC SND_SOC_DAIFMT_CBS_CFS mode
Date: Wed, 15 Apr 2015 21:57:59 +0200
Message-ID: <CA+TH9VkQTDcpMpsvkW2pFC_QDjdmwnoSK5UsJAqxFOwDvqbmGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sound-owner@vger.kernel.org>
Sender: linux-sound-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Bo Shen <voice.shen@atmel.com>, linux-sound@vger.kernel.org, sedji.gaouaou@atmel.com, fmandarino@endrelia.com, Nicolas Ferre <nicolas.ferre@atmel.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi List,

I'm looking for a way to understand how to correctly configure the
Atmel SSC dai on a SAMA5D3 to work in master mode with an I2S codec.

=46rom this comment:

 /*
 * I2S format, SSC provides BCLK and LRC clocks.
 *
 * The SSC transmit and receive clocks are generated
 * from the MCK divider, and the BCLK signal
 * is output on the SSC TK line.
 */

My question is: should be MKC configured manually? If yes how?

Actually the driver I wrote works form the most part (I2C codec
conf=ECguration for example) but nothing exits form the SSC lines, at
least my oscilloscope says that.

Unfortunately I cannot find any example on Atmel sound soc/codecs on
how to do that, all the driver distributed (atmel_wm8904.c 4849,
sam9g20_wm8731.c, sam9x5_wm8731.c) in kernel tree use the
SND_SOC_DAIFMT_CBM_CFM mode, so configure the SSC to be a slave
device.

Any advice?

Thank you!
--
To unsubscribe from this list: send the line "unsubscribe linux-sound" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
