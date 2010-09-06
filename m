From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix null pointer
 dereference when pdata is not set
Date: Mon, 06 Sep 2010 11:39:01 +0100
Message-ID: <1283769541.3078.17.camel@odin>
References: <1283703022-3730-1-git-send-email-jhnikula@gmail.com>
	<20100906094514.GC10367@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BC90324505
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 12:39:04 +0200 (CEST)
Received: by wyb32 with SMTP id 32so4503342wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 06 Sep 2010 03:39:04 -0700 (PDT)
In-Reply-To: <20100906094514.GC10367@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-09-06 at 10:45 +0100, Mark Brown wrote:
> On Sun, Sep 05, 2010 at 07:10:22PM +0300, Jarkko Nikula wrote:
> > Null pointer dereference will occur from *setup = pdata->setup if pdata
> > is not set. Fix this by moving assignments from pdata inside non-null case.
> > 
> > Thanks to Jiri Slaby <jirislaby@gmail.com> for noticing.
> > 
> > Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> > Cc: Jiri Slaby <jirislaby@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
