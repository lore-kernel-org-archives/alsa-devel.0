From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question regarding "Fix backport of WM8994 thermal
	warning" patch
Date: Fri, 4 Nov 2011 15:58:29 +0000
Message-ID: <20111104155828.GA28902@opensource.wolfsonmicro.com>
References: <CAJuYYwQ3Zbs1=Y2=ZW_re8EXdO4WVavvHBqEG7TsTqN26o4Dkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1D24C248A7
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 16:58:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAJuYYwQ3Zbs1=Y2=ZW_re8EXdO4WVavvHBqEG7TsTqN26o4Dkw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 04, 2011 at 08:11:58AM -0400, Thomas Abraham wrote:

> I am trying sound on Exynos4 smdk board with the latest 3.1 kernel. In

Do you mean the latest mainline?  The thermal warning support was only
implemented for v3.1 and the line numbers only match up with mainline.

> the function "wm8994_codec_probe", the kernel crashes due to null
> pointer when requesting "Thermal Warning" interrupt (line# 3183 of
> sound/soc/codecs/wm8994.c file). wm8994->control_data is actually NULL
> at this point.

This is just a straight bug, I'll post a patch.
