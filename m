From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Help request - ASoC recursion issue
Date: Tue, 24 Jul 2012 23:46:50 +0100
Message-ID: <20120724224649.GE1767@opensource.wolfsonmicro.com>
References: <500D5A1F.9000808@linaro.org> <500D649B.80704@linaro.org>
 <500D6602.6070809@linaro.org>
 <20120723181249.GF3421@mudshark.cambridge.arm.com>
 <500E4E2C.3060804@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 32FE6265DAC
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:46:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <500E4E2C.3060804@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Will Deacon <will.deacon@arm.com>, Liam Girdwood <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 24, 2012 at 08:26:36AM +0100, Lee Jones wrote:

> Yes, I am inclined to agree with you. I just thought it was  
> uncharacteristic of a memory corruption error, as can reliably reproduce  
> the bootlog above. What's even more strange is that the issue only  
> arises on one of my two _identical_ development boards.

It's not that unusual depending on where the cause is - for example,
copying an initialised struct to the wrong place, and things like the
DAPM graph which are big and pointer driven are often affected.
