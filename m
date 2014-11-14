From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v4] ALSA: ice1712: consider error value
Date: Fri, 14 Nov 2014 19:15:02 +0530
Message-ID: <20141114134502.GA16479@sudip-PC>
References: <1415968941-14181-1-git-send-email-sudipm.mukherjee@gmail.com>
 <s5h389lj4yg.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 59AE226051F
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 14:45:18 +0100 (CET)
Received: by mail-pa0-f50.google.com with SMTP id eu11so17406737pac.23
 for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2014 05:45:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <s5h389lj4yg.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 14, 2014 at 02:18:31PM +0100, Takashi Iwai wrote:
> At Fri, 14 Nov 2014 18:12:21 +0530,
> Sudip Mukherjee wrote:
> > 
> > earlier we were ignoring the return value of snd_ak4114_create and
> > always returning 0.
> > now we are returning the actual status. revo_init is calling this
> > function, and revo_init is checking the return value.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> > 
> > change in v3: spec->ak4114 is now dereferenced if we dont get an
> > error value from snd_ak4114_create.
> > 
> > change in v4: error value returned according to coding style.
> 
> Applied but I had to fix your From address (two others, too).  That
> doesn't match with your sign-off.  Please fix your git config to have
> a proper author address as same as sign-off.

i know it does not match. Previously Dan Carpenter also told me the same thing, and I sent a patch from my corporate account. You can find reference of that conversation here https://lkml.org/lkml/2014/9/3/473 

copying some part from there :
"I have given strict DMARC check for the corporate mail server. DMARC = domain based message authentication.
So the mail i sent reached all the list subscriber from a different server than our designated server,
and as a result it has been marked as spam in many places. I have already received a few complaints regarding that."

since i do use office resources for patches (though it is not part of my job), so i should atleast put Signed-off to the patches i send. You will see all my patches having different Signed-off and different from adderess.

again copying from the previous conversation:
"Is there any other way that i send the patch from my personal account, and use my corporate mail in Signed-off-by ... "

thanks
sudip

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> >  sound/pci/ice1712/revo.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
> > index 1112ec1..1d81ae6 100644
> > --- a/sound/pci/ice1712/revo.c
> > +++ b/sound/pci/ice1712/revo.c
> > @@ -494,11 +494,13 @@ static int ap192_ak4114_init(struct snd_ice1712 *ice)
> >  				 ap192_ak4114_write,
> >  				 ak4114_init_vals, ak4114_init_txcsb,
> >  				 ice, &spec->ak4114);
> > +	if (err < 0)
> > +		return err;
> >  	/* AK4114 in Revo cannot detect external rate correctly.
> >  	 * No reason to stop capture stream due to incorrect checks */
> >  	spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;
> >  
> > -	return 0; /* error ignored; it's no fatal error */
> > +	return 0;
> >  }
> >  
> >  static int revo_init(struct snd_ice1712 *ice)
> > -- 
> > 1.8.1.2
> > 
