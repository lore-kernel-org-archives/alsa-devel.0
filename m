From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH] ASoC: codecs: da9055: Update driver name
 to fix breakage due to pmic driver with same name
Date: Mon, 22 Jul 2013 14:13:14 +0530
Message-ID: <1374482594.13726.11.camel@matrix>
References: <1373024862.3233.63.camel@matrix>
 <20130705114456.GV27646@sirena.org.uk> <1373031306.3233.131.camel@matrix>
 <20130705133752.GX27646@sirena.org.uk> <1373270091.11222.12.camel@matrix>
 <20130708112613.GQ27646@sirena.org.uk> <1373542576.9286.101.camel@matrix>
 <20130717103651.GP22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3lp0076.outbound.protection.outlook.com [213.199.154.76])
 by alsa0.perex.cz (Postfix) with ESMTP id DCFCF261785
 for <alsa-devel@alsa-project.org>; Mon, 22 Jul 2013 10:11:20 +0200 (CEST)
In-Reply-To: <20130717103651.GP22506@sirena.org.uk>
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

On Wed, 2013-07-17 at 11:36 +0100, Mark Brown wrote:
> On Thu, Jul 11, 2013 at 05:06:16PM +0530, Ashish Chavan wrote:
>
> > accommodate this level of change. Is it possible that in first go we
> > just fix the breakage due to name collision so that both drivers remain
> > usable. And in second iteration, we restructure both of them as you
> > suggested?
>
> To be honest I'm really not terribly happy about this - I don't have all
> that much confidence that the second step will happen, the fact that
> this has been broken for a considerable time isn't inspiring here.
> However I guess...

Thanks for sharing your view. This makes me believe that second step is
very important and urgent. Keeping this in mind, we have already started
working on it and hope to submit updated drivers in next 5-6 weeks. In
the meanwhile you may apply quick fix (one which I already posted), if
you find it worth.


This message contains information that may be privileged or confidential and is the property of the KPIT Cummins Infosystems Ltd. It is intended only for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message. KPIT Cummins Infosystems Ltd. does not accept any liability for virus infected mails.
