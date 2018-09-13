From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v2] ALSA: hda - Enable runtime PM only for
	discrete GPU
Date: Thu, 13 Sep 2018 15:58:13 +0200
Message-ID: <20180913135813.uselatnu7jwfftrb@wunner.de>
References: <20180913065659.30526-1-tiwai@suse.de>
 <CAPpJ_edx4susnrpC3dLLqhXfX5Ddr4gtGfmdhB-yzxuUcLCV4g@mail.gmail.com>
 <s5h4let5xlj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net
 [176.9.242.62]) by alsa0.perex.cz (Postfix) with ESMTP id A1DAD2673F4
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2018 15:58:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4let5xlj.wl-tiwai@suse.de>
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
Cc: alexander.deucher@amd.com, Jian-Hong Pan <jian-hong@endlessm.com>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 13, 2018 at 03:35:36PM +0200, Takashi Iwai wrote:
> On Thu, 13 Sep 2018 15:27:16 +0200, Jian-Hong Pan wrote:
> > 2018-09-13 14:56 GMT+08:00 Takashi Iwai <tiwai@suse.de>:
> > > The recent change of vga_switcheroo allowed the runtime PM for
> > > HD-audio on AMD GPUs, but this also resulted in a regression.  When
> > > the HD-audio controller driver gets runtime-suspended, HD-audio link
> > > is turned off, and the hotplug notification is ignored.  This leads to
> > > the inconsistent audio state (the connection isn't notified and ELD is
> > > ignored).
> > >
> > > The best fix would be to implement the proper ELD notification via the
> > > audio component, but it's still not ready.  As a quick workaround,
> > > this patch adds the check of runtime_idle and allows the runtime
> > > suspend only when the vga_switcheroo is bound with discrete GPU.
> > > That is, a system with a single GPU and APU would be again without
> > > runtime PM to keep the HD-audio link for the hotplug notification and
> > > ELD read out.
> > >
> > > Also, the codec->auto_runtime_pm flag is set only for the discrete GPU
> > > at the time GPU gets bound via vga_switcheroo (i.e. only dGPU is
> > > forcibly runtime-PM enabled), so that APU can still get the ELD
> > > notification.
> > >
> > > For identifying which GPU is bound, a new vga_switcheroo client
> > > callback, gpu_bound, is implemented.  The vga_switcheroo simply calls
> > > this when GPU is bound, and tells whether it's dGPU or APU.
> > 
> > Tested-by: Jian-Hong Pan <jian-hong@endlessm.com>
> 
> Thanks.  I should put you also as the original reporter.
> 
> Lukas, could you check the vga_switcheroo change whether it's
> acceptable?

I looked over it this morning and didn't get every little detail,
e.g. why chip->running = 0 in azx_free() (seems like an unrelated
change, but I'm not sure).  But I do understand the idea underlying
the patch and it LGTM.  It's somewhat regrettable that we have to
make things more complicated again to properly differentiate between
integrated and discrete GPUs.  I wish we could later on come up with
a scheme that is lightweight and easy to follow.  Obviously, such a
scheme will likely not be eligible as a fix for 4.19.  Anyway,

Acked-by: Lukas Wunner <lukas@wunner.de>

and thanks a lot for looking into it.  Please cc dri-devel for
vga_switcheroo-related patches in the future (now added, + Alex,
links for context:
https://patchwork.kernel.org/patch/10598735/
https://bugzilla.kernel.org/show_bug.cgi?id=200945 ).

Lukas
