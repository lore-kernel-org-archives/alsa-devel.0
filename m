From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Question regarding "Fix backport of WM8994 thermal
	warning" patch
Date: Fri, 4 Nov 2011 08:11:58 -0400
Message-ID: <CAJuYYwQ3Zbs1=Y2=ZW_re8EXdO4WVavvHBqEG7TsTqN26o4Dkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id E6136247F8
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 13:12:00 +0100 (CET)
Received: by ywp31 with SMTP id 31so2884228ywp.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2011 05:11:59 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I have a question regarding "Fix backport of WM8994 thermal warning" patch.

I am trying sound on Exynos4 smdk board with the latest 3.1 kernel. In
the function "wm8994_codec_probe", the kernel crashes due to null
pointer when requesting "Thermal Warning" interrupt (line# 3183 of
sound/soc/codecs/wm8994.c file). wm8994->control_data is actually NULL
at this point.

I have not debugged this much but if there is something obvious I am
missing, could you please let me know.

Thanks,
Thomas.
