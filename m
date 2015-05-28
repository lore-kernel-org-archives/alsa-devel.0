From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add topology core
Date: Thu, 28 May 2015 15:45:09 +0100
Message-ID: <1432824309.2726.44.camel@loki>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1432574570-7436-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150527190021.GO21577@sirena.org.uk> <55661997.2050800@metafoo.de>
 <20150527194827.GP21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 64CD22604BE
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2015 16:45:14 +0200 (CEST)
In-Reply-To: <20150527194827.GP21577@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-05-27 at 20:48 +0100, Mark Brown wrote:
> On Wed, May 27, 2015 at 09:23:03PM +0200, Lars-Peter Clausen wrote:
> 
> > Ideally we'd turn the dependency chain the other way around and have a
> > snd_soc_dobj_widget struct which inherits snd_soc_dapm_widget and
> > snd_soc_dobj. In the dobj callbacks you can then still use container_of to
> > get it. This comes at the expense that we have to add a free() callback to
> > snd_soc_dapm_widget. But it opens up the possibility to have other
> > specialized widgets sub-classes. snd_soc_dapm_widget is already rather large
> > given how many instance we have of it and quite a few of the fields are only
> > used by a particular type of widget. Another good candidate for example
> > would be the DAI link widget with all its params fields.
> 
> Yeah, I was thinking something along those lines might be good long term
> but it's definitely a separate thing to getting the topology stuff in
> and I started worrying about things like multiple inheritance.

Yeah this would also help in reducing memory footprint. Probably a topic
for the audio mini conf ?

Liam
