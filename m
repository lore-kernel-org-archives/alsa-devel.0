From: James Cameron <quozl@laptop.org>
Subject: Re: [PATCH BAT V1 0/7] BAT: Add Basic Audio Tester
 command line tool
Date: Fri, 18 Sep 2015 09:00:25 +1000
Message-ID: <20150917230025.GB16504@us.netrek.org>
References: <cover.1442298607.git.han.lu@intel.com>
 <CAG5mAdwkSn4975waeUrpp6Bm5yBk2217Oa6+gQH-=toLu7OMxQ@mail.gmail.com>
 <1442403626.10528.50.camel@loki>
 <CAG5mAdzt-zYX7mp5Nhnmdr_874KhtoRdBMXSmG1JkMvTTB54rA@mail.gmail.com>
 <1442486431.2520.34.camel@loki>
 <CAG5mAdw1jjVGeTi2k0QLCTVv+Qr-Hy3UMZLuT1M=f2uHje32kw@mail.gmail.com>
 <20150917174242.GF12027@sirena.org.uk>
 <CAG5mAdziq11SJ3eAqDFcTEBuHJ-Rj6xwgu3kmqXC5HYOnDvYaA@mail.gmail.com>
 <CAG5mAdx+KSMfOjK2y+KKzkVjHb6HHE_W=Y_AuXE9kuom=_2Cww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E163264F19
 for <alsa-devel@alsa-project.org>; Fri, 18 Sep 2015 01:00:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAG5mAdx+KSMfOjK2y+KKzkVjHb6HHE_W=Y_AuXE9kuom=_2Cww@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: bernard.gautier@intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, han.lu@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 17, 2015 at 03:40:33PM -0700, Caleb Crome wrote:
> The more I think of this channel synchronization issue, the
> thorinier it gets.
> 
> Basically, with the TLV320AIC series of codecs, whenever any of the
> DAC or ADC channels are powered up on any codec, the MCLK needs to be
> stopped, all DACs/ADCs turned off, then configuration can happen, then
> all DACs/ADCs can be turned back on, then MCLK starts again.  That's
> the only way to ensure phase/delay accuracy among several codecs.
> 
> So, going from play-only to play+record requires MCLK be stopped, then
> restarted.

Aye.  Lots of clocks in lots of domains.  Also pay penalty of any
delays needed to stabilise ADCs.

Same general issue with many single codecs though, if capture vs
playback synchronisation required.

> Maybe it's not too terrible.  Any thoughts?

In this scenario my preference would be to always configure the codecs
and DMA for playback and capture, and do any gating higher in the
stack; e.g. send zero samples if there is no playback stream, and
discard samples if there is no capture stream.

-- 
James Cameron
http://quozl.linux.org.au/
