From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] ASoC: pandora: switch clock back to internal on stop
Date: Mon, 20 Feb 2012 12:50:26 +0200
Message-ID: <CANOLnOPdDHimsiKFBVvDJcoaE2y9be=vzZj8hTQvbL2sOhgOgA@mail.gmail.com>
References: <1329604795-24509-1-git-send-email-notasas@gmail.com>
	<20120219063005.GA4517@opensource.wolfsonmicro.com>
	<CANOLnOO=UMKJ1CKXKzP5LC_rttxWYRo2yMe9M7PtSL7eV1+GxA@mail.gmail.com>
	<4F4217EC.7080806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <4F4217EC.7080806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 20, 2012 at 11:52 AM, Peter Ujfalusi <peter.ujfalusi@ti.com=
> wrote:
> On 02/19/2012 05:52 PM, Grazvydas Ignotas wrote:
>>> Might be an idea to do this in the McBSP driver - have it do the sw=
itch
>>> transparently, then flip back when the port is brought up again?
>>
>> Maybe, but I think pandora is the only one using external clock in
>> mainline
>
> I have patch on top of the mcbsp merge series which allows users
> (developers) to switch between McBSP2 master/slave configuration on
> Beagle. It will have two PCM:
> 0 is the current configuration (twl4030 master, mcbsp2 slave)
> 1 is the same as with pandora (twl4030 slave, mcbsp2 master - CLKS pi=
n
> is the source for the SRG).
> With this I can help to track down the suspend issue you see on Pando=
ra.
> I hope.

Sounds good, I can wait for this I guess.

Slightly off-topic: would you mind getting OSS emulation working on
OMAP? We talked about it some years back.. I'm still carrying this
hack in pandora tree:
http://git.openpandora.org/cgi-bin/gitweb.cgi?p=3Dpandora-kernel.git;a=3D=
commitdiff;h=3D7717278f6e

We have found in-kernel OSS emulation to have best compatibility and
performance, and the later is important for a games machine with an
aging SoC..

The other issue with pandora on mainline is frequent buffer underflows
just after the stream starts. Games tend to use tiny buffers with a
goal to have low audio latency, and this often ends up with endless
loop of stream start and underflow events. We used this hack on
earlier kernels (the comment is probably not entirely correct, and
fifo_samples should be multiplied by channels I guess):
http://git.openpandora.org/cgi-bin/gitweb.cgi?p=3Dpandora-kernel.git;a=3D=
commitdiff;h=3Dd3ef3adfa

This can of course be fixed in a program itself, but the idea was to
reduce effort needed to port things to pandora, and now I'll have to
be carrying this for compatibility, but I wonder how that looks from
mainline point of view.


--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
