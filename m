From: "Bharadiya,Pankaj" <pankaj.laxminarayan.bharadiya@intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_new_dai
Date: Thu, 21 Mar 2019 22:01:33 +0530
Message-ID: <20190321163132.GA18985@plaxmina-desktop.iind.intel.com>
References: <1553163085-16845-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
 <20190321123156.GB5684@sirena.org.uk>
 <13b5c552-69a6-f1e0-174c-b5aa48560858@linux.intel.com>
 <20190321140948.GD5684@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190321140948.GD5684@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 21, 2019 at 02:09:48PM +0000, Mark Brown wrote:
> On Thu, Mar 21, 2019 at 08:59:55AM -0500, Pierre-Louis Bossart wrote:
> > On 3/21/19 7:31 AM, Mark Brown wrote:
> > > On Thu, Mar 21, 2019 at 03:41:25PM +0530, Pankaj Bharadiya wrote:
> 
> > > This is very non-obvious - it's not at all clear why we'd need the text
> > > to free controls.  If there is an issue here it seems like it'd be
> > > better to make sure that snd_soc_dapm_free_kcontrol() can cope with that
> > > being NULL, that will be clearer and also avoid potential issues with
> > > other callers.
> 
> > I believe the issue is real, but you need to look at the entire code to figure it out
> 
> Yeah, I'm fairly sure there's an actual issue here - it's just that the
> fix is obscure and feels fragile.

Will fix it in snd_soc_dapm_free_kcontrol() and submit a new patch..

Thanks,
Pankaj
