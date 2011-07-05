From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: Add machine driver for i.MX SGTL500
 based boards
Date: Tue, 5 Jul 2011 16:25:38 -0700
Message-ID: <20110705232537.GA9452@opensource.wolfsonmicro.com>
References: <1309804915-27544-1-git-send-email-fabio.estevam@freescale.com>
	<20110704192322.GB32624@opensource.wolfsonmicro.com>
	<CAOMZO5Cxsg5Z=PkWwkowEG=e_D5G=zM+ZHEDQ8NHYQCSsHv9vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 555BC10385E
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jul 2011 01:25:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5Cxsg5Z=PkWwkowEG=e_D5G=zM+ZHEDQ8NHYQCSsHv9vw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lrg@ti.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 05, 2011 at 06:56:45PM -0300, Fabio Estevam wrote:

> ,but aplay is failing:

> root@freescale /home$ aplay tone.wav
> Playing WAVE 'tone.wav' : Signed 16 bit Little Endian, Rate 44
> 100 Hz, Stereo
> asoc: platform imx-pcm-audio.0 hw params failed
> aplay: set_params:959: Unable to install hw params:

So the error message says that imx-pcm-audio.0 hw_params() doesn't
support the format you're trying to play.  You should check the code to
see why it's returning an error.
