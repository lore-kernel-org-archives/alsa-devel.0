From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Tue, 23 Jun 2009 10:54:45 +0100
Message-ID: <20090623095444.GC5422@sirena.org.uk>
References: <9e4733910906201906y78f76545sc3cdfe9b45a8db5f@mail.gmail.com>
	<ad2655cb0906220927o68628357u223119b76e3967e4@mail.gmail.com>
	<9e4733910906220943pd00fbaao2e2c92690e96d46a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 424542462B
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 11:54:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910906220943pd00fbaao2e2c92690e96d46a@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 22, 2009 at 12:43:52PM -0400, Jon Smirl wrote:
> On Mon, Jun 22, 2009 at 12:27 PM, James

> > DMA transfers on sound cards are a ring buffer. There is no automatic
> > stop feature.

> I don't about all hardware, but all of the hardware I've worked with
> works both ways, ring or stop at the end.

> DMA transfers for network packets wouldn't work in the ring buffer
> model, you need the stop at the end capability.

Remember, you're working with a general purpose SoC which shares the DMA
controller with a large selection of other hardware.  A DMA controller
that's part of a sound device and can't be used in anything else doesn't
need to worry about any other applications.
