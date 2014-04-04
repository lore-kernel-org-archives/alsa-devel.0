From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/7] ASoC:davinci-mcasp: bc polarity fix
 and proper format support
Date: Fri, 04 Apr 2014 15:24:18 +0200
Message-ID: <533EB282.6080906@gmail.com>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 715882657DB
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 15:24:42 +0200 (CEST)
Received: by mail-bk0-f52.google.com with SMTP id my13so300532bkb.39
 for <alsa-devel@alsa-project.org>; Fri, 04 Apr 2014 06:24:40 -0700 (PDT)
In-Reply-To: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On 04/04/2014 01:31 PM, Peter Ujfalusi wrote:
> The bit clock polarity has been configured incorrectly in the McASP driver for a
> long time. IB_NF, NB_IF and IB_IF was not correct on the receive side since they
> were selecting the same edge as we used for the tx.
> 
> The driver only had support for DSP_B mode (and probably AC97, but I can not
> test that). All other formats were broken (DSP_A, I2S, LEFT_J, etc).

Well, we're using this driver in I2S mode for a number of devices since
a while, so the above statement is not entirely true :)

The cleanups look sane, though. I can test them on AM33xx based hardware
early next week. If you don't want to hold them off until then, no
problem. I can also send fixups in case I spot a regression.

Out of interest: which hardware and which dai format are you testing
this with?


Thanks,
Daniel
