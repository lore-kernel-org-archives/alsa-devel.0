From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] ALSA: ASoC: cs4271: add DT property for
 AMUTEB=BMUTEC feature
Date: Thu, 04 Oct 2012 13:58:11 +0200
Message-ID: <506D79D3.6020803@gmail.com>
References: <1349351639-17506-1-git-send-email-zonque@gmail.com>
 <20121004115608.GN4360@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A4D5A261616
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 13:58:18 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so210222bku.38
 for <alsa-devel@alsa-project.org>; Thu, 04 Oct 2012 04:58:18 -0700 (PDT)
In-Reply-To: <20121004115608.GN4360@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Alexander Sverdlin <subaparts@yandex.ru>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 04.10.2012 13:56, Mark Brown wrote:
> On Thu, Oct 04, 2012 at 01:53:59PM +0200, Daniel Mack wrote:
>> The CS4271 has a feature to sync its analog mute flags, so one mute
>> circuitry can be used for both channels.
>>
>> Give DT uses access to this feature with a new property.
> 
> Is there some reason not to add this to the platform data while we're at
> it?
> 

Well, no :) Can do that, just a sec.


Daniel
