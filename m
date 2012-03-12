From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH 1/2] ASoC: dmaengine_pcm: Reset pointer
 position when starting a stream
Date: Mon, 12 Mar 2012 20:57:16 +0200
Message-ID: <20120312185716.GB4596@mwesterb-mobl.ger.corp.intel.com>
References: <1330952535-30614-1-git-send-email-lars@metafoo.de>
	<20120305130917.GL3224@opensource.wolfsonmicro.com>
	<4F588971.4010302@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
	[209.85.217.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EA838243A0
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 19:58:12 +0100 (CET)
Received: by lbbgn12 with SMTP id gn12so1189139lbb.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 11:58:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F588971.4010302@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 08, 2012 at 11:26:57AM +0100, Lars-Peter Clausen wrote:
> On 03/05/2012 02:09 PM, Mark Brown wrote:
> > On Mon, Mar 05, 2012 at 02:02:14PM +0100, Lars-Peter Clausen wrote:
> >> From: Mika Westerberg <mika.westerberg@iki.fi>
> >>
> >> Otherwise a wrong position will be reported after restarting a stream and the
> >> first few samples might be skipped.
> >>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > 
> > I can't apply this without a signoff from Mika.
> 
> Mika, can we get your sign off for this patch?

Sorry for the delay, I've been travelling. Here it is

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
