From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 29 Jul 2013 20:36:26 +0530
Message-ID: <1375110386.21326.6.camel@matrix>
References: <1373024862.3233.63.camel@matrix>
 <20130705114456.GV27646@sirena.org.uk> <1373031306.3233.131.camel@matrix>
 <20130705133752.GX27646@sirena.org.uk> <1373270091.11222.12.camel@matrix>
 <20130708112613.GQ27646@sirena.org.uk> <1373542576.9286.101.camel@matrix>
 <20130717103651.GP22506@sirena.org.uk> <1374482594.13726.11.camel@matrix>
 <20130722100211.GP9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1lp0016.outbound.protection.outlook.com [213.199.154.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 1795D261B03
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 16:32:35 +0200 (CEST)
In-Reply-To: <20130722100211.GP9858@sirena.org.uk>
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
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, "kiran.padwal" <kiran.padwal@kpitcummins.com>, lrg <lrg@ti.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-07-22 at 11:02 +0100, Mark Brown wrote:
> On Mon, Jul 22, 2013 at 02:13:14PM +0530, Ashish Chavan wrote:
>
> > working on it and hope to submit updated drivers in next 5-6 weeks. In
> > the meanwhile you may apply quick fix (one which I already posted), if
> > you find it worth.
>
> You would need to resend, as I indicated orginally I discarded it.

We had started working on restructuring of both PMIC and CODEC drivers.
But soon after starting, we realized that the kind of abstraction that
we were heading towards will not be logically correct and good from
maintainability point of view. Basically tying up two COMPLETELY
INDEPENDENT (they really don't share anything other than the name!)
drivers via a virtual MFD entity will not make much sense in our
opinion. Also as mentioned earlier, the codec design(chip) will be
produced as a standalone codec device soon, and we hope the driver can
be re-used directly without changes. Is this the reason why we see only
a handful examples of suggested implementation in kernel?


This message contains information that may be privileged or confidential and is the property of the KPIT Cummins Infosystems Ltd. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message. KPIT Cummins Infosystems Ltd. does not accept any liability for virus infected mails.
