From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] amixer: add support for TLV byte control
	read
Date: Wed, 27 Jan 2016 23:17:52 +0530
Message-ID: <20160127174749.GB11130@localhost>
References: <1453441612-29902-1-git-send-email-vinod.koul@intel.com>
 <s5hoace5e75.wl-tiwai@suse.de> <20160122074623.GC11130@localhost>
 <s5hfuxq593q.wl-tiwai@suse.de> <20160122095648.GD11130@localhost>
 <s5hegd9sxb3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A7C026044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 18:44:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hegd9sxb3.wl-tiwai@suse.de>
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

On Fri, Jan 22, 2016 at 11:50:08AM +0100, Takashi Iwai wrote:
> On Fri, 22 Jan 2016 10:56:48 +0100,
> Vinod Koul wrote:
> > > Hm, it has a check
> > > 
> > > static int snd_ctl_hw_elem_tlv(snd_ctl_t *handle, int op_flag,
> > > 			       unsigned int numid,
> > > 			       unsigned int *tlv, unsigned int tlv_size)
> > > {
> > > 	....
> > > 		if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size) {
> > > 			free(xtlv);
> > > 			return -EFAULT;
> > > 		}
> > > 		memcpy(tlv, xtlv->tlv, xtlv->tlv[1] + 2 * sizeof(unsigned int));
> > > 
> > > Do you mean somewhere here triggers a crash?
> > 
> > Yes while it tried to memcpy, in my case 30K sized data to 4K buffer, so I
> > allocated right one and got all the data
> 
> But it has the size check before memcpy()?

Okay I had some issues (yet again) so I rebuilt the ubuntu packages and tools and reran
this.

I get:

$ amixer -c0 cget numid=16
numid=16,iface=MIXER,name='mdl params'
  ; type=BYTES,access=-----RW-,values=30336
amixer: Control hw:0 element TLV read error: Bad address

Segmentation fault (core dumped)

And the alsa-lib returns an err and we try to free up tlv on error which
should be fine here but fails

Why should free cause a failure here (on 1.0.27)

On latest lib from git. I get same failure but in alsa-lib when it tries to
free xtlv on failure of this check

if (xtlv->tlv[1] + 2 * sizeof(unsigned int) > tlv_size) {
                   free(xtlv);

Why would that happen...? What am I missing :(

Also on second thought, even after working around this by setting right size
so that we don't hit failures (this patch), I get my screen spammed by 30K byes so based
on TLV access and bytes type I am thinking to not read and display on cget.

We should add new options for these controls ..

-- 
~Vinod
