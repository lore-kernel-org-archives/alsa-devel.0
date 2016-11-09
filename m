From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] ASoC: samsung: Remove unselectable
	smdk_wm8580pcm
Date: Wed, 9 Nov 2016 22:43:50 +0200
Message-ID: <20161109204350.GA16290@kozik-lap>
References: <1478717110-18108-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 609B32671C5
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 21:43:54 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id u144so31583580wmu.0
 for <alsa-devel@alsa-project.org>; Wed, 09 Nov 2016 12:43:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1478717110-18108-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 09, 2016 at 07:45:10PM +0100, Lars-Peter Clausen wrote:
> The SND_SOC_SMDK_WM8580_PCM Kconfig entry depends on either MACH_SMDKV210
> or MACH_SMDKC110. Both of which were removed in commit 28c8331d386a ("ARM:
> S5PV210: Remove support for board files") over two years ago. The driver
> has been unselectable ever since.

The boards were converted to DT-only thus there are no MACH_xxx
symbols. They are still supporter... but actually it does not matter
because the machine_is_smdkc110() calls will return false on DT-based
platform.

I see there is even more to cleanup of these old MACH symbols.

Anyway:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
