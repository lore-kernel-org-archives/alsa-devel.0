From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC and 12 bit volume control
Date: Sun, 20 Jul 2008 18:56:33 +0100
Message-ID: <20080720175631.GA6719@sirena.org.uk>
References: <9e4733910807191918w24558b25o783da05843499580@mail.gmail.com>
	<20080720125639.GB27546@sirena.org.uk>
	<9e4733910807200851s632d99dna3fffc4e53c04987@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C499244A8
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Jul 2008 19:56:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910807200851s632d99dna3fffc4e53c04987@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 20, 2008 at 11:51:12AM -0400, Jon Smirl wrote:

> Another problem is the crossbar mixer. It is a full 8x4 crossbar with
> 28 bit gain controls on each path. There are four 32 byte registers,
> each register holds 8 32 bit wide gain fields. There are several more
> mixers with 28 bit gain controls.

I think that the best thing for these 32 byte registers is a new control
type.  If they're as frequently implemented in TI CODECs as it seems
then it'd be worth pulling them into core but the fact that they're 32
byte would probably mean contortions trying to fit them into the same
abstraction as registers that can be manipulated in a simple type.  It's
also possible that the combination of large registers and high
resolution fields within them may mean that special treatment is
warranted in order to avoid blocking user applications too much with
high volume register writes, but I'm not sure if that's a real issue or
not.

> 28 bit gain fields are all on all of the bass/loudness/etc control.

Are any of these 28 bit controls not in 32 byte registers?
