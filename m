From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: New codec for STAC9766 used on Efika
Date: Sat, 2 May 2009 10:00:28 -0400
Message-ID: <9e4733910905020700i29709272m6b34495a31393176@mail.gmail.com>
References: <9e4733910904301330h54581775i592d1ee4049a8dd0@mail.gmail.com>
	<20090501101402.GB6975@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C12DC24968
	for <alsa-devel@alsa-project.org>;
	Sat,  2 May 2009 16:00:30 +0200 (CEST)
Received: by qyk1 with SMTP id 1so5582622qyk.16
	for <alsa-devel@alsa-project.org>; Sat, 02 May 2009 07:00:28 -0700 (PDT)
In-Reply-To: <20090501101402.GB6975@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Matt Sealey <matt@genesi-usa.com>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 1, 2009 at 6:14 AM, Mark Brown <broonie@sirena.org.uk> wrote:
>> How should SPDIF support work? The hardware supports simultaneous use
>> of analog and SPDIF. =A0Do I want one DAI or two? =A0If I have two DAI
>
> Having taken a step back and looked at the datasheet what's going on
> here is that the CODEC has a S/PDIF output which can take either an AC97
> timeslot or the output of the ADC as input. =A0The AC97 timeslot input
> should probably be represented as a DAI, feeding into a mux selecting
> the input to be output to S/PDIF.
>
>> then ALSA needs to interleave the samples into a single DMA stream. So
>> if one stream isn't active it needs to be filled with silence.
>
> The AC97 controller driver should be able to expose multiple data
> streams - normally the hardware has direct support for this.

mpc5200 hardware can not split the stream's DMA. If there are three
active streams they need to be arranged as 6 32b words in a single
buffer.

Various choices...
1) always turn on the two output streams and three input streams in
the codec and pass them through the mpc5200. Alsa needs to deal with 6
32b samples in the input buffer even if only one ALSA stream is
active.
2) Only support one stream in and out from the codec. Use the switches
on the codec to decide which stream is visible.
3) this is harder - coordinate between the codec and mpc5200 ac97
driver. When a new stream is turned on in the codec, also turn it on
in the mpc5200.
4) always turn on all streams in the codec. manipulate the slot masks
in the mpc5200 to only make the ones alsa is interested in visible.
This causes error interrupts on the mpc5200, but they can be turned
off. Alsa still needs to deal with 6 32b words per sample in the
buffer is three streams are active.

Codec DAIs are missing a needed piece of information. You can flip
bits in the codec and change the active slots in the AC97 stream. For
dynamic configurations the CPU DAI needs to know the slot information.

-- =

Jon Smirl
jonsmirl@gmail.com
