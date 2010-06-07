From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC PATCH v3 0/3] ep93xx i2s audio
Date: Mon, 07 Jun 2010 13:45:32 +0100
Message-ID: <1275914732.3045.105.camel@odin>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C7A71037F5
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 14:45:37 +0200 (CEST)
Received: by wyg36 with SMTP id 36so2362517wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 05:45:37 -0700 (PDT)
In-Reply-To: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: john.cooper@third-harmonic.com, alsa-devel@alsa-project.org, chasedouglas@gmail.com, buytenh@wantstofly.org, r&d4@dave-tech.it, hartleys@visionengravers.com, marshall@coolbananas.co.nz, linux-arm-kernel@lists.infradead.org, dhuggins@cs.cmu.edu
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-04 at 17:11 +1200, Ryan Mallon wrote:
> The following patch series adds support for i2s audio on the ep93xx,
> with the Snapper CL15 used as an example implementation.
> 
> This version fixes a number of things from the previous round:
>  - Removed unused #defines
>  - Set symmetric rates for the cpu dai
>  - Fixed the sdiv/lrdiv calculation loop
>  - Moved the cpu dai registration
>  - Removed empty ep93xx_pcm_prepare callback
>  - Fixed enable/disable when both capture and playback are running
>  
> Capture still does not work. The dma is running, but the captured data
> is all zeros (tested used arecord and loopback). I have a 2.6.20
> kernel with ep93xx i2s audio working an capture works there on the
> same hardware. I have spent sometime looking into this, but can't see
> the problem. Would appreciate if someone can lend some insight as to
> what I have done wrong.
> 
> Ryan Mallon (3):
>   ep93xx i2s core support
>   ep93xx i2s audio driver
>   Snapper cl15 audio support

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
