From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Missing config option for SFFSDR_FPGA
Date: Wed, 21 Jul 2010 13:55:15 +0100
Message-ID: <20100721125514.GC15462@rakim.wolfsonmicro.main>
References: <86tynthzja.fsf@peer.zerties.org>
	<20100721122853.GA15462@rakim.wolfsonmicro.main>
	<s5htynt2eum.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E34D103938
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:55:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htynt2eum.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>, linux-kernel@vger.kernel.org, vamos-dev@i4.informatik.uni-erlangen.de, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 21, 2010 at 02:34:25PM +0200, Takashi Iwai wrote:

> The problem is that the drivers for embedded platforms are often out
> of sync.  davinci is one of such platforms.  So, as Mark suggested,
> it'd be better to talk with guys responsible for such a system
> beforehand.

> Of course, as upstream, we can clean up things here.  But, I'd like to
> see this clean-up rather from the platform side.  In that way, it can
> be synchronized better.

More generally nobody who doesn't have the board is going to care about
things in a board-specific file too much, and with a lot of boards
there's substantial code carried out of tree that's not yet made it into
mainline for one reason or another.
