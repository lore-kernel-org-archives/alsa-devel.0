From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Thu, 19 Aug 2010 18:20:49 +0300
Message-ID: <20100819182049.3ecdd0bc.jhnikula@gmail.com>
References: <1281943770-2990-1-git-send-email-jhnikula@gmail.com>
	<20100816100705.GA3276@rakim.wolfsonmicro.main>
	<20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 285492444E
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 17:20:32 +0200 (CEST)
Received: by ewy21 with SMTP id 21so1315276ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 08:20:31 -0700 (PDT)
In-Reply-To: <20100819135413.GA19582@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Aug 2010 14:54:14 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Aug 19, 2010 at 02:44:51PM +0300, Jarkko Nikula wrote:
> 
> > kcontrol or name prefix still comes from dai_link->kcontrol_prefix
> > (where it should be per codec as pointer by Mark). And no drivers are
> > patched for snd_soc_add_controls, snd_soc_dapm_new_control,
> > snd_soc_dapm_new_controls and snd_soc_dapm_add_routes API changes.
> 
> It seems inelegant to have to bounce the prefix information through the
> CODEC driver - we're already supplying the CODEC when we register the
> controls so it seems like the core ought to be able to work out which
> controls need to be renamed from the machine description without needing
> this.
> 
Yeah, I agree. It would be best if there is no need to change API of
those functions but I haven't figured out yet how those functions
can see should they add prefix or not and what prefix.

So what we do in soc_probe_dai_link:

	cpu_dai->driver->probe
	codec->driver->probe
	-> Codec adds controls, widgets and routes (only controls
	are prefixed. E.g. "front.")
	platform->driver->probe
	codec_dai->driver->probe
	dai_link->init
	-> Machine adds controls, widgets and routes (no prefixes)
	-> Machine registers stuff from extra drivers (all
	controls, widgets and routes are prefixed per driver.
	E.g. "front-left-amp.", "front-right-amp." )

Codec and machine registrations are easy to separate e.g. by some flag
and use only codec->kcontrol_prefix and continue using unmodified API.

I think extra drivers could use own variants of those registration
functions that have the name_prefix argument (and core would call them
too). Then we don't need to patch all the codec and machine drivers.
Does this sound feasible?

> It seems best to have the data come from machine-specific config so that
> we can allow them to provide something that makes things clearer to
> users on the particular board.
> 
Pointer to some codec_name<->prefix table in struct snd_soc_card at
least eliminates the dai_link->kcontrol_prefix.

> > Codec:
> > - kcontrol prefix
> > - no widget name prefix (as they are per codec)
> > - no audio map prefix (as they are per codec)
> 
> Are you sure these are per CODEC?

I thought they and audio map of machine (registered in
dai_link->init) were per codec. Read that as I haven't tried with
second map yet in the test board :-)

Do you think there are some issues e.g. with multi-dai codecs that we
need to address?


-- 
Jarkko
