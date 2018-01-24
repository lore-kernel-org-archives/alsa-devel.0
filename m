From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: compress: Correct handling of
 compressed ops
Date: Wed, 24 Jan 2018 14:49:15 +0000
Message-ID: <20180124144915.p5fo2pypnawqbj66@localhost.localdomain>
References: <20180124135525.5633-1-ckeepax@opensource.cirrus.com>
 <20180124142901.GG18649@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id E4849266C0E
 for <alsa-devel@alsa-project.org>; Wed, 24 Jan 2018 15:49:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180124142901.GG18649@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, dan.carpenter@oracle.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 24, 2018 at 07:59:01PM +0530, Vinod Koul wrote:
> On Wed, Jan 24, 2018 at 01:55:24PM +0000, Charles Keepax wrote:
> > The soc_compr_copy callback is currently broken. Since the
> > changes to move the compr_ops over to the component the return
> > value is not correctly propagated, always returning zero on
> > success rather than the number of bytes copied. This causes
> > user-space to stall continuously reading as it does not believe
> > it has received any data.
> > 
> > Furthermore, the changes to move the compr_ops over to the
> > component iterate through the list of components and will
> > call the compressed operation for any that have compressed
> > ops. However, there would be signifcantly more work required
> > to support such a system. There isn't currently any sensible
> > mechanism to forward the ops to multiple components. For example
> > what should be done about merging data from copy?  Or what should
> > be returned through the pointer call, each component may have
> > different amounts of data available, but user-space expects a
> > single answer?
> > 
> > As such clean up the code a little by factoring out the search
> > for the relevant component and bring things back to looking for
> > a single component that supports compressed ops on a single
> > runtime. These refactorings also put back the original handling
> > for the copy callback, correcting the return value.
> 
> Thank you Charles for spotting this and fixing it. The changes look good to
> me. But should we split the copy fix from rest of the handling and backport
> that one to stable?
> 
> > 
> > Fixes: 9e7e3738ab0e ("ASoC: snd_soc_component_driver has snd_compr_ops")

The offending change here is only in the v4.15-rc's so if we can
get the change in before 4.16 there shouldn't be any need to send
anything to stable.

I had thought about splitting this into two changes but the fix
to the copy stuff becomes a little odd since you end up with the
copy callback returning as soon as it hits a viable compressed
ops but all the other callbacks keep running. Or you could fix up
all the callbacks but then it starts to feel like you might as
well apply this patch. Where I got to was really the primary bug
here is that the code would try to call multiple callbacks it
just so happens that the only thing that manifests is the copy
return on my system.

That said if others are keen for me to split it as well I don't
mind doing so.

Thanks,
Charles
