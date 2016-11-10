From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: samsung: Remove unselectable
	smdk_wm8580pcm
Date: Thu, 10 Nov 2016 10:31:09 +0100
Message-ID: <7ce31202-6bc8-46ca-7d40-30a439dcc1b1@samsung.com>
References: <CGME20161109184522epcas3p1b6a61f251627a16ba38c4a5c68a357c8@epcas3p1.samsung.com>
 <1478717110-18108-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14])
 by alsa0.perex.cz (Postfix) with ESMTP id F0B0826731A
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2016 10:31:15 +0100 (CET)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5 2014))
 with ESMTP id <0OGF00JGD6G0WI60@mailout4.w1.samsung.com> for
 alsa-devel@alsa-project.org; Thu, 10 Nov 2016 09:31:12 +0000 (GMT)
In-reply-to: <1478717110-18108-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, alsa-devel@alsa-project.org, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/09/2016 07:45 PM, Lars-Peter Clausen wrote:
> The SND_SOC_SMDK_WM8580_PCM Kconfig entry depends on either MACH_SMDKV210
> or MACH_SMDKC110. Both of which were removed in commit 28c8331d386a ("ARM:
> S5PV210: Remove support for board files") over two years ago. The driver
> has been unselectable ever since.
> 
> Considering the lack of complaints about this it can be concluded that the
> driver is unused and can be removed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

This driver should be converted to work in DT mode, but there seem to
have been no interest indeed in having it working properly in mainline
for a quite long time so I think it's a good idea to just drop this code
now.

Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
