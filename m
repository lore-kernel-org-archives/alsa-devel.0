From: Thomas Klausner <tk@giga.or.at>
Subject: Re: byteswap.h
Date: Thu, 3 Mar 2016 12:39:21 +0100
Message-ID: <20160303113921.GK8492@danbala.tuwien.ac.at>
References: <20160303095041.GG8492@danbala.tuwien.ac.at>
 <s5hwppjriol.wl-tiwai@suse.de> <s5hvb53rimi.wl-tiwai@suse.de>
 <20160303095852.GH8492@danbala.tuwien.ac.at>
 <s5hsi07ribw.wl-tiwai@suse.de>
 <20160303101005.GI8492@danbala.tuwien.ac.at>
 <s5hpovbrhf2.wl-tiwai@suse.de>
 <20160303111840.GJ8492@danbala.tuwien.ac.at>
 <sfid-H20160303-123736-+044.60-1@spamfilter.osbf.lua>
 <s5hsi076bd6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id 489C02657ED
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 12:39:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsi076bd6.wl-tiwai@suse.de>
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

On Thu, Mar 03, 2016 at 12:37:25PM +0100, Takashi Iwai wrote:
> On Thu, 03 Mar 2016 12:18:40 +0100,
> Thomas Klausner wrote:
> > 
> > On Thu, Mar 03, 2016 at 11:21:05AM +0100, Takashi Iwai wrote:
> > > On Thu, 03 Mar 2016 11:10:05 +0100,
> > > Thomas Klausner wrote:
> > > > 
> > > > On Thu, Mar 03, 2016 at 11:01:23AM +0100, Takashi Iwai wrote:
> > > > > Applied now.  Thanks.
> > > > 
> > > > Thank you!
> > > > 
> > > > Next big issue: Many places include byteswap.h to get bswap_16,
> > > > bswap_32, bswap_64.
> > > > 
> > > > This header does not exist on *BSD or Solaris.
> > > > 
> > > > However, all of these provide similar macros under different names,
> > > > from different header files (bswap16 etc, or BSWAP_16).
> > > > 
> > > > Do you want a compat header, e.g. include/bswap.h that takes care of
> > > > this and is included by local.h, or do you prefer a different
> > > > solution?
> > > 
> > > bswap.h looks better ATM.  Let's see.
> > 
> > Ok, here's my try for a version of bswap.h. Does it look ok?
> 
> Looks good to me -- supposing you tested it actually :)

This particular patch was only compile-tested on NetBSD, but a quite
similar ifdef has been in pkgsrc for years and has survived a number
of bulk builds over the years.
 Thomas
