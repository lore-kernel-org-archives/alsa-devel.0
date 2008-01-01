From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Tue, 1 Jan 2008 12:25:32 -0500
Message-ID: <9e4733910801010925j67192427o4e0e824b9d7e0ad0@mail.gmail.com>
References: <11981089894052-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 715B2244C4
	for <alsa-devel@alsa-project.org>; Tue,  1 Jan 2008 18:25:34 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so8037755wag.8
	for <alsa-devel@alsa-project.org>; Tue, 01 Jan 2008 09:25:32 -0800 (PST)
In-Reply-To: <11981089894052-git-send-email-timur@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/19/07, Timur Tabi <timur@freescale.com> wrote:
> +               ssi@16000 {
> +                       compatible = "fsl,ssi";
> +                       cell-index = <0>;
> +                       reg = <16000 100>;
> +                       interrupt-parent = <&mpic>;
> +                       interrupts = <3e 2>;
> +                       fsl,mode = "i2s-slave";
> +                       codec {
> +                               compatible = "cirrus,cs4270";
> +                               /* MCLK source is a stand-alone oscillator */
> +                               bus-frequency = <bb8000>;
> +                       };
> +               };

Does this need to be bus-frequency? It's always called MCLK in all of
the literature.

In my case the MCLK comes from a chip on the i2c bus that is
programmable How would that be encoded?.

-- 
Jon Smirl
jonsmirl@gmail.com
