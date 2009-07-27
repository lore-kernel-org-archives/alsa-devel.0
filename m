From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] blackfin I2S(TDM mode) CPU DAI driver
Date: Mon, 27 Jul 2009 17:35:26 +0100
Message-ID: <20090727163526.GA19543@rakim.wolfsonmicro.main>
References: <1248286234-6053-1-git-send-email-21cnbao@gmail.com>
	<1248286234-6053-2-git-send-email-21cnbao@gmail.com>
	<20090725124909.GA7284@opensource.wolfsonmicro.com>
	<3c17e3570907270300u7ccc47b5q9d0fd9039080deb3@mail.gmail.com>
	<20090727144052.GA8900@rakim.wolfsonmicro.main>
	<3c17e3570907270932j638365f3rbbca0360a3b8c3e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 860A124371
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jul 2009 18:35:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c17e3570907270932j638365f3rbbca0360a3b8c3e5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 28, 2009 at 12:32:01AM +0800, Barry Song wrote:
> 2009/7/27 Mark Brown <broonie@opensource.wolfsonmicro.com>:

> > ...are you sure there's a different meaning for the external pins - what
> > are these differences? =A0If they're not just related to the number of =
bit
> > clock cycles per frame clock then are you sure it will interoperate with
> > other DSP mode devices?

> For I2S mode, each SPORT has two sets of independent transmit and
> receive pins. Every set of pins support a stereo receive or transmit.

> For TDM mode, the main characteristic is using time-sharing to a set
> of pins. A typical connection for TDM is like "tdm.gif". Only
> tx/rx/clk/sync are connected to codec.  And in codec side, DSDATA1

OK, that's not really a difference as far as ASoC is concerned - all the
pins have their normal meanings, it's just that your I2S mode permits
additional data lines (presumably your TDM mode could also be set up to
use multiple data lines).  None of the pins change meaning.
