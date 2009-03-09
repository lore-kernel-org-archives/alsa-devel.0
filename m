From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: snd-soc-pxa-ssp I2C/FIFO issues
Date: Mon, 9 Mar 2009 17:00:30 +0100
Message-ID: <74d0deb30903090900x2358b2fdu2d4b5ab184ff1764@mail.gmail.com>
References: <74d0deb30903090747p3fbb8dd5l27cd7313d4be7de2@mail.gmail.com>
	<20090309153629.GB24787@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f177.google.com (mail-gx0-f177.google.com
	[209.85.217.177])
	by alsa0.perex.cz (Postfix) with ESMTP id CA2541037EA
	for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2009 17:00:31 +0100 (CET)
Received: by gxk25 with SMTP id 25so2565890gxk.22
	for <alsa-devel@alsa-project.org>; Mon, 09 Mar 2009 09:00:30 -0700 (PDT)
In-Reply-To: <20090309153629.GB24787@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 9, 2009 at 4:36 PM, Daniel Mack <daniel@caiaq.de> wrote:
> Hi Philipp,
>
> On Mon, Mar 09, 2009 at 03:47:35PM +0100, pHilipp Zabel wrote:
>> Magician needs stereo S16_LE input data from alsa, DAIFMT_DSP_A on the
>> wire with a frame size of 16 bit (one frame for each channel) and thus
>> 2-byte DMA transfers to the FIFO (currently called 'mono' DMA params).
>> Zylonite's current code uses 32 bit frame size and 4-byte DMA
>> transfers to emulate I2S (S16_LE,stereo). Network mode seems to work,
>> so it could be changed to use two 16 bit slots instead with 2-byte DMA
>> transfers (which would make Magician happy). But...
>
> That's just one mode the driver has to support, which it currently does
> already, right?

The DAI mode (DSP_A, 16 bit width) is supported just fine. But the
current code always uses 4-byte DMA for stereo and 2-byte DMA for
mono. It operates under the assumption that both 16-bit stereo
channels are transmitted in one 32-bit frame.
If I send two 16-bit frames per sample, the DMA shovels 4 bytes into
the FIFO twice, and I'm losing half the data.

>> Daniel's board needs very strange settings because network mode
>> doesn't work, so I guess he can't use 2-byte DMA transfers. Is that
>> correct?
>
> It's not that strange actually. All it needs to have is 64 bitclk cycles
> per frame with 32 bits of data per frame. See the CS4270 datasheet[1],
> Figure 10 on page 19. At least when operating in master mode, the codec
> needs to have bitclk =3D 64fs.

IMHO, the physical DAI format isn't strange, but SSP parameters you
can use to achieve that are.

>> If we can't find a way to have all machines use the mono DMA params,
>> there has to be some kind of interface to set the width of the data in
>> the FIFO independently from the Alsa format. How should that interface
>> look like?
>
> IMO, we need to pass three informations to the DAIs:
>
> 1) The hardware interface format (I2S/DSP/LEFT_J/RIGHT_J/...)
> 2) The pyhsical frame width (ie, how many data is actually used per
> =A0 frame, which then also tells us how to use the FIFOs)
> 3) The data alignment (ie, how data is sent within the frames)
>
> As I see these informations beloning together, I would have said (3)
> should be defined in a similar way than (1) and (2) and hence find a
> nice place to live in the dai_fmt integer bits, as we can call the CPU's
> set_dai_fmt() function from the board file.

Would work for me.

> Mark says he'd rather like me to use/abuse the set_clk_div() interface
> for that but IMO that's an evil hack. The next CPU would need a similar
> thing to be used with this codec, so there should be a clean way to
> achive that.

And it can't be used to set the DMA/FIFO width.

> So - no worries. Whatever way we choose, we'll avoid regressions for the
> Magician board, but I need your help in testing this as I don't have
> anything else than our own hardware :)

I'm not worried about regressions. Magician board support isn't even
submitted yet.
I need a clean way to do 2) first. I just kind of hoped it could make
it into 2.6.30 :)

regards
Philipp
