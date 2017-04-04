From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback formats;
 does aplay pad S16_LE, or does the hardware?
Date: Tue, 4 Apr 2017 11:11:36 +0200
Message-ID: <c284a660-840d-46a3-014f-9225c4f4fdca@ladisch.de>
References: <CALAeOVNZWTOeAXB+4neM+xPb=63egoaSJiaZaZ5e3izi81ND8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id F19C62668F6
 for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2017 11:11:38 +0200 (CEST)
In-Reply-To: <CALAeOVNZWTOeAXB+4neM+xPb=63egoaSJiaZaZ5e3izi81ND8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> I can successfully play 32b@32KHz and 32b@16KHz to my I2S DAC.
>
> I can also, with the same settings as 32b@16KHz, play 16b@32KHz, but I
> don't think this is the way ALSA wants its data....
>
> I've learned that hw_params is responsible for describing only what the
> hardware is supposed to be capable of.

The hw_params values describe the format of the samples in memory.
(If alsa-lib does format conversion, the application and the driver see
different hw_params values.)

What the hardware does with the samples after the DMA controller has
read them from memory is of no concern to the ALSA framework.

> Does this mean the hardware needs to find a way to pad 0's on lower
> quality data for any given rate?

If the hardware is capable of that, then the driver can support 16-bit
samples.  (I don't know of any I=B2S controller that cannot do that.)

> For example, when I play 32b @32 KHz, everything works. If I play 16b@32K=
Hz,
> I shouldn't change any output clocks, but will also present the data on a
> 32bit data bus as 16bits padded with 0?

Which bus?  The memory bus, or the I=B2S bus?


Regards,
Clemens
