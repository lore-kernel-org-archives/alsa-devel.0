From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: RFC: support for 12 & 24Khz
Date: Sun, 28 Jul 2013 17:54:07 +0530
Message-ID: <20130728122407.GC1986@intel.com>
References: <20130724172640.GE18642@intel.com> <51F0CAC0.9090702@ladisch.de>
 <20130725154501.GN18642@intel.com> <s5h1u6mk3dm.wl%tiwai@suse.de>
 <20130726060908.GA1986@intel.com> <s5hob9p7q7e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id C2C45261736
 for <alsa-devel@alsa-project.org>; Sun, 28 Jul 2013 15:02:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hob9p7q7e.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: pierre-louis.bossart@linux.jf.intel.com, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 26, 2013 at 09:09:09AM +0200, Takashi Iwai wrote:
> Relying only on SNDRV_PCM_RATE_* bits doesn't scale.
> What if more other rates are needed at the next time?
Agreed, this is my thinking as well. Remove the usage of macro and use raw rate
values...

~Vinod
-- 
