From: =?ISO-8859-1?Q?st=E9phane_cerveau?= <scerveau@gmail.com>
Subject: IMX WM8740 I2S support
Date: Wed, 25 Sep 2013 15:08:02 +0200
Message-ID: <5242E032.3060706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 75E0A265388
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 15:08:09 +0200 (CEST)
Received: by mail-wi0-f179.google.com with SMTP id hm2so5497324wib.0
 for <alsa-devel@alsa-project.org>; Wed, 25 Sep 2013 06:08:09 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Dear all,

I'm currently working on supporting WM8740 device software configured =

with imx6q system.
For now my driver seems to be configured correctly. The playback is =

launched but i get:
  ALSA sound/core/pcm_lib.c:1822 playback write error (DMA or IRQ trouble?
write error: Input/output error

The imx ssi is not sending me any data on I2S bus( nothing can be seen =

on the oscillo).

I would like to know how do I have to configure my master clock in order =

to launch the I2S. My master clock is for now 24MHz.
Sorry to be confused a bit but i'm quite newbie with this device.
Best regards.

St=E9phane
