From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: Re: Locking issue from snd_soc_suspend
Date: Tue, 12 Jan 2016 17:31:50 +0100
Message-ID: <56952A76.3080405@parkeon.com>
References: <CAOMZO5B2J+PSuAdTOA8VwuDSOAjcbeA4G5pMWPt3VAeJCpacEA@mail.gmail.com>
 <CAOMZO5BajMzAp8_M4RjjwZeHs11jdp0SCQQK1ChT9eGwVmgdTQ@mail.gmail.com>
 <56941196.7000107@metafoo.de> <569412C1.6090308@metafoo.de>
 <CAOMZO5BDmveYTGi70oLKdKLAYPx__c0mEK3ndf8cQthX2Y6VNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
 by alsa0.perex.cz (Postfix) with ESMTP id DB980260455
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 17:31:51 +0100 (CET)
Received: by mail-wm0-f46.google.com with SMTP id f206so261283624wmf.0
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 08:31:51 -0800 (PST)
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
To: Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Russell King <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 11/01/16 22:28, Fabio Estevam wrote:
> Martin, Which audio driver do you use in your case? 

I use imx-sgtl5000

However, I found I can't actually reproduce the problem anymore on 
recent kernels.
I remember having it and still have the hack for it in my tree.

Digging a bit in history it turns out that the problem was fixed for 
imx-sgtl5000 way back in 3.14 (by 47cf84e ASoC: fsl: fix pm support of 
machine drivers).

I hadn't noticed it had been fixed and had been rebasing the now useless 
hack to newer kernels :(

So sorry for the noise on that.

Regards,
Martin
