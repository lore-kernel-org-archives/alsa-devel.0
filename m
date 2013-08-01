From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: init delayed_work for codec-codec links
Date: Thu, 1 Aug 2013 16:13:52 +0100
Message-ID: <20130801151336.GA1112@opensource.wolfsonmicro.com>
References: <20130731131627.GA32631@opensource.wolfsonmicro.com> <20130731132522.GP9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130731132522.GP9858@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 31, 2013 at 02:25:22PM +0100, Mark Brown wrote:
> On Wed, Jul 31, 2013 at 02:16:44PM +0100, Richard Fitzgerald wrote:
> 
> > Pointing it to a dummy work callback is cleaner than taking
> > special cases in the code to bypass the flush_delayed_work_sync().
> 
> Why is this better than pointing at the normal work that you'd expect to
> be used there?

By 'normal work' do you mean the close_delayed_work() used for
standard PCM DAIs?
