From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] tlv320aic3x: control additions and	cleanups
Date: Thu, 4 Dec 2008 18:37:47 +0000
Message-ID: <20081204183746.GB6628@sirena.org.uk>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A565B1037F6
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 19:37:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081204175121.GD21010@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org, u.luckas@road.de
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 04, 2008 at 06:51:21PM +0100, Daniel Mack wrote:

> - split "Line Playback Switch" into "LineL Playback Switch" and "LineR
>   Playback Switch"
> - split "Line PGA Bypass Playback Volume" into "LineL Left PGA Bypass
>   Playback Volume" and "LineR Right PGA Bypass Playback Volume"

I can't help thinking that it'd be easier to just use "Left Line" and
"Right Line" but that's an existing issue in the driver.

> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Signed-off-by: Uli Luckas <u.luckas@road.de>                                                                                                             
Did you write this patch or did Uli?  If you wrote it the line for Uli
should be an Acked-by, if he wrote it then your Signed-off-by should
come second and it should have a From: for him at the top.

The patch itself looks good.
