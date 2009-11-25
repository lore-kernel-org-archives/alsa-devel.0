From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH V2] Add i.MX sound support
Date: Wed, 25 Nov 2009 16:41:03 +0100
Message-ID: <1259163666-30344-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 226B7243B3
	for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2009 16:41:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi All,

Here is the second version of the patches to add i.MX sound support.

This time I haven't included ARM related patches, so this series should
be safe to apply.

I skipped the mc13783 driver since I'm not ready integrating the comments
from Mark.

The main change in the driver is that I splitted out the transport from
the driver, so it should be easy to add another transport layer to the
driver when SDMA support is merged. I hopefully also addressed the other
comments from Mark.

Sascha
