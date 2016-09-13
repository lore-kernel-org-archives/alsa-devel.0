From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Tue, 13 Sep 2016 09:39:21 +0100
Message-ID: <20160913083921.GL21682@localhost.localdomain>
References: <2450af02-a554-6374-d92f-d4d0666c7138@sakamocchi.jp>
 <20160903113816.GH21682@localhost.localdomain>
 <2ba13afd-433f-8db3-b535-879155be0c47@sakamocchi.jp>
 <s5hk2ercs2c.wl-tiwai@suse.de>
 <2cf64652-2ba2-64a4-b6a4-ce9957a5f0ab@sakamocchi.jp>
 <20160912123737.GJ21682@localhost.localdomain>
 <20160912152531.GE9355@localhost> <s5htwdlgmrp.wl-tiwai@suse.de>
 <20160912160316.GK21682@localhost.localdomain>
 <s5hbmztaxpz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FD73266966
 for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2016 10:39:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbmztaxpz.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Clemens Ladisch <clemens@ladisch.de>, broonie@linaro.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2016 at 06:28:56PM +0200, Takashi Iwai wrote:
> On Mon, 12 Sep 2016 18:03:16 +0200,
> Charles Keepax wrote:
> > 
> > On Mon, Sep 12, 2016 at 05:28:58PM +0200, Takashi Iwai wrote:
> > > On Mon, 12 Sep 2016 17:25:31 +0200,
> > > Vinod Koul wrote:
> > > > 
> > > > On Mon, Sep 12, 2016 at 01:37:37PM +0100, Charles Keepax wrote:
> > > > > On Tue, Sep 06, 2016 at 12:30:35PM +0900, Takashi Sakamoto wrote:
> > > Also, still another point is to be decided: is passing an arbitrary
> > > size via info callback for an element without read/write access bits
> > > (but with TLV bit) a right behavior?
> > > 
> > 
> > So I guess the question would be if you couldn't read the
> > controls size from info how would you find out the control size?
> 
> Well, I'm not against the idea to expose the size in callback.  The
> behavior without read/write bits is just undefined, and we need a
> clear definition to avoid further confusion.  I guess the introduction
> of a new flag would be the start.

The trouble with that is you have to do a read/write to find out
the size you need to read or write though. So you end up doing
weird stuff like a dummy zero length read or something, which
feels a bit icky.

One other thing to consider is that if we add the new flag it
might be nice to allow normal read/write operations on the
controls as well (only accessing the first 512 bytes of the
control). Certainly for the ADSP control I would have
liked to have done this to preserve better backwards
compatibility with older user-spaces.

Thanks,
Charles
