From: =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius.trainavicius@gmail.com>
Subject: Stream format conversion in SoC driver
Date: Tue, 27 Dec 2016 15:44:20 +0200
Message-ID: <CABpuRUPg8LC_+eFL3UBS-jWkQicpKmorvzhqjZW6p8xQ9P0ppw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f180.google.com (mail-ua0-f180.google.com
 [209.85.217.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 0AA79265DB7
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 14:44:22 +0100 (CET)
Received: by mail-ua0-f180.google.com with SMTP id v2so8246478uac.2
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 05:44:22 -0800 (PST)
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

Hi,

We are developing a soundcard for Raspberry Pi, you may find the current
driver source code here:
https://github.com/raspberrypi/linux/blob/rpi-4.4.y/sound/soc/bcm/pisound.c

The card natively supports 24 and 32 bit PCM streams at 48kHz, 96kHz and
192kHz, symmetric capture and playback.

Is it possible to have ALSA do the necessary format conversions for the PCM
streams in natively unsupported formats to the closest natively supported
format?

What would be required to enable it?

Thank you,
Giedrius.
