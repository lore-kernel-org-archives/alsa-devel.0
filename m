From: Ismael Luceno <ismael@iodev.co.uk>
Subject: Re: [PATCH] pcm: Fix shm initialization race-condition
Date: Mon, 22 Aug 2016 12:02:41 -0300
Message-ID: <20160822150240.w6sylh4nedsa4l4p@pirotess.bf.iodev.co.uk>
References: <20160814002852.4013-1-ismael@iodev.co.uk>
 <s5ha8g5gnn8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iodev.co.uk (iodev.co.uk [82.211.30.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 23C07266EC9
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 17:02:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5ha8g5gnn8.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 22/Ago/2016 11:26, Takashi Iwai wrote:
> On Sun, 14 Aug 2016 02:28:52 +0200,
> Ismael Luceno wrote:
> > 
> > Easily seen when two threads try at the same time, one of them will fail.
> > 
> > The bug was identified by using apulse with Skype.
> > 
> > Fixes: dec428c35221 ("pcm: fix 'unable to create IPC shm instance' caused by fork from a thread")
> > Fixes: https://github.com/i-rinat/apulse/issues/38
> > Signed-off-by: Ismael Luceno <ismael@iodev.co.uk>
> > ---
> >  src/pcm/pcm_direct.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
> > index c3925cc20fd3..b5215ba35406 100644
> > --- a/src/pcm/pcm_direct.c
> > +++ b/src/pcm/pcm_direct.c
> > @@ -101,6 +101,8 @@ retryget:
> >  		if ((dmix->shmid = shmget(dmix->ipc_key, sizeof(snd_pcm_direct_share_t),
> >  					     IPC_CREAT | IPC_EXCL | dmix->ipc_perm)) != -1)
> >  			first_instance = 1;
> > +		if (dmix->shmid < 0 && errno == EEXIST)
> > +			goto retryget;
> 
> Hrm, but this would result in an endless loop if the shm was already
> taken persistently.

If so, shouldn't the first call to shmget succeed?

To me it seems very unlikely that both calls continuosly fail.

> Also, which call does give a negative shmid, actually?  It's from the
> first shmget() or the second shmget()?

What happens is that both threads go down that path but, of course,
only one succeeds in the second shmget call.
