From: Chemsi Mehdi <chmsmehdi@gmail.com>
Subject: Is snd_pcm_hw_constraint_mask64 really needed ?
Date: Thu, 9 Mar 2017 17:23:46 +0100
Message-ID: <CAHkWnPZu3a5WdsXzF8_faxdoYPOuSgcqkAu3tX_EL4VCczqYqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f180.google.com (mail-qk0-f180.google.com
 [209.85.220.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D0BF267028
 for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2017 17:23:47 +0100 (CET)
Received: by mail-qk0-f180.google.com with SMTP id v125so124375717qkh.2
 for <alsa-devel@alsa-project.org>; Thu, 09 Mar 2017 08:23:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA expert ,


I am working with an alsa codec driver  where the driver is calling
err = snd_pcm_hw_constraint_mask64(substream->runtime,
SNDRV_PCM_HW_PARAM_FORMAT, formats);
my driver is already setting format before that so I wonder why this
function is called?
Looks like it is  needed to add audio constraints to substreams at
open/startup time, but why ?
what can be the issue if I do not call it ?

Please explain to me Takashi.

Thanks a lot in advance.
