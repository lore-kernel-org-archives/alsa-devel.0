From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 2/2] ASoC: cs42l51: Convert to direct
	regmap API usage
Date: Tue, 11 Feb 2014 19:50:41 +0000
Message-ID: <7DDFB7B5-0471-42D0-AECB-48E730002449@cirrus.com>
References: <1392146808-19269-1-git-send-email-broonie@kernel.org>,
 <1392146808-19269-2-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E8A26084D
 for <alsa-devel@alsa-project.org>; Tue, 11 Feb 2014 20:50:46 +0100 (CET)
In-Reply-To: <1392146808-19269-2-git-send-email-broonie@kernel.org>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org



> On Feb 11, 2014, at 13:27, "Mark Brown" <broonie@kernel.org> wrote:
> 
> From: Mark Brown <broonie@linaro.org>
> 
> As part of phasing out the ASoC level register I/O code (which is now just
> a thin wrapper around regmap anyway) convert the cs42l51 driver to use the
> regmap API directly.
> 
> We now no longer initialise the cache from hardware at startup, the regmap
> caches are smart enough to understand which registers are actually cached
> and read on demand. This should have no visible effect on the system.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>
