From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: MXS: How to configure SGTL5000 ASoC as master?
Date: Tue, 10 Jan 2012 08:19:36 +0200
Message-ID: <4F0BD878.40508@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from darkblue.bluegiga.com (bluegiga.fi [194.100.31.45])
	by alsa0.perex.cz (Postfix) with ESMTP id C84A110393F
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 07:19:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dong Aisheng <b29396@freescale.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

SGTL5000 ASoC is hard coded to be slave in sound/soc/mxs/mxs-sgtl5000.c. 
In our HW design mclk of ASoC is sourced from external oscillator. 
Because of our design ASoC should be configured as master. In that case 
master clock of SAIF should be disabled.

Is there any plan to have configuration for mxs-sgtl5000 driver? What is 
preferred way to solve this issue?

BR,
Lauri Hintsala

p.s. I resent this mail because I wasn't subscriber of alsa-devel 
mailing list.
