From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: core: Add support for DAI driver DAI
	widgets.
Date: Thu, 08 Mar 2012 12:07:00 +0000
Message-ID: <1331208420.3782.17.camel@odin>
References: <1331120862-16161-1-git-send-email-lrg@ti.com>
	<1331120862-16161-2-git-send-email-lrg@ti.com>
	<20120307203722.GL3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog119.obsmtp.com (na3sys009aog119.obsmtp.com
	[74.125.149.246])
	by alsa0.perex.cz (Postfix) with ESMTP id 8080C10BA5E
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 13:07:04 +0100 (CET)
Received: by mail-we0-f176.google.com with SMTP id c1so322233wer.7
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 04:07:02 -0800 (PST)
In-Reply-To: <20120307203722.GL3107@opensource.wolfsonmicro.com>
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

On Wed, 2012-03-07 at 20:37 +0000, Mark Brown wrote:
> On Wed, Mar 07, 2012 at 11:47:42AM +0000, Liam Girdwood wrote:
> 
> > Automatically create DAI widgets for DAI drivers. This allows us to connect
> > CPU DAIs into the DAPM graph. The widgets use the DAI driver dev name with
> > a "Playback" or "Capture" suffix.
> 
> So what this is doing is the above which is really about synthesising a
> name for streams where the driver didn't provide one.  This isn't
> specific to CPU DAIs, it'll apply just as well to CODEC DAIs that don't
> specify a per stream name for whatever reason.  

yes, but it's more about creating a DAPM DAI widget for DAIs that are
not named by their drivers. 

> 
> > Also add a snd_soc_dai member to snd_soc_widget so that we dont have to
> > use the widget private data.
> 
> If we're going to do that I think we should just drop the private data
> field, this is exactly the sort of stuff it was added for.  Currently
> it's only used by DAIs and regulator supplies.
> 

ok, we could add a regulator * in place of the void * in a separate
patch

> > +#define NAME_SIZE	32
> 
> 32 bytes is enough for everyone!  :P  Actually it should be so no real
> problem.
> 
> >  	if (dai->driver->playback.stream_name) {
> > -		template.id = snd_soc_dapm_dai;
> >  		template.name = dai->driver->playback.stream_name;
> >  		template.sname = dai->driver->playback.stream_name;
> > +	} else {
> > +		snprintf(name, NAME_SIZE, "%s %s", dev_name(dai->dev), "Playback");
> > +		template.name = name;
> > +		template.sname = name;
> > +	}
> 
> Isn't this going to get complicated to use when building up the DAPM
> routes?  The device is going to need to know its own dev_name() to
> supply a table of routes which would mean you'd have to dynamically
> create the routing table (or just specify a name and skip the whole
> thing I guess).  

I'm not needing to dynamically create the table, it all works as
before :-

	/* Connections between twl6040 and ABE */
	{"Headset Playback", NULL, "PDM_DL1"},
	{"Handsfree Playback", NULL, "PDM_DL2"},
	{"Vibra Playback", NULL, "PDM_VIB"},
	{"PDM_UL1", NULL, "PDM Capture"},

	/* Bluetooth <--> ABE*/
	{"omap-mcbsp-dai.0 Playback", NULL, "BT_VX_DL"},
	{"BT_VX_UL", NULL, "omap-mcbsp-dai.0 Capture"},

This is the machine driver DAPM table. Here we are connecting the DAI
widgets for twl6040 (using existing DAI widget codec code) to the ABE
and the ABE to the Bluetooth device (using this patch).

This does give us DAPM loopback support for codec<->codec as we will get
a widget event for this DAI link.

> 
> Could we not just use plain old "Playback" and "Capture" here?  We could
> then use the name_prefix mechanism which we've got to support multiple
> CODECs with the CPU side stuff as well, that will then take care of the
> DAPM routes in the same way it does for the CODECs - it'd allow them to
> use simple data tables with no dev_name in them which seems like a win.
> We'd want to supply a default name_prefix for CPU DAIs but that seems
> OK.

The intention here was for CPU DAIs only, the assumption was that the
codecs would have a DAPM mapping to DAI or DAC/ADC by default. I can
certainly change this to ignore the codec DAIs and leave them as is ?

> 
> This would also ensure that this mechanism works for multi-CODEC systems
> which I've got a horrible feeling are going to run into trouble at some
> point soon for the same reason you're adding in the dev_names here.


Liam
