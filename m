From: Fabio Estevam <festevam@gmail.com>
Subject: aplay lists both Playback and Capture devices
Date: Wed, 29 May 2013 18:32:56 -0300
Message-ID: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f41.google.com (mail-vb0-f41.google.com
 [209.85.212.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C3E26506D
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 23:32:57 +0200 (CEST)
Received: by mail-vb0-f41.google.com with SMTP id p14so6781662vbm.0
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 14:32:56 -0700 (PDT)
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
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

When running 'aplay -l' and 'arecord -l' I see the following output on
a mx28evk running a 3.10-rc kernel:

/$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: mxssgtl5000 [mxs_sgtl5000], device 0: Playback sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: mxssgtl5000 [mxs_sgtl5000], device 1: Capture sgtl5000-1 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

I would expect to see only the Playback entry in aplay and only the
Record entry in arecord.

Is there anything I should change in sound/soc/mxs/mxs-sgtl5000.c in
order to get the correct outputs?

Regards,

Fabio Estevam
