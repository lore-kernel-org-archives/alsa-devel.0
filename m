From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 2/3] ucm: add a FIXME comment
Date: Wed, 11 Feb 2015 16:16:11 +0000
Message-ID: <1423671371.7654.27.camel@loki>
References: <1423600954-8751-1-git-send-email-tanu.kaskinen@linux.intel.com>
 <1423600954-8751-3-git-send-email-tanu.kaskinen@linux.intel.com>
 <s5hbnl0ptin.wl-tiwai@suse.de>
 <1423655080.2747.3.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5h1tlwppoo.wl-tiwai@suse.de>
 <1423661646.2747.5.camel@tkkaskin-mobl3.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C8D112605DC
 for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2015 17:16:48 +0100 (CET)
In-Reply-To: <1423661646.2747.5.camel@tkkaskin-mobl3.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2015-02-11 at 15:34 +0200, Tanu Kaskinen wrote:
> On Wed, 2015-02-11 at 14:01 +0100, Takashi Iwai wrote:
> > At Wed, 11 Feb 2015 13:44:40 +0200,
> > Tanu Kaskinen wrote:
> > > 
> > > On Wed, 2015-02-11 at 12:38 +0100, Takashi Iwai wrote:
> > > > At Tue, 10 Feb 2015 22:42:33 +0200,
> > > > Tanu Kaskinen wrote:
> > > > > 
> > > > > I'm pretty sure the current code will crash with some inputs, but I
> > > > > don't know what the original author intended this code to do, so I
> > > > > don't know how to fix it.
> > > > > ---
> > > > >  src/ucm/main.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/src/ucm/main.c b/src/ucm/main.c
> > > > > index 3924aee..62bc374 100644
> > > > > --- a/src/ucm/main.c
> > > > > +++ b/src/ucm/main.c
> > > > > @@ -317,6 +317,14 @@ static int execute_sequence(snd_use_case_mgr_t *uc_mgr,
> > > > >  					uc_error("cdev is not defined!");
> > > > >  					return err;
> > > > >  				}
> > > > > +                                /* FIXME: If cdev1 is NULL and cdev2 is not,
> > > > > +                                 * then set cdev to cdev1... makes no sense!
> > > > > +                                 * Also, what if both cdev1 and cdev2 are NULL?
> > > > > +                                 * What should happen? Later in this function we
> > > > > +                                 * call open_ctl(), which assumes non-NULL cdev,
> > > > > +                                 * so leaving cdev to NULL here is not an
> > > > > +                                 * option (or at least cdev has to be checked
> > > > > +                                 * before calling open_ctl()). */
> > > > >  				if (cdev1 == NULL || cdev2 == NULL ||
> > > > >                                      strcmp(cdev1, cdev2) == 0) {
> > > > >  					cdev = (char *)cdev1;
> > > > 
> > > > Ouch, the code is really buggy there.  We must fix it instead of
> > > > leaving FIXME.
> > > > 
> > > > I see there are multiple bugs (in addition to your patch#1):
> > > > 
> > > > - the error check is wrong, it should be compared with -ENOENT
> > > > 	if (err < 0 && err != ENOENT)
> > > > 
> > > >   This leaves cdev1 or cdev2 NULL as non-error.
> > > > 
> > > > - The intention of the code should be (as far as I understand):
> > > >   - if only one of cdev1 and cdev2 is defined, take it as cdev
> > > >   - if cdev1 and cdev2 are defined and have the same string, keep
> > > >     cdev1 and free cdev2
> > > >   - in the rest cases, free both cdev1 and cdev2 without changing cdev
> > > 
> > > Regarding that last case, just leaving cdev unchanged is not a good
> > > idea. cdev will always be NULL if we don't set it here, and when we call
> > > open_ctl(), it must be non-NULL.
> > 
> > Right.  I *guess* if cdev1 != cdev2, it should bail out as an error.
> 
> Ok, I'll make a patch that will implement the described behaviour.
> 

It may also be worth adding a comment describing the cdev1/2 usage or
maybe even rename them to make it obvious ?

Thanks

Liam
