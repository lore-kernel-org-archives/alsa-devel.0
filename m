From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Wed, 13 Mar 2019 14:57:26 +0900
Message-ID: <20190313055726.GB13393@workstation>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308172235.GA31189@sirena.org.uk>
 <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
 <20190311081546.GA8324@workstation>
 <e9ce6844-8239-63a7-1855-7f47ebd97723@perex.cz>
 <20190312150300.GE6983@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com
 [64.147.123.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AB236F89718
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2019 06:57:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20190312150300.GE6983@sirena.org.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>
Cc: Sven Van Asbroeck <thesven73@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux admin <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Mar 12, 2019 at 03:03:00PM +0000, Mark Brown wrote:
> On Mon, Mar 11, 2019 at 04:43:39PM +0100, Jaroslav Kysela wrote:
> 
> > I would not use any of the "user space" ioctl API to represent the
> > hardware bclk requirements. The applications should know just the DMA
> > memory layout.
> 
> > Also, think about the multiple simultaneous paths for the audio output
> > in the sound controller (so one DMA from the user space to the
> > controller, but the controller can do multiple simultaneous outputs
> > using different clocks combining different wire buses or so). Yes, it's
> > the corner case, but it's another reason to have the bclk code totally
> > separated from the user space ALSA's PCM API.
> 
> There's also a range of devices that either don't have visible buses at
> all due to integration or which are on buses that look nothing like the
> I2S/DSP mode style of bus, rendering the parameters meaningless.

Indeed. That's resonable to add no changes to ALSA PCM interface. When
suggesting usage of 'rate_num' and 'rate_den', I assumed to change
ALSA SoC part internal to have constraints and rules for them, with no
changes of ALSA PCM inteface itself. I agree that the dicision of
on-wire format should not be exposed to userspace as well.


[1] https://mailman.alsa-project.org/pipermail/alsa-devel/2019-March/146261.html

Thanks

Takashi Sakamoto
