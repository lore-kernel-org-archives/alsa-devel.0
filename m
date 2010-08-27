From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: tlv320aic3x: Fix remaining
	output pin switch names
Date: Fri, 27 Aug 2010 15:17:02 +0100
Message-ID: <5634BAA9-C9EC-47AF-A760-68E253CED608@opensource.wolfsonmicro.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
	<1282917410-12000-2-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145607_665728_84D99FCF)
Mime-Version: 1.0 (iPad Mail 7B500)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9494A24624
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 16:17:37 +0200 (CEST)
In-Reply-To: <1282917410-12000-2-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145607_665728_84D99FCF)
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

> Bit 3 in output pin_CTRL register mutes the whole output pin not just the
> route from DAC so remove misleading DAC from control name. Currently only
> "Line[L | R] Playback Switch" were correct.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
