From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC_i/iv 1/3] ASoC: Decouple DAPM from CODECs.
 Part core (will be squashed)
Date: Sun, 31 Oct 2010 20:13:16 +0200
Message-ID: <20101031201316.3d46d472.jhnikula@gmail.com>
References: <1288353618-21753-1-git-send-email-jhnikula@gmail.com>
	<1288353618-21753-2-git-send-email-jhnikula@gmail.com>
	<20101029200428.GD3921@opensource.wolfsonmicro.com>
	<1288461714.3286.143.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 00CD110387E
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 19:11:53 +0100 (CET)
Received: by ewy22 with SMTP id 22so2430527ewy.38
	for <alsa-devel@alsa-project.org>; Sun, 31 Oct 2010 11:11:53 -0700 (PDT)
In-Reply-To: <1288461714.3286.143.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 30 Oct 2010 19:01:54 +0100
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> On Fri, 2010-10-29 at 13:04 -0700, Mark Brown wrote:
> > On Fri, Oct 29, 2010 at 03:00:16PM +0300, Jarkko Nikula wrote:
> > 
> > >  	codec->debugfs_pop_time = debugfs_create_u32("dapm_pop_time", 0644,
> > >  						     codec->debugfs_codec_root,
> > > -						     &codec->pop_time);
> > > +						     &codec->dapm->pop_time);
> > 
> > The pop time feels like it should have an effect over the full card
> > rather than over individual CODECs - the power sequencing is obviously
> > going to be done over the entire card rather than individual devices so
> > it's a little unclear how competing values for different devices would
> > be applied.  This is a simple code motion patch and this is only debugfs
> > but perhaps it's worth first doing this as a split which moves the pop
> > time onto the card.
> > 
True. Looks like worth to add a patch doing pop decoupling in this set.

> Ah, I think we may be missing a later patch here that did add a DAPM
> context to card and platform.
> 
Yeah, I simplified a bit Liam's code and not added DAPM to other than
codecs since there is no yet use for it in these series.

> > >  	/* If we're changing to all on or all off then prepare */
> > > -	if ((sys_power && codec->bias_level == SND_SOC_BIAS_STANDBY) ||
> > > -	    (!sys_power && codec->bias_level == SND_SOC_BIAS_ON)) {
> > > -		ret = snd_soc_dapm_set_bias_level(card, codec, SND_SOC_BIAS_PREPARE);
> > > +	if ((sys_power && dapm->bias_level == SND_SOC_BIAS_STANDBY) ||
> > > +	    (!sys_power && dapm->bias_level == SND_SOC_BIAS_ON)) {
> > > +		ret = snd_soc_dapm_set_bias_level(card, dapm, SND_SOC_BIAS_PREPARE);
> > 
> > So, this is all going to be run per DAPM object from the looks of
> > things.  That's really not what we want - we want to be doing the
> > sequencing over all DAPM objects in the card, rather than per DAPM
> > object.  It'll need to be fixed at some point later in the series...
> 
Reason is that here is no need to touch other DAPM contexts until
RFC_ii/iv 3/3 since DAPM decoupling doesn't change yet how things work
currently.


-- 
Jarkko
