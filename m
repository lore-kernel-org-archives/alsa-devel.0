From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Implement interrupt based jack
 detection
Date: Sat, 02 Oct 2010 12:04:00 +0100
Message-ID: <1286017440.3125.3.camel@odin>
References: <1285918097-20720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EF401037F1
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Oct 2010 13:04:02 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 42so3727492wyb.38
	for <alsa-devel@alsa-project.org>; Sat, 02 Oct 2010 04:04:02 -0700 (PDT)
In-Reply-To: <1285918097-20720-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-10-01 at 00:28 -0700, Mark Brown wrote:
> Allow microphone detection on WM8962 to be performed using the interrupt
> signal, allowing the detection of both microphone presence and button
> presses with a signal singal from the CODEC to CPU.  Currently a 250ms
> debounce time is applied to both short circuit and presence detection,
> this has not been optimised.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
