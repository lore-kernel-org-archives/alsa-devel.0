From: Shawn Guo <shawn.guo@linaro.org>
Subject: How should SGTL5000 codec driver adapt to dummy
	regulator change?
Date: Tue, 3 Dec 2013 14:53:21 +0800
Message-ID: <20131203065320.GB10840@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C498265109
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 07:50:21 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark,

The sgtl5000_enable_regulators() function in SGTL5000 codec driver makes
the decision whether an external VDDD supply is available by checking
the return of regulator_bulk_get() call.  It used to work because dummy
regulator did not play in there, and if regulator_bulk_get() fails, most
likely it's only because there is no external VDDD supply.  But with
commit 4ddfebd (regulator: core: Provide a dummy regulator with full
constraints) merged, the regulator_bulk_get() will always succeed.  It
breaks the driver's assumption.  What's your suggestion to the problem?

Shawn
