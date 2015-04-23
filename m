From: "Austin, Brian" <Brian.Austin@cirrus.com>
Subject: Re: [PATCH 8/8] Documentation: Add WM8998/WM1814
 device	tree bindings
Date: Thu, 23 Apr 2015 02:05:18 +0000
Message-ID: <0D842736-8A6E-4462-9690-C9BD60690A7C@cirrus.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>,
 <1429619636-25478-9-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m0077473.ppops.net (mx0a-001ae601.pphosted.com [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A9287265A30
 for <alsa-devel@alsa-project.org>; Thu, 23 Apr 2015 04:05:21 +0200 (CEST)
In-Reply-To: <1429619636-25478-9-git-send-email-rf@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fitzgerald, Richard" <Richard.Fitzgerald@cirrus.com>
Cc: "gnurou@gmail.com" <gnurou@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cw00.choi@samsung.com" <cw00.choi@samsung.com>, "broonie@kernel.org" <broonie@kernel.org>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "ckeepax@opensource.wolfsonmicro.com" <ckeepax@opensource.wolfsonmicro.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>
List-Id: alsa-devel@alsa-project.org



> On Apr 21, 2015, at 07:38, Richard Fitzgerald <rf@opensource.wolfsonmicro.com> wrote:
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
> Documentation/devicetree/bindings/mfd/arizona.txt |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> index 7665aa9..a3cb34b 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -10,6 +10,9 @@ Required properties:
>         "wlf,wm5110"
>         "wlf,wm8280"
>         "wlf,wm8997"
> +        "wlf,WM8998"
> +        "wlf,wm1814"
> +
Is there a reason for caps on the 8998? 

-Brian 
