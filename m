From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/5] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Tue, 10 Dec 2013 09:56:39 -0700
Message-ID: <52A747C7.9040706@wwwdotorg.org>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
 <52A62BC3.1050807@metafoo.de> <52A6573E.1000504@wwwdotorg.org>
 <52A6C702.4000607@metafoo.de> <20131210102334.GX29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C8792652AC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 17:56:45 +0100 (CET)
In-Reply-To: <20131210102334.GX29268@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/10/2013 03:23 AM, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 08:47:14AM +0100, Lars-Peter Clausen wrote:
> 
>> I'd assume that the first two patches from this series go into
>> topic/ep93xx and the second two into topic/spear and the last one
>> will have to wait for ux500 anyway.
> 
> Yes.

OK, so you plan on merging topic/dma into topic/ep93xx and topic/spear
then? Since this series does depend on patches in topic/dma.
