From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
Date: Mon, 27 Feb 2017 22:21:25 +1100
Message-ID: <7b78c782-28e1-4849-5d00-8caf30847d5c@flatmax.org>
References: <cover.1487997974.git.flatmax@flatmax.org>
 <20170225133952.GA28091@camel2.lan>
 <8cf68a3e-330d-e76d-e276-5df5453e3baf@flatmax.org>
 <20170226144958.GA5543@camel2.lan>
 <732a71ac-5ec5-37e1-1190-be036ea34555@flatmax.org>
 <20170226221648.GA10974@camel2.lan>
 <7cef41ee-ef00-22b7-830f-517a9d594ed0@flatmax.org>
 <20170227080433.GA2718@delle.lan>
 <170950f7-354f-e6a9-cefb-834a00fadd1b@flatmax.org>
 <20170227103024.GF2718@delle.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta32p.bpe.bigpond.com (nsstlmta32p.bpe.bigpond.com
 [203.38.21.32]) by alsa0.perex.cz (Postfix) with ESMTP id D4995266DEC
 for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2017 12:21:32 +0100 (CET)
In-Reply-To: <20170227103024.GF2718@delle.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, florian.kauer@koalo.de, broonie@kernel.org, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, ckeepax@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 27/02/17 21:30, Matthias Reichl wrote:
>
> I don't see that. Some people might want to be able to use multichannel
> on RPi, but that's something very different than adding code that just
> lies about driver capabilites.
>

I am going to invite you over for dinner to eat steamed vegetables :)
If I make the steamed vegetables in the microwave and they taste like 
steamed vegetables, are they steamed vegetables ?

I have a bcm2835 (Pi 2 and 3) SoC here. It is producing multichannel (8 
out, 6 in) audio. In ALSA we call that DSP mode - right ?!

If a chipset can do multichannel, do we need to invent a new DSP mode 
name to call it dsp mode ? Surely not, because steamed vegetables are 
steamed vegetables :)

Just because steamed vegetables are made in the microwave doesn't mean 
they don't belong in the Linux Kernel !

Matt
