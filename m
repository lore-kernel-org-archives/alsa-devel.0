From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ALSA: get rid of CONFIG_SND_VERBOSE_PRINTK
Date: Fri, 07 Jun 2013 09:10:11 -0700
Message-ID: <1370621411.2209.102.camel@joe-AO722>
References: <Pine.LNX.4.44L0.1306071035130.1366-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 144612610B7
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2013 18:10:13 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.44L0.1306071035130.1366-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2013-06-07 at 10:40 -0400, Alan Stern wrote:
> On Thu, 6 Jun 2013, Joe Perches wrote:
> > > How useful really is it to be able to limit the amount of debugging
> > > messages at runtime?  Does anybody ever actually adjust the "debug"  
> > > module parameter?
> > When it's a bitmask, yes.
> > It then becomes similar to ethtool.
> But it isn't a bitmask; it's just a level.

I understood that from the beginning and was
describing generically the different approaches
used in the kernel.

I was simply suggesting sound use classification
via bitmask instead of level.
