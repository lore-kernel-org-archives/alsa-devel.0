From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Use pm_wakeup_event() in WM8962 jack
 detection
Date: Wed, 03 Nov 2010 19:25:41 +0000
Message-ID: <1288812341.3277.169.camel@odin>
References: <1288810218-30825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A016103807
	for <alsa-devel@alsa-project.org>; Wed,  3 Nov 2010 20:25:47 +0100 (CET)
Received: by wwi17 with SMTP id 17so1118921wwi.20
	for <alsa-devel@alsa-project.org>; Wed, 03 Nov 2010 12:25:45 -0700 (PDT)
In-Reply-To: <1288810218-30825-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2010-11-03 at 14:50 -0400, Mark Brown wrote:
> Ensure that the system does not suspend while we process a WM8962 jack
> event by using pm_wakeup_event() to block the suspend while we're waiting
> for the jack to settle. Use a slightly longer timeout than the jack waits
> to allow for other stuff to take over and delays in scheduling.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
