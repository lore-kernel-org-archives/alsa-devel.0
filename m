From: =?UTF-8?Q?Andreas_M=C3=BCller?= <schnitzeltony@gmail.com>
Subject: RaspberryPi vc4-hdmi softvol for alsamixer
Date: Sat, 1 Sep 2018 18:28:34 +0200
Message-ID: <CALbNGRTnqK0tBKE_EynM5j=L5QLf2rUzuNGusUAW7Ne_xY-hSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id C2F1F267663
 for <alsa-devel@alsa-project.org>; Sat,  1 Sep 2018 18:28:37 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id t68-v6so26907872oie.12
 for <alsa-devel@alsa-project.org>; Sat, 01 Sep 2018 09:28:37 -0700 (PDT)
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

This is my first post here and guess what I am looking for support :)

Up to now I used audioinjector and hifiberry on RaspberryPi and that
worked without issues (from alsa point of view).

Now I would like to select vc4hdmi on alsamixer but that complains for
missing controls. I think vc4hdmi does not support hard volume setting
- like some other devices.

So I read here and there and found softvol. To test I modified
vc4-hdmi.conf shipped with alsal-iib from:

# default with dmix
vc4-hdmi.pcm.default {
    @args [ CARD ]
    @args.CARD {
        type string
    }
    type asym
    playback.pcm {
        type plug
        slave.pcm {
            @func concat
            strings [ "dmix:" $CARD ]
        }
    }
}

to (stolen from  PC-Speaker.conf)

# default with dmix
vc4-hdmi.pcm.default {
    @args [ CARD ]
    @args.CARD {
        type string
    }
    type asym
    playback.pcm {
        type plug
        slave.pcm {
            type softvol
            control {
                name "Master Playback Volume"
                card $CARD
            }
            slave.pcm {
                @func concat
                strings [ "dmix:" $CARD ]
            }
        }
    }
}

after reboot nothing changes! I build my images with
Openembedded/Yocto and from my experience it is possible that there is
some misconfiguration / path issue causes problems. I know the card
works with the help of pulseaudio.

So now my questions:
* Would you expect that my modification of vc4-hdmi.conf adds softvol
control to vc4hdmi?
* If yes: The only information I have currently: It does not work as
expected. So where can I ask alsa for some feedback what went wrong
(log-files/dmesg/journal...)?

Thanks in advance

Andreas
