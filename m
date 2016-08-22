From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/2] ALSA: compress: Reduce the scope for
 two variables in snd_compr_set_params()
Date: Mon, 22 Aug 2016 10:31:56 +0530
Message-ID: <20160822050156.GD2890@localhost>
References: <566ABCD9.1060404@users.sourceforge.net>
 <7233eb00-a941-4935-dce2-7cb907272d41@users.sourceforge.net>
 <03eac1fe-ff33-1759-9c2a-7914f1c6de45@users.sourceforge.net>
 <alpine.DEB.2.10.1608211635480.3119@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D4136266726
 for <alsa-devel@alsa-project.org>; Mon, 22 Aug 2016 06:54:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1608211635480.3119@hadrien>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, SF Markus Elfring <elfring@users.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 21, 2016 at 04:36:22PM -0400, Julia Lawall wrote:
> 
> 
> On Sun, 21 Aug 2016, SF Markus Elfring wrote:
> 
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 21 Aug 2016 21:26:18 +0200
> >
> > Reduce the scope for the local variables to an if branch.
> >
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  sound/core/compress_offload.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index 583d407..b43aec5 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -545,14 +545,14 @@ static int snd_compress_check_input(struct snd_compr_params *params)
> >  static int
> >  snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
> >  {
> > -	struct snd_compr_params *params;
> > -	int retval;
> > -
> >  	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
> >  		/*
> >  		 * we should allow parameter change only when stream has been
> >  		 * opened not in other cases
> >  		 */
> > +		int retval;
> > +		struct snd_compr_params *params;
> 
> I don't like this at all.  Local variables should be at the top of the
> function, not hiding under 4 lines of comments in the middle of the code.

I agree with you this, it doesn't help IMO as well

-- 
~Vinod
