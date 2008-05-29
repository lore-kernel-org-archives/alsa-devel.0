From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASOC, SPDIF and AC97
Date: Thu, 29 May 2008 19:50:07 +0100
Message-ID: <20080529185006.GA26325@sirena.org.uk>
References: <9e4733910805271116t1d36e769qaedfc0362b03e48d@mail.gmail.com>
	<20080528101430.GB12414@sirena.org.uk>
	<9e4733910805280640nd460258i547c8bc6581b411a@mail.gmail.com>
	<20080528161001.GF12414@sirena.org.uk>
	<9e4733910805281315p3ced192aoddf368d5d201758b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2A2EA24911
	for <alsa-devel@alsa-project.org>;
	Thu, 29 May 2008 20:50:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910805281315p3ced192aoddf368d5d201758b@mail.gmail.com>
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

On Wed, May 28, 2008 at 04:15:40PM -0400, Jon Smirl wrote:
> On 5/28/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > It shouldn't be fundamentally different to multiple independent records
> >  which the PXA code does support.  If you present them as separate PCMs
> >  then ALSA won't synchronize them for you.

> Any words of wisdom on how to synchronize?

It's not a situation I've run into myself.  I'd try something like
having the DMA driver delay the application starting the second stream
but I've no idea if that'd work or do what you need.
