From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: wm8741: Remove unneeded startup()
 callback
Date: Tue, 31 Jan 2017 09:49:31 +0000
Message-ID: <20170131094931.GG1754@localhost.localdomain>
References: <1485560145-12908-1-git-send-email-ce3a@gmx.de>
 <20170130092259.GE1754@localhost.localdomain>
 <1c9d48c3-770b-3048-23d2-afc22f221077@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id CCCFB265A82
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 10:48:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1c9d48c3-770b-3048-23d2-afc22f221077@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 30, 2017 at 11:56:52PM +0100, Sergej Sawazki wrote:
> On Mon, 30 Jan 2017 09:22:59 +0000, Charles Keepax wrote:
> > On Sat, Jan 28, 2017 at 12:35:45AM +0100, Sergej Sawazki wrote:
> >> Do not apply rate constraints in the startup() callback. The machine driver
> >> can change the sysclk and hence the supported frame rates in its hw_params().
> >> This callback is unneeded since commit e369bd006fd6 ("ASoC: wm8741: Allow
> >> master clock switching").
> 
> > This function should not be removed it is performing a useful
> > function. If a sysclk has already been configured by the machine
> > driver then we should inform user-space of the rates we can
> > support from that clock. Without this that information is not
> > available to user-space, so instead of user-space being able to
> > resample appropriately it would just error out from hw_params.
> > 
> > Are you perhaps missing a call to clear the sysclk from your
> > machine driver? Usually a dai_set_sysclk call with a rate of
> > zero, also I find if it is a machine driver supporting multiple
> > rates you are best to use ignore_pmdown_time on the DAI link,
> > assuming the devices don't have long bring up times.
> 
> After clearing the sysclk, the codec should 'pretend' to support all
> rates, right? (no sysclk -> no rate constrains)
> 

Indeed yes, so a normal pattern would often be setting a sysclk
rate in set_bias_level(on the way up)/hw_params and clearing it in
set_bias_level(on the way down). That way whilst the device is
powered up it is fixed at a certain rate so as not to disrupt any
running audio but whilst powered down you are free to start it up
at any rate.

> After applying rate constraints using snd_pcm_hw_constraint_list(...),
> what would be a clean way to remove the constraints from the rates
> parameter?
> 

I am not sure I fully follow here, normally one would close the
stream and open a new one at the new rate. Hence no need to clear
the constraits as its a new stream. Are you intending to keep the
stream open but reconfigure it for new rates?

Thanks,
Charles
