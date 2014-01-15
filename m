From: Jean-Francois Moine <moinejf@free.fr>
Subject: Problems with simple-card
Date: Wed, 15 Jan 2014 19:18:31 +0100
Message-ID: <20140115191831.5965d17e@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>, broonie@kernel.org
Cc: lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Xiubo,

I did a mistake in the v1 of my 'ASoC: simple-card: simplify code': I
did not initialize the pointer to the asoc_simple_card_dai_init()
function when DT. Then, I fixed that, and the simple card does not work
for me.

=46irst, without any 'format' in the DT, I get a fmt for each CPU / COD=
EC
DAI: SND_SOC_DAIFMT_CBS_CFS is always set. Well, some code is executed
for nothing, but this is not critical.

The main problem is about sysclk: when there is no clock in the DT,
you get the clock of the CPU or CODEC DAI. In my system, two clocks
are declared in the controller CPU DAI, but there is no .set_sysclk
pointer. So, snd_soc_dai_set_sysclk() returns -EINVAL and the card is
not created.

As I don't know why you need these fmt and sysclk, may you have a
look at these problems?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
