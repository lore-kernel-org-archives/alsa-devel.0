From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: Question regarding "Fix backport of WM8994 thermal
	warning" patch
Date: Fri, 4 Nov 2011 12:03:35 -0400
Message-ID: <CAJuYYwTygac=+V5XwYhn5ra8os6wjqGME1ssDF-O0Y+8XGT2Kg@mail.gmail.com>
References: <CAJuYYwQ3Zbs1=Y2=ZW_re8EXdO4WVavvHBqEG7TsTqN26o4Dkw@mail.gmail.com>
	<20111104155828.GA28902@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 05EA1248AF
	for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2011 17:03:38 +0100 (CET)
Received: by ywp31 with SMTP id 31so3140226ywp.38
	for <alsa-devel@alsa-project.org>; Fri, 04 Nov 2011 09:03:35 -0700 (PDT)
In-Reply-To: <20111104155828.GA28902@opensource.wolfsonmicro.com>
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

On 4 November 2011 11:58, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Nov 04, 2011 at 08:11:58AM -0400, Thomas Abraham wrote:
>
>> I am trying sound on Exynos4 smdk board with the latest 3.1 kernel. In
>
> Do you mean the latest mainline? =A0The thermal warning support was only
> implemented for v3.1 and the line numbers only match up with mainline.

Yes. I was referring to the latest mainline. I incorrectly wrote 3.1 above.

>
>> the function "wm8994_codec_probe", the kernel crashes due to null
>> pointer when requesting "Thermal Warning" interrupt (line# 3183 of
>> sound/soc/codecs/wm8994.c file). wm8994->control_data is actually NULL
>> at this point.
>
> This is just a straight bug, I'll post a patch.
>

Thanks for the patch. I will try again with those patches.

Regards,
Thomas.
