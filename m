From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Tue, 04 Jun 2013 23:15:21 -0700
Message-ID: <1370412921.2385.111.camel@joe-AO722>
References: <1370375134.2385.64.camel@joe-AO722>
 <Pine.LNX.4.44L0.1306041646240.1093-100000@iolanthe.rowland.org>
 <s5hobblrt2s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 2DD032652C4
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:15:22 +0200 (CEST)
In-Reply-To: <s5hobblrt2s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-06-05 at 08:04 +0200, Takashi Iwai wrote:
> At Tue, 4 Jun 2013 16:54:12 -0400 (EDT), Alan Stern wrote:
> > On Tue, 4 Jun 2013, Joe Perches wrote:
[]
> > You didn't respond to the first point I raised.  Since these messages
> > are all meant for debugging, there's no point allowing them to have
> > prefixes like KERN_ERR or KERN_INFO.  They should always be printed at
> > the KERN_DEBUG level.  Or did you think this was so obviously true that
> > it didn't require any comment?
> 
> Unfortunately, it's not so straightforward.  Many messages are better
> with KERN_INFO indeed.  In such places, snd_printd() is used rather as
> snd_chattier_printk_with_prefix().

In those cases, it's likely true that most of those
should not be snd_printd but promoted to pr_<level>

> Instead, we tended to put such informational messages as snd_printd(),
> while keeping the driver itself reticent as much as possible for
> "productive" systems.  This style was kept for a while even after
> merged to 2.5 kernels until recently.
>
> Also, some places use KERN_WARNING or KERN_ERR with snd_printd(),
> mostly because they are in the context with CONFIG_SND_DEBUG.
> They can be well pr_warning() or pr_err().

I thought the idea was to rationalize all that with
the new printing styles.  So on the whole, it seems
we are agreeing strongly.
