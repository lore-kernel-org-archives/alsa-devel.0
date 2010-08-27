From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: tlv320aic3x: Sort output pin
	control registers in header file
Date: Fri, 27 Aug 2010 15:18:17 +0100
Message-ID: <14194863-1213-4FF9-A110-756C6E3FA2D6@opensource.wolfsonmicro.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
	<1282917410-12000-3-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145611_034854_5DC35F62)
Mime-Version: 1.0 (iPad Mail 7B500)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 13E4724625
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 16:18:11 +0200 (CEST)
In-Reply-To: <1282917410-12000-3-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145611_034854_5DC35F62)
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

> Each output pin has 7 consecutive control registers in tlv320aic3x register
> map. First 6 of them control the signal mixing and one is for output level
> and power control.
> 
> Sort these registers as they are sorted clearly in hardware, it makes also
> definitions more readable and easier to pinpoint missing register
> definitions.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
