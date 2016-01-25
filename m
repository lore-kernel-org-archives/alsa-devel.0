From: Fabio Estevam <festevam@gmail.com>
Subject: Re: Locking issue from snd_soc_suspend
Date: Sun, 24 Jan 2016 22:57:02 -0200
Message-ID: <CAOMZO5Dvd3WrgxBcMSpu8aogKzsx5TOaSpRyLqjKM0WQdBdyWA@mail.gmail.com>
References: <CAOMZO5B2J+PSuAdTOA8VwuDSOAjcbeA4G5pMWPt3VAeJCpacEA@mail.gmail.com>
 <CAOMZO5BajMzAp8_M4RjjwZeHs11jdp0SCQQK1ChT9eGwVmgdTQ@mail.gmail.com>
 <56941196.7000107@metafoo.de> <569412C1.6090308@metafoo.de>
 <CAOMZO5BDmveYTGi70oLKdKLAYPx__c0mEK3ndf8cQthX2Y6VNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f178.google.com (mail-io0-f178.google.com
 [209.85.223.178])
 by alsa0.perex.cz (Postfix) with ESMTP id B53B8261A5A
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 01:57:03 +0100 (CET)
Received: by mail-io0-f178.google.com with SMTP id g73so140102373ioe.3
 for <alsa-devel@alsa-project.org>; Sun, 24 Jan 2016 16:57:03 -0800 (PST)
In-Reply-To: <CAOMZO5BDmveYTGi70oLKdKLAYPx__c0mEK3ndf8cQthX2Y6VNg@mail.gmail.com>
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

On Mon, Jan 11, 2016 at 7:28 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Lars,
>
> On Mon, Jan 11, 2016 at 6:38 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> Please try the attached patch, I think that should fix it.
>
> Excellent! This fixes the issue, thanks:
>
> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

Do you plan to send this fix as a formal patch?

Thanks
