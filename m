From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: tlv320aic3x: Sanitize output
	controls
Date: Fri, 27 Aug 2010 15:24:14 +0100
Message-ID: <9CB0AF61-AC6C-4E37-9595-55EA47D966A6@opensource.wolfsonmicro.com>
References: <1282917410-12000-1-git-send-email-jhnikula@gmail.com>
	<1282917410-12000-5-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145630_701379_761FEB67)
Mime-Version: 1.0 (iPad Mail 7B500)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 195DD24625
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 16:24:15 +0200 (CEST)
In-Reply-To: <1282917410-12000-5-git-send-email-jhnikula@gmail.com>
	(sfid-20100827_145630_701379_761FEB67)
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

> Currently output controls are not uniform. Some routes are adjusted by
> mono controls that don't match to associated mixer switch, many routes are
> not covered at all and stereo controls have following variants:
> 
> - L-to-L & R-to-R
> - R-to-L & R-to-R
> - L-to-L & R-to-L
> 
> This patch attempts to fix these issues. First, for the convenience, only
> direct L-to-L, R-to-R and [L | R]-to-Mono routes are controlled by the
> stereo controls. This logic is also used with the output pin mute controls
> so all of them except mono output are controlled by stereo switches.
> 
> Then rest of the swapped L-to-R and R-to-L routes are controlled by the
> mono controls that map to mixer switches with a same name. Mixers can then
> associate these switches and volumes together.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
