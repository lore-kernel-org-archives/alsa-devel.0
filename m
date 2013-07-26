From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] ASoC: wm8994: Add clock bindings to the
	device tree
Date: Fri, 26 Jul 2013 09:41:52 -0600
Message-ID: <51F298C0.1090801@wwwdotorg.org>
References: <1374762668-5037-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 974A0265769
 for <alsa-devel@alsa-project.org>; Fri, 26 Jul 2013 17:41:56 +0200 (CEST)
In-Reply-To: <1374762668-5037-1-git-send-email-broonie@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Mark Brown <broonie@linaro.org>, patches@opensource.wolfsonmicro.com, Rob Herring <rob.herring@calxeda.com>
List-Id: alsa-devel@alsa-project.org

On 07/25/2013 08:31 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Due to the variable availability of the clock API there is no code in the
> driver to use these at present, for the time being the machine drivers
> will need to handle requesting clocks.

Presumably before considering any/most CODEC bindings complete, we need
to make a similar change?
