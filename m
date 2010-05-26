From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: imx-ssi.c & SND_SOC_DAIFMT_I2S
Date: Wed, 26 May 2010 11:34:08 +0200
Message-ID: <4BFCEB10.6000205@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 27.mail-out.ovh.net (27.mail-out.ovh.net [91.121.30.210])
	by alsa0.perex.cz (Postfix) with SMTP id 7701C103821
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 11:34:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Sascha,

while trying to get a TI TLV320AIC23B codec configured as I2S master to 
work with an i.MX27 using the latest git kernel, I noticed there may be 
a problem in the slave I2S setting in imx-ssi.c

Please find two captures of the I2S bus signals :
- http://eukrea.com/tmp/initial_i2s.png : this is not an I2S signal, 
both left & right are sent while Frame Sync is high (so I only get mono 
output)
- http://eukrea.com/tmp/i2s_slave.png : when I set I2S_MODE to 0x2 in 
SCR register (scr |= SSI_SCR_NET | 0x40; at line 101 of imx-ssi.c), thus 
setting the SSI in "I2S slave mode", I get a real I2S signal as shown on 
this capture.

I understand the actual I2S configuration may work with the Freescale's 
PMIC but this chipset may not be fully I2S compliant and I think that 
the actual setting prevent real I2S codecs from being used with the i.MX.

Am I wrong here ?
Shouldn't we use the I2S slave mode of the SSI instead of what is done 
actually ?

Thanks and best regards,
Eric
