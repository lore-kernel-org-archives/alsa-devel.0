From: Nick Simonov <nicksimonovv@gmail.com>
Subject: Re: [PATCH v2] ALSA: xen-front: Refine indentations and constify
 snd_pcm_ops
Date: Fri, 21 Sep 2018 12:21:35 +0300
Message-ID: <20180921092135.GA20633@kbp1-dhp-f54120>
References: <20180921054514.GA11771@nick>
 <s5ha7obuyuw.wl-tiwai@suse.de>
Reply-To: s5ha7obuyuw.wl-tiwai@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5ha7obuyuw.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: oleksandr_andrushchenko@epam.com, alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 21, 2018 at 08:51:51AM +0200, Takashi Iwai wrote:
> On Fri, 21 Sep 2018 07:47:38 +0200,
> Nick Simonov wrote:
> > 
> > snd_pcm_ops are not supposed to change. So mark the
> > non-const structs as const. Also, refine indentation
> > to increase readability.
> > 
> > Signed-off-by: Nick Simonov <nicksimonovv@gmail.com>
> > ---
> > Changes v2:
> > - Fix typo in commit description, ncrease to increase.
> 
> Since I already merged your first version, please resubmit as an
> incremental patch.  At best, check the latest linux-next or my
> sound.git tree for-next branch, and create a patch on its top.
> 
> 
> thanks,
> 
> Takashi

Sorry I want to clarify, there is no mistakes in the code itself
there is a typo in commit message. As I now there is no way to change
commit message without rebase after merge, so which is the proper way in
this case? leave it as is?

Thanks,

Nick
