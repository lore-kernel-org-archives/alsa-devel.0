From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Lock the CODEC in PXA external jack
 controls
Date: Sat, 06 Nov 2010 10:55:09 +0000
Message-ID: <1289040909.3318.7.camel@odin>
References: <1288979601-9105-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D6A5024335
	for <alsa-devel@alsa-project.org>; Sat,  6 Nov 2010 11:55:12 +0100 (CET)
Received: by wwi17 with SMTP id 17so1939847wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 06 Nov 2010 03:55:12 -0700 (PDT)
In-Reply-To: <1288979601-9105-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Miao <eric.y.miao@gmail.com>, Eric@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-11-05 at 13:53 -0400, Mark Brown wrote:
> When doing anything with the system, especially DAPM, we need to hold the
> CODEC mutex.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'm fine for this atm, but obviously we need to rework the DAPM locking
a little as we dont want developers to have to care about locking
internals.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
