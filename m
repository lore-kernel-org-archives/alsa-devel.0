From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Actively manage WM8903 DC servo
 configuration
Date: Wed, 09 Feb 2011 21:49:54 +0000
Message-ID: <1297288194.3297.181.camel@odin>
References: <1297282510-2319-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C39DF243FC
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 22:49:57 +0100 (CET)
Received: by wyi11 with SMTP id 11so649986wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Feb 2011 13:49:57 -0800 (PST)
In-Reply-To: <1297282510-2319-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-02-09 at 20:15 +0000, Mark Brown wrote:
> Explicitly cache the DC servo offsets for digital paths in the driver,
> allowing them to be preserved over suspend and resume, and ensure that
> we recalibrate analogue outputs paths when they are in use so that we
> cover any changes in the input offset.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
