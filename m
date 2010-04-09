From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] pxa: add namespace on ssp
Date: Fri, 9 Apr 2010 12:16:09 +0100
Message-ID: <20100409111609.GA13281@sirena.org.uk>
References: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CF6412460C
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Apr 2010 13:16:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <k2s771cded01003310546y48e1431r71820b73f69e53d5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 31, 2010 at 08:46:42AM -0400, Haojian Zhuang wrote:
> From b52a0d2687e82f81d38198cb450b6a39a9e53851 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 31 Mar 2010 15:08:55 -0400
> Subject: [PATCH] [ARM] pxa: add namespace on ssp
> 
> In order to prevent code ambiguous, add namespace on functions in ssp driver.

Liam acked these on IRC so I was going to apply them (the interface for
the sysclk configuration should be fixed, but that can be done as a
followup patch) but I can't seem to find a branch that these apply to -
they don't apply cleanly to either Eric's ssp_cleanup branch, the ASoC
for-2.6.35 branch, nor a merge of the two.
