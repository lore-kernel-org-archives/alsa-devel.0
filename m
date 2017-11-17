From: Kalle Kankare <kalle.kankare@vincit.com>
Subject: Again about regression introduced by commit
 70d435ba1cd6 ("ASoC: imx-pcm-dma: simplify pcm_config")
Date: Fri, 17 Nov 2017 16:27:22 +0200
Message-ID: <CAFuYjm4vdToNBsurLrDUruwnUTJGpj0qH_1b9+0g9jEmqtkbUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com
 [209.85.223.170])
 by alsa0.perex.cz (Postfix) with ESMTP id E313C26721A
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 15:27:24 +0100 (CET)
Received: by mail-io0-f170.google.com with SMTP id v21so8919710ioi.4
 for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2017 06:27:24 -0800 (PST)
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
Cc: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

The regression was previously discussed on this mailing list last month
(2017-10-04).

As in the previous discussion, this commit restricts the supported sound
formats to S24_LE. This problem is experienced in our iMX6q based hardware
with SGTL5000 sound chip. I.e.:

# arecord -l | grep 'card 0' -A2
card 0: imx6qba16sgtl50 [imx6q-ba16-sgtl5000], device 0: HiFi sgtl5000-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

In kernel 4.11.0:

# arecord --dump-hw-params -D hw:0,0 2>&1 | grep '^FORMAT'
FORMAT:  S16_LE

And in now in kernel 4.13.3:

# arecord --dump-hw-params -D hw:0,0 2>&1 | grep '^FORMAT'
FORMAT:  S24_LE

By reverting the mentioned commit 70d435ba1cd6, the format returned to
S16_LE. However, I'm unsure if that is the proper way to solve this issue.
I.e. does reverting the mentioned commit cause some other unwanted effect ?

What would be the best solution that would make the S16_LE format supported
again for SGTL5000 ?
