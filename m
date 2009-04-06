From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: ASoC: Correct DSP/TDM mode (for twl4030 4 channel mode)
Date: Mon, 6 Apr 2009 09:57:43 +0300
Message-ID: <200904060957.43102.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 060C0103801
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Apr 2009 08:58:04 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: ext Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

I have now the implementation for the 4 channel support on the twl4030 code=
c =

driver (and also for the omap-mcbsp). It does work nicely, but I'm not sure =

what Interface format (DSP_A or DSP_B or TDM?) should I use for it.

Can someone help me out on this one?

The TPS65950 TRM is publicly available, which has exactly the same audio =

block:
http://focus.tij.co.jp/jp/lit/ug/swcu050b/swcu050b.pdf
Page 712 (TDM mode, Sample length 16 bits; Word length 16 bits)

My bet goes to SND_SOC_DAIFMT_DSP_A, but I'm not 100% sure about it.

Thank you,
P=E9ter
