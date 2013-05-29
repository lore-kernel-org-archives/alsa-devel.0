From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/3] lx6464es: use %*phN to print small
 buffer in hex form
Date: Wed, 29 May 2013 14:29:24 +0300
Message-ID: <1369826964.29283.235.camel@smile>
References: <1369821802-2308-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1369821802-2308-3-git-send-email-andriy.shevchenko@linux.intel.com>
 <s5hd2sa6qgu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 14CC3261A49
 for <alsa-devel@alsa-project.org>; Wed, 29 May 2013 13:29:52 +0200 (CEST)
In-Reply-To: <s5hd2sa6qgu.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-05-29 at 12:16 +0200, Takashi Iwai wrote: 
> >  	strcpy(card->driver, "LX6464ES");
> > -	sprintf(card->id, "LX6464ES_%02X%02X%02X",
> > -		chip->mac_address[3], chip->mac_address[4], chip->mac_address[5]);
> > +	sprintf(card->id, "LX6464ES_%3phN", chip->mac_address + 3);
> 
> The same problem as my previous comment.  The case incompatible.

Here is card->id, which might be used by userspace in defined form.
I rather agree with your objection here.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
