From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/1] ASoC: TWL4030: Wait RAMP_DELAY on
	headsetl_event: POST_PMD
Date: Thu, 14 May 2009 08:27:11 +0300
Message-ID: <200905140827.11625.peter.ujfalusi@nokia.com>
References: <1242040465-10835-1-git-send-email-peter.ujfalusi@nokia.com>
	<200905131557.09731.peter.ujfalusi@nokia.com>
	<20090513130548.GB10035@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 9B8C2243D7
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 07:30:06 +0200 (CEST)
In-Reply-To: <20090513130548.GB10035@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "anuj.aggarwal@ti.com" <anuj.aggarwal@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 13 May 2009 16:05:49 ext Mark Brown wrote:
> On Wed, May 13, 2009 at 03:57:09PM +0300, Peter Ujfalusi wrote:
> > Mark: About the  power up and down sequences in the soc-dapm.c file: are
> > they written in stone, or is it possible to make some - I think - minor
> > modification to the sequences?
>
> The change you've made is to power the amplifiers down after the mixers.
> That's going to cause problems on other systems - the result is going to
> be that the amplifiers end up amplifying any noise the mixers make on
> the way down which isn't good.  There's bits of the sequence that can be
> fairly readily reordered but I'd worry about that particular change.

That is why I'm a bit nervous when I need to touch the core... It has been =

working fine for all other codes so far. =

In the twl4030 codec case, the playback involves the following chain in DAP=
M =

domain:

Headset, PreDrive, Carkit, Earpiece:
DAC -> PGA -> Mixer -> output pin.

Handsfree:
DAC -> PGA -> Mux -> output pin.


While for example the WM9713 has it in this way:
DAC -> Mixer -> PGA -> output pin


While I was looking at the sequences, I wonder why the mux and mixer handle=
d =

in a differently?

I mean, that in power up the order is (simplified):
mux -> dac -> mixer -> pga

in power down:
pga -> mixer -> dac -> mux


Is it possible to add several SND_SOC_DAPM_PRE to the DAPM routing? For =

example to the HeadsetL, HeadsetR, HandsFreeL and HandsFreeR? How does it t=
han =

would work?
If this is possible, than I can handle the correct power up/down sequences =

required for the twl4030 codec.

-- =

P=E9ter
