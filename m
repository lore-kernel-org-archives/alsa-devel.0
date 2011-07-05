From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC] ASoC: Add machine driver for i.MX SGTL500
 based boards
Date: Tue, 5 Jul 2011 18:56:45 -0300
Message-ID: <CAOMZO5Cxsg5Z=PkWwkowEG=e_D5G=zM+ZHEDQ8NHYQCSsHv9vw@mail.gmail.com>
References: <1309804915-27544-1-git-send-email-fabio.estevam@freescale.com>
	<20110704192322.GB32624@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E806103933
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 23:56:46 +0200 (CEST)
Received: by pvg18 with SMTP id 18so7558404pvg.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 14:56:45 -0700 (PDT)
In-Reply-To: <20110704192322.GB32624@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lrg@ti.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Mon, Jul 4, 2011 at 4:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jul 04, 2011 at 03:41:55PM -0300, Fabio Estevam wrote:
>
>> sgtl5000 1-000a: sgtl5000 revision 17
>> sgtl5000 1-000a: asoc: failed to probe CODEC sgtl5000.1-000a: -22
>> asoc: failed to instantiate card sgtl5000: -22
>
> Have you looked to see where the error is coming from?

Yes, now I see that the error comes from the sgtl5000 driver and it
is related to the regulator. Will submit a patch for this later after
I get audio to work.

Now the codec is registered properly:
asoc: sgtl5000 <-> imx-ssi.0 mapping ok

,but aplay is failing:

root@freescale /home$ aplay tone.wav
Playing WAVE 'tone.wav' : Signed 16 bit Little Endian, Rate 44
100 Hz, Stereo
asoc: platform imx-pcm-audio.0 hw params failed
aplay: set_params:959: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (92879 92880)
PERIOD_SIZE: 4096
PERIOD_BYTES: 16384
PERIODS: 4
BUFFER_TIME: (371519 371520)
BUFFER_SIZE: 16384
BUFFER_BYTES: 65536
TICK_TIME: 0

I am starting to debug this now, but if you have any suggestions,
please let me know.

Thanks,

Fabio Estevam
