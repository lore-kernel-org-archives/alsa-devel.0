From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Missing config option for SFFSDR_FPGA
Date: Wed, 21 Jul 2010 13:28:53 +0100
Message-ID: <20100721122853.GA15462@rakim.wolfsonmicro.main>
References: <86tynthzja.fsf@peer.zerties.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 77AB41038F4
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 14:28:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86tynthzja.fsf@peer.zerties.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, vamos-dev@i4.informatik.uni-erlangen.de, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 21, 2010 at 12:58:33PM +0200, Christian Dietrich wrote:

>         As part of the VAMOS[0] research project at the University of
> Erlangen we are looking at multiple integrity errors in linux'
> configuration system.

As I keep saying every time someone reports this problem you really need
to speak to the people responsible for the platform.  This is an issue
specific to the relevant board, please contact the maintainers of the
specific system.

If you're going to do this sort of work you need to watch out for
embedded devices - you will need to make sure to contact the people
responsible for the device as well as the subsystem maintainers who
will often have no specific knowledge of the individual systems.
