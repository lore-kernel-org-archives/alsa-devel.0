From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: how to use mcbsp for i2s?
Date: Thu, 2 Apr 2009 10:48:06 +0300
Message-ID: <bd7b27490904020048h672ce810j3c79868a7f5ef4e0@mail.gmail.com>
References: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f175.google.com (mail-bw0-f175.google.com
	[209.85.218.175])
	by alsa0.perex.cz (Postfix) with ESMTP id CDFD624480
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Apr 2009 09:48:07 +0200 (CEST)
Received: by bwz23 with SMTP id 23so387018bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2009 00:48:07 -0700 (PDT)
In-Reply-To: <fb44c3530904011129s7dd5cf1fgcf266fac3fb059d3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ernesto Torres <skullmate@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 1, 2009 at 9:29 PM, Ernesto Torres <skullmate@gmail.com> wrote:

> I'm currently working in adding an external codec to the beagleboard, so
> far
> the i2c control part is functional, now i want to use mcbsp3 to provide i2s
> transfers
>
> Is there any way to test the mcbsp to validate the connection?
>
> Also, I've done little modifications to the omap3beagle.c to change from
> mcbsp2 to mcbsp3, can someone validate this is correct?
>
> In:
> static int __init omap3beagle_soc_init(void)
>
> I changed to:
> *(unsigned int *)omap3beagle_dai.cpu_dai->private_data = 2; /* McBSP3 */
>
> It was:
> *(unsigned int *)omap3beagle_dai.cpu_dai->private_data = 1; /* McBSP2 */
>
> Is this correct? Or it should be changed in other places too?
>
> It is basically enough as well as setting correct DAI and clocking
configuration (if needed)
in omap3beagle_hw_params.

But by default McBSP1 and 3 which available in Beale pin header are muxed to
GPIO
so you need to mux those pins for McBSP by the bootloader and with
linux-omap
kernel multiplexing support.

I may have a hack patch somewhere... I'll try to find it and post it here
for reference.


Jarkko
