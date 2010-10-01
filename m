From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Fri, 1 Oct 2010 13:38:58 +0800
Message-ID: <AANLkTimDFiwAQrw-Fb7JXtnv3SkQ-ruLqvuZgRfezbMm@mail.gmail.com>
References: <s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org> <4CA46E98.10402@ladisch.de>
	<4CA4A844.7060403@colin.guthr.ie>
	<20100930164753.GB9431@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C2FE61039BC
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 07:38:59 +0200 (CEST)
Received: by bwz13 with SMTP id 13so2160713bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 22:38:59 -0700 (PDT)
In-Reply-To: <20100930164753.GB9431@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/1 Mark Brown <broonie@opensource.wolfsonmicro.com>

> On Thu, Sep 30, 2010 at 04:09:56PM +0100, Colin Guthrie wrote:
>
> > *shouldn't* use them, but at present it does and they *are* active and
> > used, so it's not an issue for me), the problem is rather one of setting
> > Master (not PCM) to 0% aka -46.5dB causes some kind of auto-mute that
> > cuts off all sound. It shouldn't do that. I've not muted it. I've set it
>
> Is this perhaps just an error in the TLV information - should it be
> flagging that the minimim gain is mute but isn't?
>


For hda codec , the amplifiers can be found at [Audio Output], [Audio Mixer]
and [Pin complex]

Also the codec specification define which step is 0dB  , number of step and
dB for each step

Some codec can even be connected to a hardware volume knob

It also explicitly define a mute switch, so I don't think there is reason to
assume the minimum dB value is equal to mute ( -infinite dB )

In this case, the driver seem need to make some adjustment when there is no
volume knob connected , you may need to find another user with the same
codec connected to a volume knob or peform some calibration to find out how
to make the adjustment
