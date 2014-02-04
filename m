From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2 v2] ASoC: arizona: Improve ultrasonic
	frequency	response
Date: Tue, 4 Feb 2014 09:17:58 +0000
Message-ID: <20140204091758.GA16684@opensource.wolfsonmicro.com>
References: <1391184978-14516-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1391184978-14516-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20140204001727.GO22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D9F726171E
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 10:17:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140204001727.GO22609@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, sameo@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 04, 2014 at 12:17:27AM +0000, Mark Brown wrote:
> On Fri, Jan 31, 2014 at 04:16:18PM +0000, Charles Keepax wrote:
> > Evaluation of the device has given some settings to improve the
> > ultrasonic frequency response. However, this may cause sub-optimal
> > performance in system designs with high output gains on the headphone
> > path (0dB or -2dB), and as the frequencies are inaudible anyway some
> > users may not desire higher frequency response at those frequencies.
> > So allow the user the option to select it if it is appopriate for
> > their system design.
> 
> Reading what you're saying here I can't help but think that this sounds
> like it may be use case dependent as well and therefore something that
> ought to be runtime controllable depending on if ultrasonics and/or line
> level outputs are in use (0dB isn't high gain, it's no gain!) for
> example.

I think in practice it will likely be set once for a given
system. Although that said there is nothing that would prevent
this being switchable at runtime, I will look into respinning it
with runtime control.

Thanks,
Charles
