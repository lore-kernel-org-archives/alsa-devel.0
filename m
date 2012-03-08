From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 00/11] ASoC: add imx-sgtl5000 machine
 driver working with fsl_ssi
Date: Thu, 8 Mar 2012 14:05:02 -0600
Message-ID: <4F5910EE.8090408@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 29C401041E8
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 21:05:18 +0100 (CET)
In-Reply-To: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> I did not pick up you Ack-by tag, because there are some changes since
> v2 you will need to take another look and have the testing, I guess.

Unfortunately, although it works on the MPC8610, it's broken on the P1022:

# speaker-test -t sine -c 2 -r 44100


speaker-test 1.0.11rc2


Playback device is default
Stream parameters are 44100Hz, S16_BE, 2 channels
Sine wave rate is 440.0000Hz
Rate set to 44100Hz (requested 44100Hz)
Buffer size range from 256 to 32768
Period size range from 128 to 16384
Periods = 4
Buffer time size 575
To choose buffer_size = 32768
To choose period_size = 8192
was set period_size = 8192
was set buffer_size = 32768

At this point, nothing else happens, there's no audio, and even Ctrl-C
doesn't work.

-- 
Timur Tabi
Linux kernel developer at Freescale
