From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH V2 1/3] ASoC: restructure
	dmaengine_pcm_request_chan_of()
Date: Fri, 06 Dec 2013 10:30:26 +0100
Message-ID: <52A19932.8050002@metafoo.de>
References: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-151.synserver.de (smtp-out-158.synserver.de
 [212.40.185.158])
 by alsa0.perex.cz (Postfix) with ESMTP id E3106261ADF
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 10:29:43 +0100 (CET)
In-Reply-To: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/03/2013 10:26 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Restructure the internals of dmaengine_pcm_request_chan_of() as a loop
> over all channels to be allocated. This makes it easier to add logic
> that applies to all allocated channels, without having to duplicate that
> logic in each of the half-duplex/full-duplex paths.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Looks good, makes sense.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
