From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC][PATCH 20/26] alsa: ASoC: Add JZ4740 codec
 driver
Date: Thu, 03 Jun 2010 13:50:08 +0100
Message-ID: <1275569408.3593.107.camel@odin>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
	<1275505950-17334-4-git-send-email-lars@metafoo.de>
	<1275568334.3593.92.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 91080103AAD
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 14:50:10 +0200 (CEST)
Received: by wwf26 with SMTP id 26so40662wwf.38
	for <alsa-devel@alsa-project.org>; Thu, 03 Jun 2010 05:50:10 -0700 (PDT)
In-Reply-To: <1275568334.3593.92.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-06-03 at 13:32 +0100, Liam Girdwood wrote:
> On Wed, 2010-06-02 at 21:12 +0200, Lars-Peter Clausen wrote:
> > This patch adds support for the JZ4740 internal codec.
> > 
> > Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > Cc: Liam Girdwood <lrg@slimlogic.co.uk>
> > Cc: alsa-devel@alsa-project.org
> > ---
> >  sound/soc/codecs/Kconfig        |    4 +
> >  sound/soc/codecs/Makefile       |    2 +
> >  sound/soc/codecs/jz4740-codec.c |  502 +++++++++++++++++++++++++++++++++++++++
> >  sound/soc/codecs/jz4740-codec.h |   20 ++
> >  4 files changed, 528 insertions(+), 0 deletions(-)
> >  create mode 100644 sound/soc/codecs/jz4740-codec.c
> >  create mode 100644 sound/soc/codecs/jz4740-codec.h
> 
> no need for code in file name here.

My bad typing - I mean codec.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
