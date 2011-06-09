From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/1] Submitting MAX98088 codec patch
Date: Thu, 9 Jun 2011 11:47:58 +0100
Message-ID: <20110609104758.GC12865@opensource.wolfsonmicro.com>
References: <BANLkTikLubBnrPp0BTMcNEFp2sfAyZnE4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9EDE1037F5
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 12:47:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTikLubBnrPp0BTMcNEFp2sfAyZnE4A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jin Park <jinyoungp@nvidia.com>
Cc: Peter.Hsiang@maxim-ic.com, alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011 at 05:50:16PM +0900, Jin Park wrote:

> The max98088 codec driver had unnecessary duplicated codes on DAI operations.
> For example, max98088_dai1_hw_params and max98088_dai2_hw_params,
> they are almost same, except only register offsets.
> So I have combined DAI operations for DAI1 and DAI2.
> Please review my patch.

Note that there's no need to have a cover letter for a single patch -
any useful information should be in the patch itself.
