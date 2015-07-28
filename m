From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: rockchip rk3288 registration
Date: Tue, 28 Jul 2015 15:34:48 +0200
Message-ID: <CAOf5uwnkXjuMhfkos3kMzz1unRWv3mrc5eeB6+roFM5RoGGTgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id CC82926548F
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 15:34:48 +0200 (CEST)
Received: by lahh5 with SMTP id h5so68600856lah.2
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 06:34:48 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, jay.xu@rock-chips.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

I have created a simple sound card to test registration on i2s but I
have some problems
that after a while in SND_SOC_DAIFMT_CBM_CFM the device stop to register and
receive a input/output error. It means that I can not receive anymore
from the device

arecord -c 2 -r 96000 -f S32_LE -D hw:0 > record.pcm
Recording WAVE 'stdin' : Signed 32 bit Little Endian, Rate 96000 Hz, Stereo
arecord: pcm_read:2031: read error: Input/output error

The result size is a bit random. I have no problem on playback until
now. Any idea?

Michael
