From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ALSA: compress: Add
	SND_AUDIOCODEC_BESPOKE
Date: Mon, 9 Nov 2015 10:13:55 +0530
Message-ID: <20151109044354.GE22709@localhost>
References: <1446828354-28767-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id E4DA9260715
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 05:40:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1446828354-28767-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 06, 2015 at 04:45:54PM +0000, Charles Keepax wrote:
> When working with the compressed framework occasionally vendors will
> use esoteric internal audio formats. For such formats it doesn't really
> make sense to add an new define to the kernel as their use is not
> sufficiently general.
> 
> This patch adds a new define SND_AUDIOCODEC_BESPOKE that vendors can use
> in such situations.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
