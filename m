From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Mon, 06 Feb 2012 14:16:26 +0000
Message-ID: <1328537786.6799.16.camel@odin>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
	<1328531118.6799.13.camel@odin>
	<20120206132746.GH3070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog112.obsmtp.com (na3sys009aog112.obsmtp.com
	[74.125.149.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 50956103B17
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 15:16:42 +0100 (CET)
Received: by mail-we0-f182.google.com with SMTP id m13so7657658wer.27
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 06:16:28 -0800 (PST)
In-Reply-To: <20120206132746.GH3070@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-02-06 at 13:27 +0000, Mark Brown wrote:
> On Mon, Feb 06, 2012 at 12:25:18PM +0000, Liam Girdwood wrote:
> 
> > sound/soc/mid-x86/mfld_machine.c:238:	ret_val = snd_soc_add_codec_controls(codec, mfld_snd_controls,
> 
> This looks bogus - looks like the missing fanout mux support which we
> should really fix properly.

Vinod, fyi - something for your todo list ;-) 

> > sound/soc/omap/ams-delta.c:575:	ret = snd_soc_add_codec_controls(codec, ams_delta_audio_controls,
> 
> This one is more fun and probably reasonable for now, though it is about
> the only example of a properly working baseband in mainline.

Liam
