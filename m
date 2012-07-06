From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Fix locking during codec
	shutdown
Date: Fri, 06 Jul 2012 17:36:15 +0100
Message-ID: <1341592575.4963.7.camel@odin>
References: <1341590225-20837-1-git-send-email-lrg@ti.com>
	<20120706160220.GG4017@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 168ED104575
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 18:36:22 +0200 (CEST)
Received: by wgbdr1 with SMTP id dr1so7384425wgb.12
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2012 09:36:18 -0700 (PDT)
In-Reply-To: <20120706160220.GG4017@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-07-06 at 17:02 +0100, Mark Brown wrote:
> On Fri, Jul 06, 2012 at 04:57:05PM +0100, Liam Girdwood wrote:
> > Codec shutdown performs a DAPM power sequence that might cause conflicts
> > and/or race conditions if another stream power event is running simultaneously.
> > Use card's dapm mutex to protect any potential race condition between them.
> 
> There's a bigger problem here if we're managing to run into this - the
> shutdown function is only supposed to be being called while the system
> is in the middle of shutting down so we've probably got a bunch of other
> races further up the stack to worry about too...

I don't think there is anything explicitly stopping a power off from
happening during a stream shutdown atm without this patch. It was
reported to me that this would fail 1 in 20 times on a certain device
and that the above patch fixed the issue (1200 tests completed OK after
the patch).

I do think we need this patch atm since we are accessing the same
resources as the stream event.

Liam
