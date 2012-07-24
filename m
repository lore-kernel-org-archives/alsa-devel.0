From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add DT bindings for cs4270
Date: Tue, 24 Jul 2012 16:01:34 -0600
Message-ID: <500F1B3E.1070804@wwwdotorg.org>
References: <1343161248-27557-1-git-send-email-zonque@gmail.com>
 <500F0407.8090807@freescale.com> <500F050D.6080505@gmail.com>
 <500F05CC.2000105@freescale.com> <500F0666.3030707@gmail.com>
 <500F07F9.8000408@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id A232E265D8B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 00:01:34 +0200 (CEST)
In-Reply-To: <500F07F9.8000408@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 07/24/2012 02:39 PM, Timur Tabi wrote:
> Daniel Mack wrote:
>> Yes, I'm aware of this, I just wonder how does your DT note looks like?
> 
> Take a look at arch/powerpc/boot/dts/mpc8610_hpcd.dts
> 
>> And are you ok with the 2nd patch?
> 
> Isn't that something that should be done in platform code?  It seems very
> platform-specific for a codec driver.  I have no problem using the CS4270
> on my board, and I don't need this feature.

Perhaps your board permanently ties the reset line to de-asserted, or
the bootloader/... deasserts the codecs reset pin before the kernel boots?
