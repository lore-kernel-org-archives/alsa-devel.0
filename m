From: Paul Cercueil <paul@crapouillou.net>
Subject: simple-audio-card and headphone jack detect
Date: Fri, 18 Jan 2019 22:04:12 -0300
Message-ID: <1547859852.1824.0@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from crapouillou.net (outils.crapouillou.net [89.234.176.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 50357266C04
 for <alsa-devel@alsa-project.org>; Sat, 19 Jan 2019 02:04:20 +0100 (CET)
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

Hello,

I am using the simple-card and simple-amplifier drivers with the
following devicetree:

amp: audio-amp {
    compatible = "simple-audio-amplifier";
    enable-gpios = <&gpc 15 GPIO_ACTIVE_HIGH>;
};

sound-card {
    compatible = "simple-audio-card";

    simple-audio-card,name = "rs90-audio";
    simple-audio-card,format = "i2s";

    simple-audio-card,widgets =
        "Speaker", "Speaker",
        "Headphone", "Headphones";
    simple-audio-card,routing =
        "INL", "LHPOUT",
        "INR", "RHPOUT",
        "Headphones", "LHPOUT",
        "Headphones", "RHPOUT",
        "Speaker", "OUTL",
        "Speaker", "OUTR";

    simple-audio-card,hp-det-gpio = <&gpd 16 GPIO_ACTIVE_LOW>;
    simple-audio-card,aux-devs = <&amp>;

    simple-audio-card,cpu {
        sound-dai = <&aic>;
    };

    simple-audio-card,codec {
        sound-dai = <&codec>;

        bitclock-master;
        frame-master;
    };
};

My codec outputs on the LHPOUT/RHPOUT lines. INL/INR and OUTL/OUTR
are the inputs/outputs of the simple-amplifier.

So far so good, when no audio is playing the audio amp is disabled
(GPIO is low), and it gets enabled as soon as I start to play audio.

What is not working, and what I am trying to achieve, is to have the
external audio amplifier disabled as soon as headphones are plugged.

Is that something the core handles for me?
Any suggestions to make it work?

Thanks,
-Paul
