From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ASoC: sta350: Add codec driver
Date: Thu, 27 Mar 2014 20:43:12 +0100
Message-ID: <53347F50.5020303@gmail.com>
References: <1395937082-28202-1-git-send-email-zonque@gmail.com>
 <20140327172127.GS30768@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ABE52618F2
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 20:43:16 +0100 (CET)
Received: by mail-bk0-f48.google.com with SMTP id mx12so820051bkb.35
 for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2014 12:43:15 -0700 (PDT)
In-Reply-To: <20140327172127.GS30768@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, neumann@teufel.de, brandau@gmx.de
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 03/27/2014 06:21 PM, Mark Brown wrote:
> On Thu, Mar 27, 2014 at 05:18:02PM +0100, Daniel Mack wrote:
>> From: Sven Brandau <brandau@gmx.de>
>>
>> The TI STA350 is an integrated 2.1-channel power amplifier that is
>> controllable over I2C. This patch adds an ASoC driver for it.
>>
>> At a glance, this chip is very similar to the STA320 for which a driver
>> already exists. In details, however, the register maps contain subtle
>> differences which made a whole new driver easier to write and maintain.
> 
> A few issues below, some may already be present in the sta320 driver,
> generally newer idioms and so on, but that's no reason to not fix them
> here!

Thanks a lot for your review! Much appreciated.

All points are agreed upon, and are already fixed locally. Will send a
v2 soon.


Daniel
