From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [patch] ALSA: compress_core: integer overflow in
 snd_compr_allocate_buffer()
Date: Fri, 14 Sep 2012 14:54:42 +0530
Message-ID: <1347614682.1943.35.camel@vkoul-udesk3>
References: <20120905123217.GD6128@elgon.mountain>
 <s5hwr08ziyx.wl%tiwai@suse.de> <20120906145912.GK19410@mwanda>
 <s5h627rxjpw.wl%tiwai@suse.de>  <s5hligdc6su.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 665A3265CF8
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 11:28:11 +0200 (CEST)
In-Reply-To: <s5hligdc6su.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jesper Juhl <jj@chaosbits.net>, Namarta Kohli <namartax.kohli@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-09-14 at 11:06 +0200, Takashi Iwai wrote:
> > So, we actually should have two distinct fixes.
> 
> I took Dan's patch now for next branch.  But it's still better to
> filter weird parameters in the caller side, too.
> 
> Vinod, care to write such a patch and submit? 
Yes am already on it :)

-- 
~Vinod
