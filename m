From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Fix SPI driver binding for WM8987
Date: Tue, 9 Aug 2011 16:41:55 +0100
Message-ID: <4E415543.9040200@ti.com>
References: <1312362661-4544-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4E41253E.2040407@ti.com>
	<20110809150503.GE15861@opensource.wolfsonmicro.com>
	<4E415204.8020702@ti.com>
	<20110809153136.GH15861@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id CB748245D1
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 17:41:57 +0200 (CEST)
In-Reply-To: <20110809153136.GH15861@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 09/08/11 16:31, Mark Brown wrote:
> On Tue, Aug 09, 2011 at 04:28:04PM +0100, Liam Girdwood wrote:
>> On 09/08/11 16:05, Mark Brown wrote:
> 
>>> Hrm?  Subject line says WM8987...
> 
>> But the diff said WM8750 iirc.
> 
> The issue being fixed is that the two devices are register compatible
> but for SPI we were only registering a device ID for wm8750, for I2C
> we'd got both IDs registered.  The driver says wm8750 everywhere except
> the device IDs.

Ah, ok - I would have just used WM8750 in subject instead.

Acked-by: Liam Girdwood <lrg@ti.com>
