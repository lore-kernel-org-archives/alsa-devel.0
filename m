From: "Ambrose, Martin" <martin@ti.com>
Subject: [PATCH 0/1] Add AIC3106 support.
Date: Wed, 13 May 2009 10:28:20 -0500
Message-ID: <A24693684029E5489D1D202277BE89443E39393E@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 763FE2480F
	for <alsa-devel@alsa-project.org>;
	Wed, 13 May 2009 17:28:31 +0200 (CEST)
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4DFSMvk025540
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 10:28:27 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id n4DFSMEU018715
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 10:28:22 -0500 (CDT)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I patched in support for the AIC3106 codec which is the IC on the DA830 EVM.

This patch applies to the ASoC tree: ddc4097b77bbb227851a44287acb2fb8a9896cc1
But it also applies cleanly to the Davinci tree:

Unfortunately there are missing pieces needed (e.g. edma/mcasp) for this board on the
Davinci tree to test directly. But it passes the smoke test of building and running on the
Davinci EVM.

-Martin
