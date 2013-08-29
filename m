From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Thu, 29 Aug 2013 17:38:28 +0530
Message-ID: <1377778108.15438.6.camel@matrix>
References: <20130708112613.GQ27646@sirena.org.uk>
 <1373542576.9286.101.camel@matrix> <20130717103651.GP22506@sirena.org.uk>
 <1374482594.13726.11.camel@matrix> <20130722100211.GP9858@sirena.org.uk>
 <1375110386.21326.6.camel@matrix> <20130729160157.GZ9858@sirena.org.uk>
 <1375689331.28910.5.camel@matrix> <20130805144201.GF9858@sirena.org.uk>
 <1375717898.29528.23.camel@matrix>  <20130805162342.GS9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3lp0080.outbound.protection.outlook.com [213.199.154.80])
 by alsa0.perex.cz (Postfix) with ESMTP id D21852654C8
 for <alsa-devel@alsa-project.org>; Thu, 29 Aug 2013 13:24:52 +0200 (CEST)
In-Reply-To: <20130805162342.GS9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, Adam Thomson <Adam.Thomson@diasemi.com>, David Dajun Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-08-05 at 17:23 +0100, Mark Brown wrote:
> On Mon, Aug 05, 2013 at 09:21:37PM +0530, Ashish Chavan wrote:

> > many stand alone CODEC drivers in kernel and most of them are fine
> > without the MFD stub. We wish that our DA9055 CODEC driver should also
> > be treated in the same way. Just placing it in a different hardware
> > package (together with PMIC, in this case) shouldn't necessitate any
> > changes in software. e.g. whether any chip is produced as a BGA
> > component or through hole component, has no effect on it's software.
>
> You only need to write the glue once, it'd probably take you less time
> than writing these e-mails...  Once you've handed the regmap to the ASoC
> core the code is identical.

Apologies for my delayed response. Unfortunately I need to come out of
this activity abruptly. One of my colleague, Adam Thomson will take this
thread forward and will help in doing all required updates to the
driver. He will also serve as future maintainer for DA9055 codec driver.

Thanks for all your support till date.


This message contains information that may be privileged or confidential and is the property of the KPIT Cummins Infosystems Ltd. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message. KPIT Cummins Infosystems Ltd. does not accept any liability for virus infected mails.
