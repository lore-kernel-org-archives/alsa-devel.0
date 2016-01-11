From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Locking issue from snd_soc_suspend
Date: Mon, 11 Jan 2016 19:28:01 -0200
Message-ID: <CAOMZO5BDmveYTGi70oLKdKLAYPx__c0mEK3ndf8cQthX2Y6VNg@mail.gmail.com>
References: <CAOMZO5B2J+PSuAdTOA8VwuDSOAjcbeA4G5pMWPt3VAeJCpacEA@mail.gmail.com>
 <CAOMZO5BajMzAp8_M4RjjwZeHs11jdp0SCQQK1ChT9eGwVmgdTQ@mail.gmail.com>
 <56941196.7000107@metafoo.de> <569412C1.6090308@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f179.google.com (mail-io0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 1ADAF260438
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 22:28:04 +0100 (CET)
Received: by mail-io0-f179.google.com with SMTP id q21so362922591iod.0
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2016 13:28:04 -0800 (PST)
In-Reply-To: <569412C1.6090308@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Martin Fuzzey <mfuzzey@parkeon.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Hi Lars,

On Mon, Jan 11, 2016 at 6:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:

> Please try the attached patch, I think that should fix it.

Excellent! This fixes the issue, thanks:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

Martin,

Which audio driver do you use in your case?
