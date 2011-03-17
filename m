From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Compressed Audio Playback/Capture through ALSA
 framework
Date: Thu, 17 Mar 2011 21:25:55 +0000
Message-ID: <20110317212555.GP31411@opensource.wolfsonmicro.com>
References: <AANLkTikomFyMpGQMgysHdj8b3i-_jjhwW+7PVK0+HZ-p@mail.gmail.com>
 <20110316180828.GC15605@opensource.wolfsonmicro.com>
 <1300328500.9428.21.camel@vkoul-udesk3>
 <4D819551.7090901@codeaurora.org>
 <20110317115413.GA31411@opensource.wolfsonmicro.com>
 <AANLkTiknu+TvXADvbt3egRcSmTjmv2+BScfWGNyCTkjr@mail.gmail.com>
 <20110317182518.GI31411@opensource.wolfsonmicro.com>
 <AANLkTik6zYxu70JFDRC-vUcWE6n=HZ1_ejsKkLdJrsEC@mail.gmail.com>
 <20110317201653.GL31411@opensource.wolfsonmicro.com>
 <4D827ADF.3020400@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D827ADF.3020400@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Patrick Lai <plai@codeaurora.org>
Cc: pl bossart <bossart.nospam@gmail.com>, "Koul, Vinod" <vinod.koul@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 17, 2011 at 02:19:27PM -0700, Patrick Lai wrote:

> My impression about UCM is that scenario rules are written based on
> statically defined elements. How does it discover run-time instantiated
> elements and know what to do about it?

It doesn't at present - it'll need to be enhanced to do so, but it's
hardly alone in this.
