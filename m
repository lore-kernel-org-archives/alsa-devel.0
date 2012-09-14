From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: compress_core: integer overflow in
 snd_compr_allocate_buffer()
Date: Fri, 14 Sep 2012 12:35:27 +0300
Message-ID: <20120914093527.GD4587@mwanda>
References: <20120905123217.GD6128@elgon.mountain>
 <s5hwr08ziyx.wl%tiwai@suse.de> <20120906145912.GK19410@mwanda>
 <s5h627rxjpw.wl%tiwai@suse.de> <s5hligdc6su.wl%tiwai@suse.de>
 <1347614682.1943.35.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 by alsa0.perex.cz (Postfix) with ESMTP id B6F7D265CCB
 for <alsa-devel@alsa-project.org>; Fri, 14 Sep 2012 11:35:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347614682.1943.35.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jesper Juhl <jj@chaosbits.net>, Namarta Kohli <namartax.kohli@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 14, 2012 at 02:54:42PM +0530, Vinod Koul wrote:
> On Fri, 2012-09-14 at 11:06 +0200, Takashi Iwai wrote:
> > > So, we actually should have two distinct fixes.
> > 
> > I took Dan's patch now for next branch.  But it's still better to
> > filter weird parameters in the caller side, too.
> > 
> > Vinod, care to write such a patch and submit? 
> Yes am already on it :)
> 

Thanks.  I've had my text editor open to the file all week, but it
felt like there was probably a better limit to use than just what
would overflow...  I just don't know the code very well.  I'm glad
that Vinod is handling this.

regards,
dan carpenter
