From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] pxa2xx-ac97-lib: move set_resetgpio	to
	pxa27x.c
Date: Mon, 25 May 2009 11:47:20 +0100
Message-ID: <20090525104720.GA6567@rakim.wolfsonmicro.main>
References: <1243243219-23786-1-git-send-email-dbaryshkov@gmail.com>
	<f17812d70905250321y4b914bc8r24527b51ff0531e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82699103839
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 12:47:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70905250321y4b914bc8r24527b51ff0531e8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 06:21:40PM +0800, Eric Miao wrote:

> there are two other ways out from my POV:

> 2. or having something like IrDA, i.e. platform specific hooks to make
> the driver code generic

> I personally prefer way 2) but don't have time for a clean solution yet,
> maybe you can help take a look into this. That would be nice.

For 2 we should probably just move all the reset implementations into
the CPU code and then either have a function to select the
implementation or keep using the current code but move the functions it
references.

I don't really mind how this is done so long as you guys are happy with
it, though if we're going to move the pxa27x functions only a better
commit log explaining the issue with the MFP API would be nice.
