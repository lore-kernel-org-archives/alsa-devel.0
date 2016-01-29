From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] amixer: add support for TLV byte control
 read
Date: Fri, 29 Jan 2016 16:43:47 +0530
Message-ID: <20160129111347.GT11130@localhost>
References: <s5hfuxq593q.wl-tiwai@suse.de> <20160122095648.GD11130@localhost>
 <s5hegd9sxb3.wl-tiwai@suse.de> <20160127174749.GB11130@localhost>
 <s5h7fiuoo2r.wl-tiwai@suse.de> <20160128042509.GC11130@localhost>
 <s5hzivqmewz.wl-tiwai@suse.de> <20160128092644.GJ11130@localhost>
 <s5hy4b965iu.wl-tiwai@suse.de> <20160129065106.GS11130@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DE71D26047B
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 12:09:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20160129065106.GS11130@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 29, 2016 at 12:21:06PM +0530, Vinod Koul wrote:
> On Thu, Jan 28, 2016 at 05:19:21PM +0100, Takashi Iwai wrote:
> > The line number doesn't match with the latest code in git, so
> > double-check that the problem happens with the latest alsa-lib and
> > alsa-utils, too.
> 
> I am on debian packages 1.0.27
> 
> > I'm thinking whether this is rather an issue in the kernel driver
> > side.  In skl_tplg_tlv_control_get(),
> 
> I think you are right, the buffer would overflow which would cause heap to
> go bad and free goes crashing
> 
> > 
> > 	if (bc->params) {
> > 		if (copy_to_user(data, &bc->param_id, sizeof(u32)))
> > 			return -EFAULT;
> > 		if (copy_to_user(data + 1, &size, sizeof(u32)))
> > 			return -EFAULT;
> > 		if (copy_to_user(data + 2, bc->params, size))
> > 			return -EFAULT;
> > 	}
> > 
> > But here, size is the size of the whole container, not the size in the
> > container.  In the code above, you're copying size+8 bytes total and
> > this breaks the boundary already.
> 
> Right, also I think we need to check for size vs size of parameters. We
> don't want to copy kernel memory to usermode if usermode gave a larger
> buffer
> 
> Let me test this, thanks for pointing

And you were right :)

with this change it works and dumps 4K bytes on my screen

@@ -913,6 +913,13 @@ static int skl_tplg_tlv_control_get(struct snd_kcontrol
*kcontrol,
                skl_get_module_params(skl->skl_sst, (u32 *)bc->params,
                                      bc->max, bc->param_id, mconfig);

+       /* decrement size for TLV header */
+       size -= 2 * sizeof(u32);
+
+       /* check size as we don't want to send kernel data */
+       if (size > bc->max)
+               size = bc->max;
+
        if (bc->params) {
                if (copy_to_user(data, &bc->param_id, sizeof(u32)))
                        return -EFAULT;

Thanks
-- 
~Vinod
