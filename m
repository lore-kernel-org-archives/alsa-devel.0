From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: introduce SOC_SINGLE_S8_TLV macro
Date: Sun, 8 Jan 2012 12:23:36 -0800
Message-ID: <20120108202332.GE29065@opensource.wolfsonmicro.com>
References: <1325987606-7179-1-git-send-email-plai@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6572010392D
	for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2012 21:23:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325987606-7179-1-git-send-email-plai@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 07, 2012 at 05:53:26PM -0800, Patrick Lai wrote:
> ASoC currently has macro for double 8-bit signed TLV.
> Enhance info,get,put callback functions of SOC_DOUBLE_S8_TLV
> for single single 8-bit signed TLV.

Actually now I look at this I'm not sure that the existing macro isn't
just misnamed:

| #define SOC_DOUBLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \

Since no shifts are specified the signature is just the same as your
SOC_SINGLE_S8_TLV:

> +#define SOC_SINGLE_S8_TLV(xname, xreg, xmin, xmax, tlv_array) \

so it looks like what really ought to happen here is that the existing
macro gets renamed to the new macro and a new macro gets defined for
double values if one is needed.
