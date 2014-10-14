From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Direct Stream Digital (DSD/DST,
 One Bit Audio) HDMI pass-trough
Date: Tue, 14 Oct 2014 09:43:42 -0500
Message-ID: <543D369E.5020002@linux.intel.com>
References: <CAGzU1+H-vof2_1UqDTr2pDrnLMrbk0ZHgaAxeM2CaW9=tcPXwQ@mail.gmail.com>	<543C58AC.9000701@linux.intel.com>
 <CAGzU1+G8rpLokMRbcG4o+SaDB2j79Gx83e6j+3JiMxS3nwVhFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D87C2606AD
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 16:43:48 +0200 (CEST)
In-Reply-To: <CAGzU1+G8rpLokMRbcG4o+SaDB2j79Gx83e6j+3JiMxS3nwVhFQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrej Falout <andrej@falout.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/13/14, 7:49 PM, Andrej Falout wrote:
> On Tue, Oct 14, 2014 at 11:56 AM, Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com
> <mailto:pierre-louis.bossart@linux.intel.com>> wrote:
>
>     On 10/11/14, 1:33 AM, Andrej Falout wrote:
>
>         Hello,
>         <...snip...>
>              5. Note that as far as I know, no proprietary drivers on
>         Windows
>              (ATI/AMD, Nvidia, Intel) support this; It will be the first
>         time a device
>              that is not a SACD player outputs DSD over HDMI, on any OS.
>         I am assuming
>              that this has nothing to do with hardware limitations of
>         the HDMI chips
>              used for video outputs (I could not find any reference for
>         such assumption
>              in any HDMI chips I examined specs for). Therefore, I
>         assume that
>              implementing this has no hardware prerequisites.
>
>
>     HDMI controllers typically don't support DSD in the PC space. It'd
>     be easier to convert to high-res PCM (HBR).
>
>
> Hello Pierre-Louis,
>
> Thank you for your comment.
>
> What are you basing your assessment that "HDMI controllers typically
> don't support DSD in the PC space"? I looked, but could not find any
> evidence for this.

I am basing my judgement on first-hand experience with silicon.

> Certainly, DSD is not a part of HDMI hardware implementation (such as
> for example, CEC). From all info I have, DSD is simply multiplexed into
> HDMI data stream, just as DST-HD or AC3 is.

This multiplexing is typically not implemented - mainly because this 
isn't a format used outside of niche markets and there was no real 
format to convey DSD over PCM frames until the DOP format was created in 
2012. DTS-HD and AC3 use a PCM format which is rather straightforward to 
implement but there's quite a few cases where these modes have been 
dropped. HDMI only requires 48kHz 2ch really.
Note that the facts don't mean any negative judgement on quality, i was 
at AES this week-end where I heard outstanding DSD/DXD recordings. You 
will have more luck with a USB DAC, there are multiple USB DSD products 
available.

>
> The goal here is to have a native DSD transport, so conversion to PCM is
> not an option.
>
> Thanks,
> Andrej Falout
>
