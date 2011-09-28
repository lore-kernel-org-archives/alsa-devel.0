From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: Signaling user-space through kcontrol
Date: Wed, 28 Sep 2011 12:33:32 +0530
Message-ID: <1317193412.1573.1647.camel@vkoul-udesk3>
References: <4E82BB4C.1030801@codeaurora.org>
	<1317190544.1573.1646.camel@vkoul-udesk3>
	<4E82C307.30407@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 399D724415
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 09:09:05 +0200 (CEST)
In-Reply-To: <4E82C307.30407@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-27 at 23:47 -0700, Patrick Lai wrote:
> On 9/27/2011 11:15 PM, Vinod Koul wrote:
> > On Tue, 2011-09-27 at 23:14 -0700, Patrick Lai wrote:
> >> Hi Mark,
> >>
> >> The codec I am working on, beside headset detection, also have other
> >> type of events to be propagated to user space. Per our discussion at
> >> IPC, there is way to signal user-space through kcontrol. Is it through
> >> calling snd_ctl_notify()? What is the ALSA library API to intercept the
> >> event? Is there an sample user-space code which gets kcontrol event?
> >>
> > What events do you have in mind?
> >
> Main one is detection of short circuiting headphone For this case,
> there is no need for extra payload. In case of there is need to pass
> back some payload, I presume user-space application can simply call the
> get function upon receiving notification.
And what would userspace do with that information? Apart from logging
this, is there anything useful we can do with such info

-- 
~Vinod
