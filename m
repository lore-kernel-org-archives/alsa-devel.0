From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2] ASoC: tpa6130a2: Replace DAPM code with
 direct interface
Date: Thu, 02 Dec 2010 11:50:43 +0000
Message-ID: <1291290643.3262.47.camel@odin>
References: <1291274996-28056-1-git-send-email-peter.ujfalusi@nokia.com>
	<20101202095626.GB19267@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DD822103A50
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:50:47 +0100 (CET)
Received: by wyi11 with SMTP id 11so8111623wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 03:50:47 -0800 (PST)
In-Reply-To: <20101202095626.GB19267@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-02 at 09:56 +0000, Mark Brown wrote:
> On Thu, Dec 02, 2010 at 09:29:56AM +0200, Peter Ujfalusi wrote:
> > The use of DAPM widgets, and extra routing can cause ordering
> > problems in the system.
> > Machine drivers should use the exported direct interface with
> > SND_SOC_DAPM_HP's event callback to manage the state of the
> > amplifier.
> 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> I thought we'd decided that adding a HP widget in the driver was the
> most straightforward thing here?  Still...
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
