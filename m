From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Fri, 26 Nov 2010 09:25:24 +0200
Message-ID: <20101126092524.ea7cf74d.jhnikula@gmail.com>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<1290712703.3302.41.camel@odin>
	<20101125213145.GB25162@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CEB1D103C9D
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 08:25:07 +0100 (CET)
Received: by ewy19 with SMTP id 19so827237ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 23:25:01 -0800 (PST)
In-Reply-To: <20101125213145.GB25162@opensource.wolfsonmicro.com>
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

On Thu, 25 Nov 2010 21:32:54 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Thu, Nov 25, 2010 at 07:18:23PM +0000, Liam Girdwood wrote:
> > On Thu, 2010-11-25 at 17:47 +0200, Jarkko Nikula wrote:
> 
> > > +	struct snd_soc_aux_dev *aux_dev;
> > > +	int num_aux_devs;
> > > +	struct snd_soc_pcm_runtime *rtd_aux;
> > > +	int num_aux_rtd;
> 
> > Could we not just make this a new component type and have a list of aux
> > devices ?
> 
> I'd certainly rather we didn't have to deal with the PCM runtime data
> since obviously the main feature of these things is that there's no PCM
> involved.  Need to review this properly to remind myself why we're doing
> this...
> 
Exactly, that was the part I didn't like myself either. Only use for
rtd here is to hold struct device for virtual device creation
under /sys/devices/platform/soc-audio and share the use of
codec_reg_show and dapm_widget_show functions.

Probably something like below can be used as a common struct device
holder and carry either rtd or dapm to sysfs functions. E.g. in
dapm_widget_show we would be accessing the dapm and rtd in
pmdown_time_show.

struct foo {
	struct device dev;
	union {
		struct snd_soc_pcm_runtime *rtd;
		struct snd_soc_dapm_context *dapm;
	} context;
};

> > Why do aux devices need to be coupled with CODECs here ? 
> 
> The way we've got things set up currently the CODEC isn't really just a
> CODEC, it's got a bunch of other random services which are more generic
> chip services associated with it like the register cache and the bias
> management.  There's so much overlap between the devices that I'm not
> sure that it's really worth splitting the types up too much at the root
> level (CODEC is pretty much a superclass that has everything on it but
> DMA).
> 
> Given how widely used snd_soc_codec is I'm not sure it's worth fixing
> the naming thing here, especially since 99% of the time the device is
> actually a CODEC.

And codecs can be used as an amplifer only by not connecting the DAI.
Like if codec chip is cheaper or better available than amplifier or if
multicodec package saves board space compared to separate codec and
amplifier chips.

If I counted correctly we have currently only three amplifier drivers:
tpa6130a2.c, wm2000.c and wm9090.c so separation doesn't sound worth of
trouble at this point as the core serves well those cases also.


-- 
Jarkko
