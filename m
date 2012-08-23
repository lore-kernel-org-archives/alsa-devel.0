From: Dong Aisheng <b29396@freescale.com>
Subject: Re: SAIF configuration on imx28
Date: Thu, 23 Aug 2012 14:48:45 +0800
Message-ID: <20120823064844.GD10057@shlinux2.ap.freescale.net>
References: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
 <CAOMZO5C9ezzU7S0M-AN0f8gk7SBWs3WNbA6cG2S+7BF8j+dVxA@mail.gmail.com>
 <CAACwSTKiN17gAHnUs5BoHZH_K5NNo0z7X9QbVRFu9FZGCUw2mg@mail.gmail.com>
 <CAACwST+=owJQ+KGAKYLgpGY4k1hGNSC4ptSGMyVObSRpUightQ@mail.gmail.com>
 <CAOMZO5BGiU7J6W8TSybe8ELqnfLD=SYf9c_uVz6ppb4E2MOnzw@mail.gmail.com>
 <CAACwSTKkNFw9kC54VJ8en+tWpO9vpnHsszfyDtufWDeWhZCY5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 28FBD2652CA
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 09:08:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAACwSTKkNFw9kC54VJ8en+tWpO9vpnHsszfyDtufWDeWhZCY5Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: George Stefan <stefan.george87@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Fabio Estevam <festevam@gmail.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 23, 2012 at 02:41:30PM +0800, George Stefan wrote:
...
>    /*set the saif clk mux, saif0/saif1 both use saif0 clk*/
>    __raw_writel(BF_DIGCTL_CTRL_SAIF_CLKMUX_SEL(0x0),               \
Should this be 0x2 if both saif0 and saif1 are using saif0 clk?

>    IO_ADDRESS(DIGCTL_PHYS_ADDR) + HW_DIGCTL_CTRL);
>    Using this configuration i am not able to receive IRQs from DMA and i
>    think the reason
>    is that SAIF is not receiving the CLK.
>    What do you think?
>    Thanks,
>    George.

Regards
Dong Aisheng
