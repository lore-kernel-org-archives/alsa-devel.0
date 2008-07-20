From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: ASOC and 12 bit volume control
Date: Sun, 20 Jul 2008 14:47:31 -0400
Message-ID: <9e4733910807201147s4179adfbse34e56f2abe2541d@mail.gmail.com>
References: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
	<20080720125639.GB27546@sirena.org.uk>
	<9e4733910807200851s632d99dna3fffc4e53c04987@mail.gmail.com>
	<20080720175631.GA6719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 7815B2447A
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 20:47:32 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so399114ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 20 Jul 2008 11:47:31 -0700 (PDT)
In-Reply-To: <20080720175631.GA6719@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 7/20/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jul 20, 2008 at 11:51:12AM -0400, Jon Smirl wrote:
>
>  > Another problem is the crossbar mixer. It is a full 8x4 crossbar with
>  > 28 bit gain controls on each path. There are four 32 byte registers,
>  > each register holds 8 32 bit wide gain fields. There are several more
>  > mixers with 28 bit gain controls.
>
>
> I think that the best thing for these 32 byte registers is a new control
>  type.  If they're as frequently implemented in TI CODECs as it seems
>  then it'd be worth pulling them into core but the fact that they're 32
>  byte would probably mean contortions trying to fit them into the same
>  abstraction as registers that can be manipulated in a simple type.  It's
>  also possible that the combination of large registers and high
>  resolution fields within them may mean that special treatment is
>  warranted in order to avoid blocking user applications too much with
>  high volume register writes, but I'm not sure if that's a real issue or
>  not.

These chips are capable of processing 192K 24b HD quality audio.
Datasheet http://www.ti.com/lit/gpn/tas5504
Do the Intel HD audio chips have similar controls?

I believe the TI codecs are implemented with a combination of an 8051
core controlling a DSP.  The i2c interface is talking to the 8051
core, not real hardware registers. The 8051 takes the incoming i2c
messages and stores them in RAM and uses the info to manipulate the
DSP.

>  > 28 bit gain fields are all on all of the bass/loudness/etc control.
>
>
> Are any of these 28 bit controls not in 32 byte registers?

0x41-48, input mixers 8x4 crossbar
32 byte register, contains 8 5.23 input gains in 32b fields.
0x49-0x50, bass management
4 bytes, contain 5.23 coefficients
0x89-0x90, bass and treble bypass
8 bytes, contains two 5.23 coefficients
0xa2-a9, DRC bypass
8 bytes, contains two 5.23 gains
output 4x4 crossbar, more 5.23 gains

The chip supports DRC (compression and expansion), some of the DRC
parameters are 48bits in 25.23 format. Loudness is 25.23 too.
0x92 and 0x94 are examples of 64 bit registers.

-- 
Jon Smirl
jonsmirl@gmail.com
