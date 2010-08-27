From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: tlv320aic3x: Reimplement output
	mixers
Date: Fri, 27 Aug 2010 15:21:19 +0100
Message-ID: <323888F1-24C3-4169-8EEB-256A333FC185@opensource.wolfsonmicro.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
	<1282917410-12000-4-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145617_277181_7843B9E1)
Mime-Version: 1.0 (iPad Mail 7B500)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3923224624
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 16:21:20 +0200 (CEST)
In-Reply-To: <1282917410-12000-4-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145617_277181_7843B9E1)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 27 Aug 2010, at 14:56, Jarkko Nikula <jhnikula@gmail.com> wrote:

> It turned out that the output mixers and their routes were misdefined: They
> are not mixing output pins to internal signals but opposite. This has worked
> for direct left-to-left and right-to-right routes since for those there are
> complete routes. For swapped left-to-right and right-to-left routes this is
> not working since there are no routes defined between them.
> 
> Another consequence is that those misdefined mixers are incorrectly routed
> to several output pins leading unnecessary pin powerings even if there is no
> route active to them.
> 
> Fix these by reimplementing the output mixers and routes as they are in
> hardware. For completeness add also a few missing links between internal
> signals and outputs.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
