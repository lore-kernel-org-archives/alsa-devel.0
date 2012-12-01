From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH - hdsp.c 1/1] HDSP fixes for RPM
Date: Sat, 01 Dec 2012 23:10:01 +0100
Message-ID: <50BA8039.6080604@drcomp.erfurt.thur.de>
References: <1353533632.2957.10.camel@chello084112006029.chello.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id A1F55261743
 for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2012 23:10:02 +0100 (CET)
In-Reply-To: <1353533632.2957.10.camel@chello084112006029.chello.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Karl Grill <kgrill@chello.at>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 11/21/2012 10:33 PM, Karl Grill wrote:

> -		hdsp_write (hdsp, HDSP_control2Reg, HDSP_PROGRAM);
> +		hdsp_write (hdsp, HDSP_control2Reg, 0x10a0);

Where did you get the constant(s) from? Bus snooping?

> +		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
> +			hdsp->io_type=Multiface;
> +		snd_printk("Hammerfall-DSP: Multiface found\n");
> +			return 0;
> +		}
> +		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
> +		hdsp_write (hdsp, HDSP_fifoData, 0);
> +		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) == 0) {
> +			hdsp->io_type=Digiface;
> +		snd_printk("Hammerfall-DSP: Digiface found\n");
> +			return 0;
> +		}
> +		hdsp_write(hdsp, HDSP_control2Reg, 0x900);
> +		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
> +		hdsp_write (hdsp, HDSP_fifoData, 0);
> +		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) == 0) {
> +			hdsp->io_type=Multiface;
> +		snd_printk("Hammerfall-DSP: Multiface found\n");
> +			return 0;
> +		}
> +		hdsp_write(hdsp, HDSP_control2Reg, 0x900);
> +		hdsp_write(hdsp, HDSP_control2Reg, 0x10a0);
> +		hdsp_write (hdsp, HDSP_fifoData, 0);
> +		if (hdsp_fifo_wait (hdsp, 0, HDSP_SHORT_WAIT) < 0) {
> +			hdsp->io_type=Multiface;
> +		snd_printk("Hammerfall-DSP: Multiface found\n");
> +			return 0;
>  		}
> +		hdsp->io_type=RPM;
> +		snd_printk("Hammerfall-DSP: RPM found\n");
> +                return 0;
> +			

Question: I see two sequences of 0x900, 0x10a0 that detect the
Multiface. Is the duplicate intended or just a copy&paste error?


Cheers
