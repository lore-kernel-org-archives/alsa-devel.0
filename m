From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core - Add support for DAI and
	machine kcontrols.
Date: Mon, 06 Feb 2012 12:25:18 +0000
Message-ID: <1328531118.6799.13.camel@odin>
References: <1328290989-14399-1-git-send-email-lrg@ti.com>
	<20120203204640.GD23505@opensource.wolfsonmicro.com>
	<1328524623.6799.9.camel@odin>
	<20120206110939.GC3070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 01B6B103AB0
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 13:25:35 +0100 (CET)
Received: by mail-we0-f169.google.com with SMTP id a13so5681935wer.14
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 04:25:22 -0800 (PST)
In-Reply-To: <20120206110939.GC3070@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-02-06 at 11:09 +0000, Mark Brown wrote:
> On Mon, Feb 06, 2012 at 10:37:03AM +0000, Liam Girdwood wrote:
> > On Fri, 2012-02-03 at 20:46 +0000, Mark Brown wrote:
> 
> > > to hand but what are the cases where there is CODEC control?  This
> > > sounds suspicous, perhaps we need some of the drivers enhancing (though
> > > no reason to block this patch).
> 
> > The other machine drivers were all using the codec pointer to do extra
> > codec configuration with their kcontrol code so there was no update for
> > them.
> 
> Which ones were those?  That sounds very suspicous...

Some register writes in mfld and a struct snd_soc_codec member check in
ams_delta. 

sound/soc/mid-x86/mfld_machine.c:238:	ret_val = snd_soc_add_codec_controls(codec, mfld_snd_controls,
sound/soc/omap/ams-delta.c:575:	ret = snd_soc_add_codec_controls(codec, ams_delta_audio_controls,

Liam
