From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/5] ASoC: ep93xx: get rid of
 ep93xx-pcm-audio struct device
Date: Tue, 10 Dec 2013 09:58:36 -0700
Message-ID: <52A7483C.5060901@wwwdotorg.org>
References: <1386620656-18391-1-git-send-email-swarren@wwwdotorg.org>
 <1386620656-18391-2-git-send-email-swarren@wwwdotorg.org>
 <20131210102605.GY29268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C4112652AC
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 17:58:40 +0100 (CET)
In-Reply-To: <20131210102605.GY29268@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@nvidia.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>
List-Id: alsa-devel@alsa-project.org

On 12/10/2013 03:26 AM, Mark Brown wrote:
> On Mon, Dec 09, 2013 at 01:24:12PM -0700, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Modify the ep93xx PCM driver so that it's a utility library that can be
>> registered on each DAI, rather than a separate struct device. This is
>> more in line with how many recent DT-converted platforms operate, and
>> avoids the need for yet another struct device.
> 
> Please CC driver maintainers, adding Hartley and Ryan.

A MAINTAINERS entry would be useful; get_maintainers on this patch only
finds MAINTAINERS entries for ASoC itself, and a jumble of other commit
signers, with a distribution of committers so it's not obvious who might
be the driver maintainer.
