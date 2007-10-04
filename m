From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: ASoC v2 on PowerPC
Date: Thu, 4 Oct 2007 13:12:42 -0400
Message-ID: <9e4733910710041012vb8e2a25w7a3b2cc7be80426d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by alsa0.perex.cz (Postfix) with ESMTP id F00DD24421
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Oct 2007 19:12:44 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so218366nzf
	for <alsa-devel@alsa-project.org>; Thu, 04 Oct 2007 10:12:43 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I'm looking into write a ASoC v2 driver for the Efika. Efika uses a
Freescale MPC5200B and a STAC9766. This is a practice driver before
writing one for our target hardware (which doesn't work yet, same CPU
but different codec).

I've brought the changes from wolfson/asoc-v2-dev into my powerpc tree
and got a couple of config errors with ARCH=powerpc.

sound/soc/pxa/Kconfig:23:warning: 'select' used by config symbol
'SND_PXA2XX_SOC_SSP' refers to undefined symbol 'PXA_SSP'
sound/soc/au1x/Kconfig:35:warning: 'select' used by config symbol
'SND_SOC_EXM1200_SSI' refers to undefined symbol 'SND_SOC_CS4251X'

Suggestions on the best way to start? Target hardware also has a WM8804 on it.

-- 
Jon Smirl
jonsmirl@gmail.com
