From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: compress_core: integer overflow in
 snd_compr_allocate_buffer()
Date: Thu, 6 Sep 2012 07:59:13 -0700
Message-ID: <20120906145912.GK19410@mwanda>
References: <20120905123217.GD6128@elgon.mountain>
 <s5hwr08ziyx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
 by alsa0.perex.cz (Postfix) with ESMTP id B2E6F260312
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2012 16:59:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwr08ziyx.wl%tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jesper Juhl <jj@chaosbits.net>, Namarta Kohli <namartax.kohli@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 05, 2012 at 03:40:06PM +0200, Takashi Iwai wrote:
> At Wed, 5 Sep 2012 15:32:18 +0300,
> Dan Carpenter wrote:
> > 
> > These are 32 bit values that come from the user, we need to check for
> > integer overflows or we could end up allocating a smaller buffer than
> > expected.
> 
> The buffer size here is supposed to be fairly small that kmalloc can
> handle.  So, the overflow check is good, but in practice it'd return
> -ENOMEM.

My concern was the security implications from an integer wrap.  If
we chose ->fragment_size = 256 and ->fragments = 0x80000001 then the
size of the final buffer would only be 256 bytes.  The allocation
would succeed and it might lead to memory corruption later on.  I
haven't followed it through to verify but adding a sanity check is a
good idea.  It should probably be pushed to -stable as well.

> Of course, it's fine to put the sanity check, but such
> checks could be better peformed in snd_compr_set_params() before
> calling the allocation, I think.

To me it looks sort of weird to do the checking there.  Also if we
add more callers we would have to add the checking to all the
callers as well.  I can do that if you still prefer.

regards,
dan carpenter

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index ec2118d..5a733e7 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -409,6 +409,10 @@ static int snd_compr_allocate_buffer(struct snd_compr_stream *stream,
> >  	unsigned int buffer_size;
> >  	void *buffer;
> >  
> > +	if (params->buffer.fragment_size == 0 ||
> > +	    params->buffer.fragments > SIZE_MAX / params->buffer.fragment_size)
> > +		return -EINVAL;
> > +
> >  	buffer_size = params->buffer.fragment_size * params->buffer.fragments;
> >  	if (stream->ops->copy) {
> >  		buffer = NULL;
> > 
