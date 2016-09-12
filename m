From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Mon, 12 Sep 2016 17:03:16 +0100
Message-ID: <20160912160316.GK21682@localhost.localdomain>
References: <47fa0f7b-cf3a-b3dd-7e7e-7d45369ddaac@sakamocchi.jp>
 <s5ha8fteyle.wl-tiwai@suse.de>
 <2450af02-a554-6374-d92f-d4d0666c7138@sakamocchi.jp>
 <20160903113816.GH21682@localhost.localdomain>
 <2ba13afd-433f-8db3-b535-879155be0c47@sakamocchi.jp>
 <s5hk2ercs2c.wl-tiwai@suse.de>
 <2cf64652-2ba2-64a4-b6a4-ce9957a5f0ab@sakamocchi.jp>
 <20160912123737.GJ21682@localhost.localdomain>
 <20160912152531.GE9355@localhost> <s5htwdlgmrp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 828BF266D5E
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 18:03:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htwdlgmrp.wl-tiwai@suse.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@linaro.org, Clemens Ladisch <clemens@ladisch.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 12, 2016 at 05:28:58PM +0200, Takashi Iwai wrote:
> On Mon, 12 Sep 2016 17:25:31 +0200,
> Vinod Koul wrote:
> > 
> > On Mon, Sep 12, 2016 at 01:37:37PM +0100, Charles Keepax wrote:
> > > On Tue, Sep 06, 2016 at 12:30:35PM +0900, Takashi Sakamoto wrote:
> > > > On Sep 5 2016 05:45, Takashi Iwai wrote:
> > 
> > Sorry havent been able to follow this yet :(
> > 
> > 
> > But yes current Skylake Chromebooks ship with this code so we cant break it.
> > 
> > I am not sure what is the issue with API though. (sorry haven't read the
> > thread yet). The tlv was designed to allow people send bytes larger than 512
> > down to kernel. The Type cna be anything (implementation specific, though we
> > haven't used it yet), length the blob length and then the bytes blob.
> 
> Yes, and this part is missing in wm_adsp driver.  It passes the blob
> without TLV encoding, i.e. starting from the offset zero without type
> and length encoding.
> 
> > We provide a tunnel and pass these to DSP. They maybe module coefficients,
> > hotwording blobs etc.
> 
> So, does Intel driver pass the blob in TLV format?  Then we have two
> different implementations.
> 

So looking at the Skylake code it does look like certainly the
read opertaion returns a TLV header, its a bit less clear with
the write operation it looks like it does use one but sometimes
it will be passed straight through to the firmware.

So looks more like we really should take the pain of the ABI
change and update wm_adsp to be consistent, two implementations
is not good. Although I do feel we should add/strip the header in
ASoC rather than expecting the driver callbacks to do so, seems
odd to push that requirement into end drivers, it has certainly
taken me by surpise. Also I guess with the current tinyalsa
implementation the end user has to add/strip the headers whereas
really I would have thought tinyalsa should be doing that.

> Also, still another point is to be decided: is passing an arbitrary
> size via info callback for an element without read/write access bits
> (but with TLV bit) a right behavior?
> 

So I guess the question would be if you couldn't read the
controls size from info how would you find out the control size?

Thanks,
Charles
