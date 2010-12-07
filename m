From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: dapm: Add speaker driver widget.
Date: Tue, 07 Dec 2010 14:01:24 +0000
Message-ID: <1291730484.3275.54.camel@odin>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E7E@dlee06.ent.ti.com>
	<20101206224359.GB2862@opensource.wolfsonmicro.com>
	<1291676132.3281.116.camel@odin>
	<20101206230948.GH2862@opensource.wolfsonmicro.com>
	<1291678207.3281.152.camel@odin>
	<8C6859A9-36EF-4016-822B-DA67D7147E28@opensource.wolfsonmicro.com>
	<1291725285.3275.14.camel@odin>
	<20101207123600.GD4698@rakim.wolfsonmicro.main>
	<1291725988.3275.22.camel@odin>
	<20101207130914.GF4698@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42])
	by alsa0.perex.cz (Postfix) with ESMTP id BA11F103A72
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 15:01:27 +0100 (CET)
Received: by ewy1 with SMTP id 1so7490691ewy.29
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 06:01:27 -0800 (PST)
In-Reply-To: <20101207130914.GF4698@rakim.wolfsonmicro.main>
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
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-07 at 13:09 +0000, Mark Brown wrote:
> On Tue, Dec 07, 2010 at 12:46:28PM +0000, Liam Girdwood wrote:
> 
> > Ok, but by sharing the number we take away some flexibility in the
> > sequence ordering. Say something has to be done in the machine driver
> > _after_ the spk/haptic/vibra driver is enabled in the CODEC driver ?
> 
> You can say that for pretty much all of the widgets, though, including
> the existing speaker and headphone widgets.  

You can only really say for the last widget in the sequence.

> I'd be a bit surprised if
> you had anything afterwards in this case, a driver is generally the high
> power stage wired directly to the transducer.
> 
> > I dont actually see any major issue of using a new number here unless
> > you have it reserved for something else ?
> 
> Adding a new number and renumbering all the subsequent ones wouldn't be
> so bad, the patch wasn't doing that.

@@ -61,6 +61,7 @@ static int dapm_up_seq[] = {
        [snd_soc_dapm_mixer] = 7,
        [snd_soc_dapm_mixer_named_ctl] = 7,
        [snd_soc_dapm_pga] = 8,
+       [snd_soc_dapm_drv] = 9,
        [snd_soc_dapm_adc] = 9,
        [snd_soc_dapm_hp] = 10,
        [snd_soc_dapm_spk] = 10,

This patch shares the ADC sequence number for the DRV on the power ON.

@@ -72,6 +73,7 @@ static int dapm_down_seq[] = {
        [snd_soc_dapm_adc] = 1,
        [snd_soc_dapm_hp] = 2,
        [snd_soc_dapm_spk] = 2,
+       [snd_soc_dapm_drv] = 3,
        [snd_soc_dapm_pga] = 4,
        [snd_soc_dapm_mixer_named_ctl] = 5,
        [snd_soc_dapm_mixer] = 5,

and inserts a new number as you suggested for power OFF. Imo, nothing
wrong with this approach and since I don't have all day to discuss, Magi
will change both the sequence numbers to use the same number as
snd_soc_dapm_spk.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
