From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: init delayed_work for codec-codec links
Date: Thu, 1 Aug 2013 16:50:56 +0100
Message-ID: <20130801155056.GA3996@opensource.wolfsonmicro.com>
References: <20130731131627.GA32631@opensource.wolfsonmicro.com> <20130731132522.GP9858@sirena.org.uk> <20130801151336.GA1112@opensource.wolfsonmicro.com> <20130801152356.GW9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130801152356.GW9858@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 01, 2013 at 04:23:56PM +0100, Mark Brown wrote:
> On Thu, Aug 01, 2013 at 04:13:52PM +0100, Richard Fitzgerald wrote:
> > On Wed, Jul 31, 2013 at 02:25:22PM +0100, Mark Brown wrote:
> 
> > > Why is this better than pointing at the normal work that you'd expect to
> > > be used there?
> 
> > By 'normal work' do you mean the close_delayed_work() used for
> > standard PCM DAIs?
> 
> Yes - making up this empty work doesn't seem like a robust approach.

Yeah, I think the problem is more one of bad naming. I should define that
function as the delayed work for codec-2-codec links, it just happens
that we don't currently have to do anything for them. The only thing
the pcm close_delayed_work() does is to send a SND_SOC_DAPM_STREAM_STOP
but for c2c links we never send a start anyway.
