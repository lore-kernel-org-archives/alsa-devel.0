From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Question about your DSP topic
Date: Thu, 31 Mar 2011 19:26:17 +0100
Message-ID: <1301595977.3549.7.camel@odin>
References: <4D2652C8.7030701@codeaurora.org> <4D939519.6040506@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id DB4A91037F8
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 20:26:22 +0200 (CEST)
Received: by wwi18 with SMTP id 18so5440800wwi.2
	for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2011 11:26:21 -0700 (PDT)
In-Reply-To: <4D939519.6040506@codeaurora.org>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-30 at 13:39 -0700, Patrick Lai wrote:
> Hi Liam/Mark,
> 
> I ran some tests on top of soc-dsp framework pulled from Liam's
> topic/dsp-upstream(http://git.kernel.org/?p=linux/kernel/git/lrg/asoc-
> 2.6.git;a=summary). I found there is a scenario that soc-dsp framework
> erroneously start pcm playabck/capture. Here is the scenario:
> 
> In the platform driver, I have this route table defined
> 
> FE1 Playback -> Mixer 1 -> BE1
> BE2 -> FE1 Capture
> FE = Front-end, BE = Back-end
> 
> While PCM playback is going from FE1 playback to BE1, I switch off FE1
> playback to Mixer 1. This caused soc_dsp_runtime_update called.
> Framework correctly close BE1 as it is no longer needed. Eventually,
> framework finds BE2 is connected to FE1 capture. Framework, without
> checking if FE1 capture is activated by user-space application, simply
> goes ahead activate BE2. Since FE1 capture is never activated,
> runtime structure is not allocated. This inherently results NULL
> pointer dereference exception.
> 
> For now, in soc-dsp.c be_connect function(), I have a check to make sure
> fe->dsp[stream].runtime is not NULL. I don't know if it's appropriate
> fix. Can you please take a look?

I've not seen that one yet and we have a similar route on OMAP4. Is it
repeatable 100% or just some of the time. It would also be useful to
post your oops message and I'll take a closer look.

I'm due to push an squashed update to my dsp branch later tonight in
prep for upstream. Could you also check soc-dsp.c against this copy,  it
may be that something that was lost in the backport ?

Liam
