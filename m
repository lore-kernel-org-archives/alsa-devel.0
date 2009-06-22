From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [RFC] I2S and LEFT_J
Date: Tue, 23 Jun 2009 00:14:30 +0200
Message-ID: <20090622221430.GH29236@buzzloop.caiaq.de>
References: <f17812d70906090239p5dee129egda49918b3862c0ca@mail.gmail.com>
	<1244672649.25905.70.camel@brutus>
	<f17812d70906110634i623eb236ib277e164678a7a34@mail.gmail.com>
	<1244730992.21356.50.camel@brutus>
	<f17812d70906150145p763002det5e2699442673d532@mail.gmail.com>
	<1245077824.24109.51.camel@brutus>
	<20090615150433.GF6106@sirena.org.uk>
	<1245086420.24109.159.camel@brutus>
	<4A39F3A5.5030109@gmail.com> <1245328258.303.45.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 77B9224692
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 00:14:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245328258.303.45.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On Thu, Jun 18, 2009 at 09:30:58AM -0300, Daniel Ribeiro wrote:
> If your codec can work with S16LE and 32bitfs, then i suggest you to use
> this mode. If not, then you need to setup TDM.
> 
> For 2*16 on 64bitfs:
> Call set_tdm_slot(5, 5, 4, 16).

I tried your three patches now, and it doesn't seem to work for me.
Using the mode above, I get the following register values:

  SSCR0 0xa30003ff
  SSCR1 0x00601d80
  SSPSP 0x31a00084 
  SSTSA 0x00000005
  SSRSA 0x00000005

And on the oscilloscope, I see an asynchronous LRCLK[1].

set_tdm_slot(3, 3, 2, 16) gave me slightly better results, but the PSP
values are stil bogus (SFRMWDTH=0x10 and EDMYSTOP=0x7).

When manually forcing (E)DMYSTOP=0xf and SFRMWDTH=0x20, the signal looks
correct at first[2], but the audio material is played back at half speed.

This is where I stopped for now. I can just tell that I've spent many
hours playing with these bits and never found a fully working networked
mode based setting for that kind of signal output.

What's worth mentioning is this quote from the PXA datasheet - the code
does not currently follow that rule:

  "When using Programmable Serial Protocol (PSP) format in network
  mode, the parameters SFRMDLY, STRTDLY, DMYSTP, EDMYSTP, DMYSTRT, and
  EDMYSTRT must be set to 0b0; the other parameters SFRMP, SCMODE, FSRT,
  and SFRMWDTH are programmable."
  (4.5.8 SSP Programmable Serial Protocol Registers (SSPSP_x))

AFAIK, Eric and Paul seem to have the exactly same requirements, so
maybe they can test and get back with more results?

Without network mode, these are the register values that do what I need:

  SSCR0 0x2100037F
  SSCR1 0x00C01d08
  SSPSP 0x31a08084
  (SSTSA/SSRSA don't matter in this case)

Let me know if I can provide any more feedback :)

Thanks,
Daniel

[1] http://caiaq.de/download/tmp/1.png
[2] http://caiaq.de/download/tmp/2.png
(2: i2s_txd, 1:i2s_frame, 3:i2s_clk)
