From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [PATCH v3] ASoC: cs42888: Add codec driver support
Date: Tue, 18 Mar 2014 12:08:02 -0500
Message-ID: <alpine.DEB.2.00.1403181202310.7177@phandrigan-desktop>
References: <1394538091-19513-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140318131033.GC11706@sirena.org.uk>
 <alpine.DEB.2.02.1403180936200.14838@heelrod>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0080.outbound.protection.outlook.com [65.55.169.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 676A326158B
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 18:06:37 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1403180936200.14838@heelrod>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Mark Brown <broonie@kernel.org>, galak@codeaurora.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rob@landley.net, Nicolin Chen <Guangyu.Chen@freescale.com>, grant.likely@linaro.org
List-Id: alsa-devel@alsa-project.org


On Tue, 18 Mar 2014, Brian Austin wrote:

> On Tue, 18 Mar 2014, Mark Brown wrote:
>
>> On Tue, Mar 11, 2014 at 07:41:31PM +0800, Nicolin Chen wrote:
>>> This patch adds support for the Cirrus Logic CS42888 Audio CODEC that
>>> has four 24-bit A/D and eight 24-bit D/A converters.
>> 
>> Brian, Paul - any review comments on this?
>> 
> Driver looks good to me. I think we should name it the cs42xx8 since this 
> actually covers CS42448 and CS42888. The CS42888 is derived from the CS42448.
>
V3 looks good. As Brian said, the name should be changed to cs42xx8.
