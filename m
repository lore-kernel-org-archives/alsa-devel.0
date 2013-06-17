From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 1/3 v2] mfd: arizona: Integrate wm8997 into
	Arizona mfd
Date: Tue, 18 Jun 2013 00:50:26 +0200
Message-ID: <20130617225026.GT7998@zurbaran>
References: <1371113011-11918-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C12C26509A
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2013 00:50:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1371113011-11918-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Charles,

On Thu, Jun 13, 2013 at 09:43:29AM +0100, Charles Keepax wrote:
> The wm8997 is a compact, high-performance audio hub CODEC with SLIMbus
> interfacing, for smartphones, tablets and other portable audio devices
> based on the Arizona platform.
> 
> This patch integrates the wm8997 into the Arizona mfd.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> ---
>  drivers/mfd/Kconfig              |    6 +
>  drivers/mfd/Makefile             |    3 +
>  drivers/mfd/arizona-core.c       |   27 +
>  drivers/mfd/arizona-i2c.c        |    6 +
>  drivers/mfd/arizona-irq.c        |    8 +
>  drivers/mfd/arizona.h            |    5 +
>  drivers/mfd/wm8997-tables.c      | 1525 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/arizona/core.h |    2 +
>  8 files changed, 1582 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/wm8997-tables.c
Applied to mfd-next, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
