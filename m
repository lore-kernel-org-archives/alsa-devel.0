From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH RFC] ARM: dts: bcm283x: Fix probing of
	bcm2835-i2s
Date: Tue, 21 Nov 2017 21:28:04 +0100 (CET)
Message-ID: <1845541920.312172.1511296084835@email.1und1.de>
References: <1511110827-2726-1-git-send-email-stefan.wahren@i2se.com>
 <20171120131815.2oaa7mvksi2h5bip@camel2.lan>
 <1656114989.298026.1511209469286@email.1und1.de>
 <20171121195851.x5vv3qrlfx2t2xb2@camel2.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 54AF9266F52
 for <alsa-devel@alsa-project.org>; Tue, 21 Nov 2017 21:28:13 +0100 (CET)
In-Reply-To: <20171121195851.x5vv3qrlfx2t2xb2@camel2.lan>
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
Cc: Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, Florian Fainelli <f.fainelli@gmail.com>, Mark Brown <broonie@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, linux-rpi-kernel@lists.infradead.org, kernel@martin.sperl.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Hias,

> Matthias Reichl <hias@horus.com> hat am 21. November 2017 um 20:58 geschrieben:
> 
> 
> Hi Stefan,
> 
> On Mon, Nov 20, 2017 at 09:24:29PM +0100, Stefan Wahren wrote:
> > > Matthias Reichl <hias@horus.com> hat am 20. November 2017 um 14:18 geschrieben:
> > > 
> > > While testing with a simple card DT overlay I noticed another
> > > issue: the i2s node is missing the #sound-dai-cells property
> > > and simple card refuses to load because of that:
> > > 
> > > [    0.956912] OF: /sound/simple-audio-card,cpu: could not get #sound-dai-cells for /soc/i2s@7e203000
> > 
> > This should be a separate patch. Could you please send a proper one after this has been applied?
> 
> Sure, will do that.

Great. Can i assume your Tested-by for my patch?
