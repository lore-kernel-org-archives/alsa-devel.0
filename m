From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Prevent system suspend while
 debouncing wakeup capable GPIO jacks
Date: Mon, 15 Nov 2010 11:09:00 +0000
Message-ID: <1289819340.3377.14.camel@odin>
References: <1289762773-19239-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 043B6103836
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 12:09:02 +0100 (CET)
Received: by wyg36 with SMTP id 36so3482678wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 03:09:02 -0800 (PST)
In-Reply-To: <1289762773-19239-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2010-11-14 at 19:26 +0000, Mark Brown wrote:
> If the device associated with a GPIO jack is wakeup capable then disable
> suspend while we're debouncing the jack so that we skip suspends that race
> with the jack.
> 
> Note that currently the GPIO based jack has a CODEC associated with it
> which we're using right now. These jacks should be reparented against the
> card itself and this code adjusted.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
