From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH] ASoC: rt286: add irq enable/disable APIs
	and export
Date: Wed, 4 Feb 2015 13:12:25 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BA9A58@SHSMSX101.ccr.corp.intel.com>
References: <1423053895-24342-1-git-send-email-yang.jie@intel.com>
 <20150204125856.GZ21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E5D6C260448
 for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2015 14:12:31 +0100 (CET)
In-Reply-To: <20150204125856.GZ21293@sirena.org.uk>
Content-Language: en-US
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
Cc: "bardliao@realtek.com" <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, February 04, 2015 8:59 PM
> To: Jie, Yang
> Cc: alsa-devel@alsa-project.org; bardliao@realtek.com; Girdwood, Liam R
> Subject: Re: [PATCH] ASoC: rt286: add irq enable/disable APIs and export
> 
> On Wed, Feb 04, 2015 at 08:44:55PM +0800, Jie Yang wrote:
> > Some platforms, e.g. WSB, don't need irq handler and jack detection
> > when system is in Suspend, for power save reason.
> >
> > Here add irq enable/disable APIs and export them, also disable LDO1,
> > which is used for jack detection when headphone is plugged in.
> 
> > +int rt286_enable_irq(struct snd_soc_codec *codec) {
> 
> This isn't a great idiom for the API - the machine driver isn't working with the
> interrupt, it's working with the jack detection so it should do the disable and
> reenable in terms of the jack detection too.  Otherwise it's not clear that this
> won't interfere with other interrupt functions the device has and that it'll
> disable the jack detection hardware in the device rather than just ignoring the
> interrupt (which is presumably desired and appears to be actually happening in
> the code).
[Keyon] thanks for review, Mark, do you mean we should change the function names to rt286_enable/disable_jack_detection()?
