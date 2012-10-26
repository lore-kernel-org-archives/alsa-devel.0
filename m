From: Fabio Estevam <festevam@gmail.com>
Subject: Transmitting ac3 content via spdif
Date: Fri, 26 Oct 2012 17:30:49 -0200
Message-ID: <CAOMZO5AqmDEMOWO1JOaej4cgicyqvPeGfeTFO++Lu06VbNYewA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f51.google.com (mail-oa0-f51.google.com
 [209.85.219.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 55EE0265B78
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 21:30:50 +0200 (CEST)
Received: by mail-oa0-f51.google.com with SMTP id n12so2807995oag.38
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 12:30:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I am trying to transmit ac3 content via spdif on a mx6 (on a yet
non-mainlined driver).

Tried to force non-audio mode via iecset:

# iecset audio 0
control "IEC958 Playback Default" (index -1) not found

root@imx6qsabrelite:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: sgtl5000audio [sgtl5000-audio], device 0: HiFi sgtl5000-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 1: imxhdmisoc [imx-hdmi-soc], device 0: IMX HDMI TX mxc-hdmi-soc-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0

Transmitting a wav file works fine though.

Any suggestions as to how provide the "IEC958 Playback Default" control?

Thanks,

Fabio Estevam
