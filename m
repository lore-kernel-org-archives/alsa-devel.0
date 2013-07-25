From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RFC: support for 12 & 24Khz
Date: Thu, 25 Jul 2013 08:50:40 +0200
Message-ID: <51F0CAC0.9090702@ladisch.de>
References: <20130724172640.GE18642@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 6A6972655A0
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 08:50:43 +0200 (CEST)
In-Reply-To: <20130724172640.GE18642@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, pierre-louis.bossart@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

Vinod Koul wrote:
> For compressed audio we also need to support the PCM rates of 12 and 24KHz.
>
> Looking at pcm.h these are not defined

You don't need such symbols to use a rate.  These symbols are intended
for often-used rates.  As long as only one or two drivers use a rate,
they can just set KNOT and install a constraint.

> But am worried about wider impact of adding these rates.
>
> Can you let me know if more is required to be done or below is fine

Grep for 176400 in sound/core/, include/, and in alsa-lib.


Regards,
Clemens
