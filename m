From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [asoc:topic/atmel 7/7] ERROR: Input tree has
 errors, aborting (use -f to force output)
Date: Wed, 07 Nov 2012 09:29:32 +0800
Message-ID: <5099B97C.7090900@atmel.com>
References: <20121106105856.GA17982@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B589264EF6
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 02:30:10 +0100 (CET)
In-Reply-To: <20121106105856.GA17982@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Fengguang Wu,

On 11/6/2012 18:58, Fengguang Wu wrote:
> Hi Bo,
>
> FYI, kernel build failed on
>
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/atmel
> head:   e9898f35f539f3a1aecf054d01cc1631aaa67be4
> commit: e9898f35f539f3a1aecf054d01cc1631aaa67be4 [7/7] ARM: at91: atmel-ssc: add device tree support
> config: make ARCH=arm at91_dt_defconfig
>
> All error/warnings:
>
> ERROR (duplicate_label): Duplicate label 'ssc0' on /ahb/apb/ssc@fffa0000 and /ahb/apb/ssc@fff9c000
> ERROR: Input tree has errors, aborting (use -f to force output)

Thanks for finding this issue.
I will correct it in next version.
Thanks again.

BRs
Bo Shen

> ---
> 0-DAY kernel build testing backend         Open Source Technology Center
> Fengguang Wu, Yuanhan Liu                              Intel Corporation
>
