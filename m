From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH v3] ASoC: cs42888: Add codec driver support
Date: Tue, 18 Mar 2014 09:37:52 -0500
Message-ID: <alpine.DEB.2.02.1403180936200.14838@heelrod>
References: <1394538091-19513-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140318131033.GC11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0097.outbound.protection.outlook.com [65.55.169.97])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D9B92619FF
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 15:37:55 +0100 (CET)
In-Reply-To: <20140318131033.GC11706@sirena.org.uk>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, brian.austin@cirrus.com, lars@metafoo.de, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, rob@landley.net, Nicolin Chen <Guangyu.Chen@freescale.com>, grant.likely@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Mar 2014, Mark Brown wrote:

> On Tue, Mar 11, 2014 at 07:41:31PM +0800, Nicolin Chen wrote:
>> This patch adds support for the Cirrus Logic CS42888 Audio CODEC that
>> has four 24-bit A/D and eight 24-bit D/A converters.
>
> Brian, Paul - any review comments on this?
>
Driver looks good to me. I think we should name it the cs42xx8 since this 
actually covers CS42448 and CS42888. The CS42888 is derived from the 
CS42448.
