From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCHv1 1/8] ALSA: Add SAI SoC Digital Audio Interface
 driver.
Date: Thu, 17 Oct 2013 08:37:25 -0500
Message-ID: <525FE815.1040300@tabi.org>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com> <1382000477-17304-2-git-send-email-Li.Xiubo@freescale.com> <525FD4C7.3050806@tabi.org> <525FD65B.3040004@metafoo.de> <525FE48B.7020709@tabi.org> <525FE728.90403@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <525FE728.90403@metafoo.de>
Sender: linux-doc-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Xiubo Li <Li.Xiubo@freescale.com>, r65073@freescale.com, lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org, tiwai@suse.de, b18965@freescale.com, LW@KARO-electronics.de, linux@arm.linux.org.uk, b42378@freescale.com, oskar@scara.com, grant.likely@linaro.org, devicetree@vger.kernel.org, ian.campbell@citrix.com, pawel.moll@arm.com, swarren@wwwdotorg.org, rob.herring@calxeda.com, linux-arm-kernel@lists.infradead.org, fabio.estevam@freescale.com, linux-kernel@vger.kernel.org, rob@landley.net, r64188@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Lars-Peter Clausen wrote:
>> >Maybe I've been out of the loop for too long, but why is that a particular
>> >problem with this driver?

> It is usually something you'd want to check in general to make sure that you
> don't have multiple device that access the same iomem region at the same time.

I understand that, but I'm trying to figure out why of_iomap() is okay 
for hundreds of other drivers, but not this one.  I've used it dozens of 
times myself, without ever worrying about overlapping regions.
