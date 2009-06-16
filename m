From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: pxa-ssp.c handle the I2S and
	LEFT_J cases.
Date: Tue, 16 Jun 2009 22:36:36 +0100
Message-ID: <20090616213635.GA26502@sirena.org.uk>
References: <1245113136.24109.562.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E59BD2415F
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Jun 2009 23:36:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1245113136.24109.562.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: Paul Shen <boshen9@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2009 at 09:45:35PM -0300, Daniel Ribeiro wrote:

>  arch/arm/mach-pxa/include/mach/regs-ssp.h |   14 ++--

Eric, are you happy for this change to go via ALSA?  It seems reasonable
enough.

I'm happy with these changes from a code review point of view, though
as well as Eric's ack I'll do some more testing before I apply them.
Thanks a lot for doing this work.
