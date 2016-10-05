From: Fabio Estevam <festevam@gmail.com>
Subject: Audio on mx6q udoo
Date: Wed, 5 Oct 2016 15:15:35 -0300
Message-ID: <CAOMZO5DdwgYBbOG7sik-Wc34zEqfttOc3EZwsisFgzwtcbDPNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com
 [209.85.213.48])
 by alsa0.perex.cz (Postfix) with ESMTP id E656D2665DC
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 20:15:36 +0200 (CEST)
Received: by mail-vk0-f48.google.com with SMTP id b186so93624291vkb.1
 for <alsa-devel@alsa-project.org>; Wed, 05 Oct 2016 11:15:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

I am running today's linux-next on a imx6q-udoo board.

Removed USB support to avoid the hang and also enabled
CONFIG_SND_SOC_AC97_CODEC=y.

When I start a playback it seems to be running:

# aplay /root/clarinet.wav
Playing WAVE '/root/clarinet.wav' : Signed 16 bit Little Endian, Rate 44100 Hz

,but I don't get any sound out of the CN7 green jack.

I put the volumes at the maximum via alsamixer.

Any ideas?

Thanks,

Fabio Estevam
