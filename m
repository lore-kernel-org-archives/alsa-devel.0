From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [GIT PULL] ASoC: DMA deferred probe dependencies
Date: Tue, 10 Dec 2013 10:32:32 -0700
Message-ID: <52A75030.2050503@wwwdotorg.org>
References: <1386695920-1447-1-git-send-email-swarren@wwwdotorg.org>
 <20131210172939.GE11468@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 82C642652AC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 18:40:30 +0100 (CET)
In-Reply-To: <20131210172939.GE11468@sirena.org.uk>
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
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/10/2013 10:29 AM, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 10:18:40AM -0700, Stephen Warren wrote:
> 
>> The following branch/patch is a dependency for my "ASoC: dmaengine:
>> support deferred probe for DMA channels". If you could pull the branch
>> below into your topic/dma, then merge my ASoC patch, that would be
> 
> I've no idea which ASoC patch this is, sorry.  You've been sending quite
> a few things recently and I've nothing in my review queue from you which
> looks like a likely candidate - it may be that I've discarded it due to
> the dependencies though.

I'll resend the patch. You may have discarded it since you'd ack'd it
for me to apply, but it's probably better if it goes into your tree
first, and then I pull from you.
