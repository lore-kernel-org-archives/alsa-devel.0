From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoC: img: Add driver for I2S input
 controller
Date: Wed, 28 Oct 2015 21:18:20 +0000
Message-ID: <56313B9C.8030502@imgtec.com>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk> <56293472.7000401@imgtec.com>
 <20151023225723.GO29919@sirena.org.uk> <562F824F.9070407@imgtec.com>
 <20151028010443.GX28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151028010443.GX28319@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, James Hartley <James.Hartley@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 28/10/15 01:04, Mark Brown wrote:
> On Tue, Oct 27, 2015 at 01:55:27PM +0000, Damien Horsley wrote:
>> On 23/10/15 23:57, Mark Brown wrote:
> 
>>> Shouldn't we be doing that flush on stream close instead?  If nothing
>>> else the flush is going to discard a bit of data if the stream is just
>>> paused.
> 
>> The FIFOs are only 8 frames in size, so I am not sure there is an
>> issue with these frames being lost.
> 
>> I think it also makes sense to keep the blocks consistent with each
>> other. The spdif (out and in), and parallel out, all flush automatically
>> when stopped, and the fifo for the i2s out block is cleared when the
>> reset is asserted.
> 
> This seems like an issue that got missed in the other drivers then.  I'd
> expect the trigger operation to be a minimal operation which starts and
> stops the data transfer, not doing anything else.
> 

The spdif out, spdif in, and parallel out blocks auto-flush whenever
they are stopped. It is not possible for software to prevent this behavior.
