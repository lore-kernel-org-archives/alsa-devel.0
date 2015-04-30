From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [alsa-devel] [PATCH v4 1/2] extcon: arizona: Add support for
 select accessory detect mode when headphone detection
Date: Thu, 30 Apr 2015 19:16:04 +0900
Message-ID: <554200E4.8000902@samsung.com>
References: <1430357878-22859-1-git-send-email-ideal.song@samsung.com>
 <1430357878-22859-2-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1430357878-22859-2-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk
List-Id: alsa-devel@alsa-project.org

Hi Inha,

On 04/30/2015 10:37 AM, Inha Song wrote:
> This patch add support for select accessory detect mode to HPDETL or HPDETR.
> Arizona provides a headphone detection circuit on the HPDETL and HPDETR pins
> to measure the impedance of an external load connected to the headphone.
> 
> Depending on board design, headphone detect pins can change to HPDETR or HPDETL.
> 
> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  drivers/extcon/extcon-arizona.c   | 38 ++++++++++++++++++++++++++++++--------
>  include/dt-bindings/mfd/arizona.h |  8 ++++++++
>  include/linux/mfd/arizona/pdata.h |  3 +++
>  3 files changed, 41 insertions(+), 8 deletions(-)
>  create mode 100644 include/dt-bindings/mfd/arizona.h

This patch has a conflict to apply it on extcon-next branch.
I prefer that you rebase this patch-set on extcon-next and resend it.

Thanks,
Chanwoo Choi
