From: Eric Miao <eric.y.miao@gmail.com>
Subject: [RFC PATCH 0/5] PXA SSP code cleanup
Date: Thu, 23 Apr 2009 13:03:19 +0800
Message-ID: <f17812d70904222203x737cf386gfa81a6c576dd4aa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 015251037F0
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 07:03:19 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so324710qwk.56
	for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2009 22:03:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, Mark Brown <broonie@sirena.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Remove legacy SSP API by deprecating the only user now - corgi_ts.c,
(which could be now well substituted by ads7846 after the sync patch)

sound/soc/pxa/pxa-ssp.c is modified and simplified a bit.

I guess sound/soc/pxa/pxa-ssp.c will still have to undergo the changes
as ASoCv2 progress, hopefully that should be a little bit easier now.

-- 
Cheers
- eric
