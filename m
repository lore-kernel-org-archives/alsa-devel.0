From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: ALSA: Soc_compress open file node allows more than
 once
Date: Mon, 27 Nov 2017 11:20:20 +0530
Message-ID: <20171127055019.GP3187@localhost>
References: <f469eb3a04f49f7b5603572546852685@codeaurora.org>
 <s5hmv3d3yfn.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 501DD266F52
 for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2017 06:46:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmv3d3yfn.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, b_lkasam@codeaurora.org, lkasam@qti.qualcomm.com, mangeshk@qti.qualcomm.com
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 23, 2017 at 02:41:00PM +0100, Takashi Iwai wrote:
> On Thu, 23 Nov 2017 14:18:30 +0100,
> b_lkasam@codeaurora.org wrote:
> > 
> > Hi ALSA team,
> > This is regarding compress offload framework file operations wrt open
> > system call.
> > 
> > For open call to this driver currently allows for same node more than
> > once.
> > 
> > This may result in memleak issues or data corruption if same node in
> > use by multiple instances.
> 
> This only depends on the driver side implementation.  There is no
> restriction in the core side, as the multiple open is possible
> depending on the hardware design and the driver implementation.

sounds right to me, also is the leak on core side or your driver?

> 
> > can we have restriction to avoid open of same node using some refcount?
> > 
> > we can either have refcount under compr->private_data and cross check
> > in below function before proceeding.
> > static int snd_compr_open(struct inode *inode, struct file *f)
> > 
> > Please suggest accordingly.
> 
> I'd suggest just to add an exclusive open check in the driver side.
> The open/close callbacks are protected via a mutex, so it can be a
> simple bool flag check.
> 
> If the exclusive access is regarded as a common pattern, we can add
> some flag to snd_compr later and check it in the core, instead, too.

-- 
~Vinod
