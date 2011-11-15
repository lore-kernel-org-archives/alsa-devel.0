From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: question on snd minors
Date: Tue, 15 Nov 2011 16:21:08 +0530
Message-ID: <1321354268.1516.137.camel@vkoul-udesk3>
References: <1321330163.1516.51.camel@vkoul-udesk3>
	<s5h62ildh3z.wl%tiwai@suse.de> <1321343139.1516.60.camel@vkoul-udesk3>
	<s5hy5vhbya9.wl%tiwai@suse.de> <1321349133.1516.134.camel@vkoul-udesk3>
	<s5hobwdbsp0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 89370245ED
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 11:55:54 +0100 (CET)
In-Reply-To: <s5hobwdbsp0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-11-15 at 11:12 +0100, Takashi Iwai wrote:
> OK, if there aren't so many devices, we may still reserved slots
> (minor 2 and 3).  These can be assigned for the new type.  Will be
> there two completely different DSPs?  If it's unlikely, just grab one
> minor as the start, I'd say.  You can still implement the substreams
> in a single device.
> 
> Note that the above story is only for the case without
> CONFIG_SND_DYNAMIC_MIONRS.  If you use CONFIG_SND_DYNAMIC_MINORS (this
> is usually set for all modern distros), there is no restriction but
> the total number of minors since the minor numbers are assigned
> dynamically.  So you can forget all in the above.
Okay thanks. I won't try to guess which options the OSes would try to
use, so taking safer approach and ensure they work for both.
Any case if someone doesn't like the restriction they can use
SND_DYNAMIC_MINORS :)

-- 
~Vinod
