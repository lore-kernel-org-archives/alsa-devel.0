From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Improving or replacing snd_printk()
Date: Fri, 31 May 2013 10:24:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305311014330.1276-100000@iolanthe.rowland.org>
References: <s5ha9nbinre.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id 2CFFF2654CB
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 16:24:53 +0200 (CEST)
In-Reply-To: <s5ha9nbinre.wl%tiwai@suse.de>
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
Cc: Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 31 May 2013, Takashi Iwai wrote:

> > I don't see the complexity/hell in adding functions
> > for specific types of struct * to reduce the complexity
> > of the code though.  Centralizing those indirections
> > into functions also generally reduces overall code size.
> 
> I don't mind to add the struct pointer to new snd_*() -- if we really
> introduce them.  The bigger question is whether we really need to
> introduce such, and if yes, what variants.  And for that, I don't
> think we need to add many functions.  Maybe snd_card_<level>() would
> be good.  But others don't seem to make sense to me (remember that I
> suggest dropping CONFIG_SND_VERBOSE_PRINTK).

struct snd_card contains pointers to two different devices: dev and 
card_dev.  Some contexts might want to use one of them for log messages 
while other contexts might want to use the other.

I guess defining snd_card_*() to use card->card_dev makes the most 
sense.  If some code wants to use card->dev instead, it can pass that 
as the first argument to dev_*().

The most commonly used levels seem to be err, warn, info, and dbg.  
Those ought to be enough.  In fact, you probably could getting along 
without warn -- just err, info, and dbg.

Alan Stern
