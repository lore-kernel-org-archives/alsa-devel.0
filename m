From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v3 1/3] ASoC: codecs: adau1701: allow
 configuration of PLL mode pins
Date: Fri, 21 Jun 2013 19:46:18 +0200
Message-ID: <51C4916A.3080008@gmail.com>
References: <1371801284-31603-1-git-send-email-zonque@gmail.com>
 <1371801284-31603-2-git-send-email-zonque@gmail.com>
 <20130621150019.GZ27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f176.google.com (mail-ea0-f176.google.com
 [209.85.215.176])
 by alsa0.perex.cz (Postfix) with ESMTP id F3A3526162A
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 19:45:45 +0200 (CEST)
Received: by mail-ea0-f176.google.com with SMTP id z15so4798214ead.35
 for <alsa-devel@alsa-project.org>; Fri, 21 Jun 2013 10:45:45 -0700 (PDT)
In-Reply-To: <20130621150019.GZ27646@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On 21.06.2013 17:00, Mark Brown wrote:
> On Fri, Jun 21, 2013 at 09:54:42AM +0200, Daniel Mack wrote:
> 
>> To avoid excessive reset cycles and firmware downloads, the default
>> clock divider can be specified in DT as well. Whenever a ratio change is
>> detected in the hw_params callback, the PLL mode lines are updates and a
>> full reset cycle is issued.
> 
> Why isn't it enough to just use the first setting we see - I'd expect
> the device to normally be powered off before audio starts including when
> hw_params() is called?
> 

Hmm, then we would postpone the firmware download to the first hw_params
call in all cases. That could also work, but it'll need some rework.
I'll post new patches the next days.


Daniel
