From: Daniel Mack <zonque@gmail.com>
Subject: Re: Underrun on Jade controller...
Date: Fri, 23 Nov 2012 11:09:02 +0100
Message-ID: <50AF4B3E.9050003@gmail.com>
References: <1353665116.15462.YahooMailNeo@web120405.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 559C82616F3
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 11:09:05 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so3565049bkc.38
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 02:09:05 -0800 (PST)
In-Reply-To: <1353665116.15462.YahooMailNeo@web120405.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 23.11.2012 11:05, Sandulescu Bogdan wrote:
> I'm an User-Space application developer, using the ALSA library to
> play mixed sounds. My application (and for that matter also aplay)
> are having one underrun problem, and I need help on how to interpret
> the following debug information and receive some possible
> workarounds/solutions.
> 
> The underrun occurs only: once after writei() was performed with
> get_buffer_size bytes  written, and try to do another writei().
> 
> Target: Fujitsu Jade microcontroller
> 
> ALSA: 1.0.25
> 
> ALSA PCM interface for Jade-xxsvideo:
> /kernel/linux-2.6.31.4/sound/soc/xxsvideo/jade-pcm.c
> 
> DMA driver: /kernel/linux-2.6.31.4/arch/arm/mach-xxsvideo/dma.c

Neither the ARM platform code nor the ASoC parts are present in mainline.

> Here are the traces I managed to do, if there is any other
> information needed, please ask me for it.

Without providing any code, I guess nobody on this list will be able to
help you.


Daniel
