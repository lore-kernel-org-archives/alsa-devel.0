From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: data write in alsa
Date: Fri, 02 Dec 2011 17:17:34 +0530
Message-ID: <1322826454.1516.1012.camel@vkoul-udesk3>
References: <1322808881.1516.1011.camel@vkoul-udesk3>
	<s5hr50no3a9.wl%tiwai@suse.de>  <4ED87B45.5080603@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id B4AE224152
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 12:49:45 +0100 (CET)
In-Reply-To: <4ED87B45.5080603@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Pierre-louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-12-02 at 08:16 +0100, Jaroslav Kysela wrote:
> > But, honestly speaking, I don't like this implementation.  For a new
> > interface, I'd suggest to stick with the normal read/write.
> Otherwise
> > you'll get a mess of 32bit compat layer again.
> 
> I think that for compressed data, the standard r/w ops are fine,
> because 
> there are no "frames". 
Thanks, I had the same assumptions as well, wanted to check before
posting next version

-- 
~Vinod
