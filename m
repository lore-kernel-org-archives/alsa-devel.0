From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH] ASoC: dwc: disallow building
	designware_pcm as a module
Date: Wed, 19 Apr 2017 17:12:00 +0100
Message-ID: <2e39b000-bf25-6447-b53b-047401041f4e@synopsys.com>
References: <20170418105954.23368-1-lkundrak@v3.sk>
 <20170418151834.c7e5fivmgn73sbwd@sirena.org.uk>
 <1492532010.28092.12.camel@v3.sk>
 <20170418171519.csiftftd434psyn5@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.60.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 99346266ADE
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 18:12:07 +0200 (CEST)
In-Reply-To: <20170418171519.csiftftd434psyn5@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Hi Lubomir,


On 18-04-2017 18:15, Mark Brown wrote:
> On Tue, Apr 18, 2017 at 06:13:30PM +0200, Lubomir Rintel wrote:
>
>> I don't think designware_pcm is a separate driver. It looks tightly
>> coupled with designware_i2s: you can either disable designware_pcm
>> altogether at build time or always load it together with
>> designware_i2s.
> Yes, they're closely coupled but we might still want them both as a
> module.

Thanks for the patch but I agree with Mark.

For the record you can add "MODULE_LICENSE(=93Dual MIT/GPL=94)".

Best regards,
Jose Miguel Abreu
