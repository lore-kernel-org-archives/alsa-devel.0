From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Use delayed work for debounce of
 GPIO based jacks
Date: Thu, 07 Oct 2010 19:13:03 +0100
Message-ID: <1286475183.3149.16.camel@odin>
References: <1286406301-25767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 7FCFC24547
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 20:13:09 +0200 (CEST)
Received: by wwb28 with SMTP id 28so143330wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 07 Oct 2010 11:13:09 -0700 (PDT)
In-Reply-To: <1286406301-25767-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2010-10-06 at 16:05 -0700, Mark Brown wrote:
> Rather than block the workqueue by sleeping to do the debounce use delayed
> work to implement the debounce time. This should also mean that we extend
> the debounce time on each new bounce, potentially allowing shorter debounce
> times for clean insertions.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
