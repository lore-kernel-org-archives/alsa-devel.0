From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 13:10:57 +0900
Message-ID: <20190308041056.GA1172@workstation>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D0539F806F7
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 05:11:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sven Van Asbroeck <thesven73@gmail.com>
Cc: alsa-devel@alsa-project.org, Russell King <rmk+kernel@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 05, 2019 at 09:23:46AM -0500, Sven Van Asbroeck wrote:
> The original problem was that the fsl_ssi did not appear to work with the
> tda998x hdmi codec. This codec seems to be 'unique' in the sense that it
> needs to know the number of clocks per frame on the wire, i.e. the bclk_ratio,
> which no-one in alsa is providing or using at the moment.
> 
> I first made the error of conflating the physical width and the bclk_ratio,
> and posted this patch - Russell King quickly pointed out my error:
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145916.html
> 
> This then led to the following discussions:
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145985
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145947
> 
> Most of the discussion is about a mechanism to convey bclk_ratio from
> the frame master
> to the tda998x. We don't yet seem to have a consensus on how to do this best.
> 
> My rfc patch was only intended to provoke discussion, and to allow
> people to experiment
> with a flawed solution that would allow the alsa core to negotiate
> bclk_ratio between
> components. The uapi change is a serious flaw. bclk_ratio negotiation should be
> invisible to userspace. But I cannot see a way to accomplish this.

In your case:

+---+            +-----+
|CPU| <- wire -> |CODEC|
|DAI|            | DAI |
+---+            +-----+

So that:

CPU-DAI = fsl_ssi
CODEC-DAI = tda998x
wire = I2S

In I2S:
 - SCK-line = serial clock
 - WS-line = word select
 - SD-line = serial data 

In general I2S communication:
 - 2 samples are transferred in a phase of WS

In my opinion:
 - 'the number of clocks per frame on the wire' (=you need)
   = the number of phases of SCK per phase of WS

In expectation of ALSA PCM interface for hardware for usual device:
 - half number of phases of SCK per phase of WC
   = physical_width of sample
   = bytes per sample
 - the number of phases of SCK per phase of WC
   = physical_width * channels (=2)
   = bytes per frame
 - the ratio between phases of SCK and phases of WC per second
   = rate

Here, usual device is expected to give FIFO for DMA and I2S bus,
synchronized to SCK without any conversion. CODED-DAI also has
FIFO to process signals.

In my opinion, if both of fsl_ssi and tda988x have enough constraints
and rules for runtime of PCM substream about the physical_width, channels
and rate, things look to work well. Perhaps, tda998x driver should have a
condition statement for its role of 'frame master' to add the constraints
and rules, to describe its quirk.

It's helpful to describe the 'unique'ness of tda998x hdmi codec for
the detail.


Regards

Takashi Sakamoto (not maintainer of this subsystem)
