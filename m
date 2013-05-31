From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Improving or replacing snd_printk()
Date: Fri, 31 May 2013 11:33:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1305311131450.1276-100000@iolanthe.rowland.org>
References: <s5hwqqf1an3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
 by alsa0.perex.cz (Postfix) with SMTP id C0421261785
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2013 17:33:47 +0200 (CEST)
In-Reply-To: <s5hwqqf1an3.wl%tiwai@suse.de>
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

> > struct snd_card contains pointers to two different devices: dev and 
> > card_dev.  Some contexts might want to use one of them for log messages 
> > while other contexts might want to use the other.
> 
> Yes, there are some corner cases, indeed.
> 
> Also, another expected problem is that neither card->card_dev nor
> card->dev are set when snd_card_err() is called.  Many drivers set the
> device pointers at the late stage just before the device
> registration.  So, systematic replacements won't work as expected in
> many cases.  (The same is applied for replacement with dev_*(), too.)

Given that the drivers would have to be edited to fix up the snd_printk 
calls, the device pointer assignments can be moved to an earlier stage 
at the same time.  But doing this would require understanding how the 
driver works to some extent; it couldn't be done blindly.

Alan Stern
