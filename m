From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 6/8] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Wed, 22 Feb 2012 18:05:54 +0530
Message-ID: <1329914154.24656.95.camel@vkoul-udesk3>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329468009.24656.15.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 78128103A30
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 13:34:31 +0100 (CET)
In-Reply-To: <1329468009.24656.15.camel@vkoul-udesk3>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-02-17 at 14:10 +0530, Vinod Koul wrote:
> On Thu, 2012-02-16 at 21:56 -0800, Mark Brown wrote:
> > In order to allow us to do smarter things with DAI links create DAPM
> > widgets which directly represent the DAIs in the DAPM graph. These are
> > automatically created from the DAIs as we probe the card with references
> > held in both directions between the widget and the DAI.
> > 
> > The widgets are not made available for direct instantiation by drivers,
> > they are created automatically from the DAIs.  Drivers should be updated
> > to create stream routes using DAPM maps rather than by annotating AIF
> > and DAC widgets with streams.
> > 
> > In order to ease transition to this model from existing drivers we
> > automatically create DAPM routes between the DAI widgets and the existing
> > stream widgets which are started and stopped by the DAI widgets, though
> > the old stream handling mechanism is still in place.  This also has the
> > nice effect of removing non-DAPM devices as any device with a DAI
> > acquires a widget automatically which will allow future simplifications
> > to the core DAPM logic.
> > 
> > The intention is that in future the AIF and DAI widgets will gain the
> > ability to interact such that we are able to manage activity on
> > individual channels independantly rather than powering up and down the
> > entire AIF as we do currently.
> > 
> > Currently we only generate these for CODECs, mostly as I have no systems
> > with non-CODEC DAPM to integrate with. It should be a simple matter of
> > programming to add the additional hookup for these.
> If I understood right, then instead of creating AIF/ADCs for codec paths
> now we need to create the DAI widget for each path and associate that
> with the DAI, right.
> I think I understood former (creating the dai widgets), but how does it
> get linked to the DAIs?
Ping...



-- 
~Vinod
