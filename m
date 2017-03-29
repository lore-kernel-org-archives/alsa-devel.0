From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 6/8] regulator: arizona-micbias: Add
 regulator driver for Arizona micbiases
Date: Wed, 29 Mar 2017 09:30:02 +0100
Message-ID: <20170329083002.GT6986@localhost.localdomain>
References: <1490710484-25277-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <201703291403.z4sFz6z9%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 91839266998
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 10:29:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201703291403.z4sFz6z9%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lee.jones@linaro.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 29, 2017 at 02:18:23PM +0800, kbuild test robot wrote:
> Hi Charles,
> 
> [auto build test WARNING on regulator/for-next]
> [also build test WARNING on v4.11-rc4 next-20170328]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Charles-Keepax/regulator-arizona-micsupp-Avoid-potential-memory-leak-reading-init_data/20170329-112224
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
> config: i386-randconfig-x0-03291136 (attached as .config)
> compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 

Hmm... this is due to the tree missing the patch that Lee already
applied from version 1. I guess perhaps we should pull that back
into this series or he could make an immutable branch you can pull
in?

Thanks,
Charles
