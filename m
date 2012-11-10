From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4271: free allocated GPIO
Date: Sat, 10 Nov 2012 19:52:06 +0100
Message-ID: <509EA256.6050009@gmail.com>
References: <1352294155-6733-1-git-send-email-zonque@gmail.com>
 <20121107140720.GB28954@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A57C326166D
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 19:53:06 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so124588bkc.38
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 10:53:06 -0800 (PST)
In-Reply-To: <20121107140720.GB28954@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Alexander Sverdlin <subaparts@yandex.ru>
List-Id: alsa-devel@alsa-project.org

On 07.11.2012 15:07, Mark Brown wrote:
> On Wed, Nov 07, 2012 at 02:15:55PM +0100, Daniel Mack wrote:
>> In case of probe deferral, the allocated GPIO line is not freed, which
>> prevents it from being claimed and properly asserted in later attempts.
>>
>> Fix this by freeing the GPIO in case of errors.
> 
> Can we convert to devm_gpio_request_one() instead?
> 

Sure, that's much nicer.
