From: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6] ASoC: dapm: add code to configure dai link
	parameters
Date: Tue, 14 Oct 2014 11:39:45 +0100
Message-ID: <20141014103945.GA25013@opensource.wolfsonmicro.com>
References: <1412957836-2186-1-git-send-email-nikesh@opensource.wolfsonmicro.com> <20141010164959.GG18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141010164959.GG18557@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 10, 2014 at 05:49:59PM +0100, Mark Brown wrote:
> On Fri, Oct 10, 2014 at 05:17:15PM +0100, Nikesh Oswal wrote:
> > dai-link params for codec-codec links were fixed. The fixed
> > link between codec and another chip which may be another codec,
> > baseband, bluetooth codec etc may require run time configuaration
> > changes. This change provides an optional alsa control to select
> > one of the params from a list of params.
> 
> Has anything changed since the previous version?  I've postponed
> reviewing that until after the merge window given the way you were
> ignoring feedback and the approach of the merge window, is this a new
> version or just a reposting.

>>> Since it was not merged or reviewed since long, I just did a  reposting 
of previous version of the patch
