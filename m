From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [patch] ALSA: compress: info leak in
	snd_compr_get_caps()
Date: Sun, 21 Apr 2013 19:39:06 +0300
Message-ID: <20130421163906.GL6638@mwanda>
References: <20130421110729.GA6171@elgon.mountain>
 <5173D029.10806@bfs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id A2AD3260799
 for <alsa-devel@alsa-project.org>; Sun, 21 Apr 2013 18:39:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5173D029.10806@bfs.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: walter harms <wharms@bfs.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Jeeja KP <jeeja.kp@intel.com>, Namarta Kohli <namartax.kohli@intel.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 21, 2013 at 01:40:25PM +0200, walter harms wrote:
> 
> 
> Am 21.04.2013 13:07, schrieb Dan Carpenter:
> > If the ->get_caps() function doesn't clear the buffer then there would
> > stack information leaked to userspace.  For example,
> > soc_compr_get_caps() can return success without clearing the buffer.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Perhaps the soc_compr_get_caps() function should return an error code
> > if the platform->driver->compr_ops is NULL.  I'm not sure about that,
> > and it's a separate issue anyway.
> > 
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index c84abc8..8d3190a 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -375,6 +375,7 @@ snd_compr_get_caps(struct snd_compr_stream *stream, unsigned long arg)
> >  	if (!stream->ops->get_caps)
> >  		return -ENXIO;
> >  
> > +	memset(&caps, 0, sizeof(caps));
> >  	retval = stream->ops->get_caps(stream, &caps);
> >  	if (retval)
> >  		goto out;
> > --
> 
> IMHO this should be done in get_caps() as it will manipulate the entries.
> or is there a special reason to have it here ?


There isn't a get_caps() function.  It's a pointer to many
functions.  It's safer to do it here where it can be audited
by static analisys.  It's cleaner to do it once instead of many
times.

regards,
dan carpenter
