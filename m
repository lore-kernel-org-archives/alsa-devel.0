From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/5] ASoc: support 88pm860x codec driver
Date: Fri, 13 Aug 2010 15:02:39 +0100
Message-ID: <20100813140238.GC6449@rakim.wolfsonmicro.main>
References: <AANLkTintnm9NYS+cybvgPyNWqBg_=7_tJGG-TBxvsJRc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D4F6103850
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 16:02:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTintnm9NYS+cybvgPyNWqBg_=7_tJGG-TBxvsJRc@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 13, 2010 at 09:55:00PM +0800, Haojian Zhuang wrote:

> Add 88pm860x codec driver. This series patch is based on ASoC for-2.6.37 branch.

Hrm, looking at this series much of it is not actually related to the
CODEC - 2/5 patches are bugfixes for the PXA multi-component code, for
example.  No problem with the patches themselves but it's good to be
clearer about what you're doing.
